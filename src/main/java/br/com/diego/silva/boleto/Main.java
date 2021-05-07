package br.com.diego.silva.boleto;

import br.com.caelum.stella.boleto.*;
import br.com.caelum.stella.boleto.bancos.Bradesco;
import br.com.caelum.stella.boleto.transformer.GeradorDeBoleto;
import br.com.diego.silva.boleto.dto.BoletoDTO;
import br.com.diego.silva.boleto.dto.ErrorDTO;
import br.com.diego.silva.boleto.utils.BoletoUtils;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import spark.servlet.SparkApplication;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import static spark.Spark.*;

public class Main implements SparkApplication {

    public static void main(String[] args) {
        new Main().init();
    }

    @Override
    public void init() {

        staticFileLocation("/web");

        port(8080);

        options("/*",
                (request, response) -> {

                    String accessControlRequestHeaders = request
                            .headers("Access-Control-Request-Headers");
                    if (accessControlRequestHeaders != null) {
                        response.header("Access-Control-Allow-Headers",
                                accessControlRequestHeaders);
                    }

                    String accessControlRequestMethod = request
                            .headers("Access-Control-Request-Method");
                    if (accessControlRequestMethod != null) {
                        response.header("Access-Control-Allow-Methods",
                                accessControlRequestMethod);
                    }

                    return "OK";
                });

        before((request, response) -> response.header("Access-Control-Allow-Origin", "*"));

        exception(Exception.class, (exception, request, response) -> {
            exception.printStackTrace();
            response.status(500);
            response.body(new Gson().toJson(new ErrorDTO(exception.getMessage(), 500)));
        });

        internalServerError((request, response) -> {
            response.status(500);
            return new Gson().toJson(new ErrorDTO("Tivemos um problema, tente novamente mais tarde.", 500));
        });


        post("/gerar-boleto", (request, response) -> {

            BoletoDTO dto = new GsonBuilder().registerTypeAdapter(LocalDate.class, (JsonDeserializer<LocalDate>) (json, type, jsonDeserializationContext) -> LocalDate.parse(json.getAsJsonPrimitive().getAsString(), DateTimeFormatter.ofPattern("dd/MM/yyyy"))).create()
                    .fromJson(request.body(), BoletoDTO.class);

            Datas datas = Datas.novasDatas()
                    .comDocumento(dto.dataDocumento.getDayOfMonth(),
                            dto.dataDocumento.getMonthValue(),
                            dto.dataDocumento.getYear())
                    .comProcessamento(dto.dataProcessamento.getDayOfMonth(),
                            dto.dataProcessamento.getMonthValue(),
                            dto.dataProcessamento.getYear())
                    .comVencimento(dto.dataVencimento.getDayOfMonth(),
                            dto.dataVencimento.getMonthValue(),
                            dto.dataVencimento.getYear());

            Pagador pagador = Pagador.novoPagador()
                    .comNome(dto.nomePagador)
                    .comDocumento(dto.documentoPagador)
                    .comEndereco(Endereco.novoEndereco()
                            .comLogradouro(dto.logradouroPagador)
                            .comBairro(dto.bairroPagador)
                            .comCep(dto.cepPagador)
                            .comCidade(dto.cidadePagador)
                            .comUf(dto.ufPagador));

            Beneficiario beneficiario = Beneficiario.novoBeneficiario()
                    .comNomeBeneficiario(dto.nomeBeneficiario)
                    .comDocumento(dto.documentoBeneficiario)
                    .comAgencia("1")
                    .comDigitoAgencia("0")
                    .comCodigoBeneficiario("1435")
                    .comDigitoCodigoBeneficiario("0")
                    .comNumeroConvenio("5897")
                    .comCarteira("36")
                    .comEndereco(Endereco.novoEndereco()
                            .comLogradouro(dto.logradouroBeneficiario)
                            .comBairro(dto.bairroBeneficiario)
                            .comCep(dto.cepBeneficiario)
                            .comCidade(dto.cidadeBeneficiario)
                            .comUf(dto.ufBeneficiario))
                    .comNossoNumero("26")
                    .comDigitoNossoNumero("0");

            Banco banco = new Bradesco(BoletoUtils.getBarcodeFromDigitableLine(dto.linhaDigitavel));
            Boleto boleto = Boleto.novoBoleto()
                    .comBanco(banco)
                    .comDatas(datas)
                    .comBeneficiario(beneficiario)
                    .comPagador(pagador)
                    .comValorBoleto(dto.valor)
                    .comEspecieDocumento("DM")
                    .comNumeroDoDocumento(dto.numeroDocumento)
                    .comInstrucoes(dto.instrucaoLinha1,
                            dto.instrucaoLinha2,
                            dto.instrucaoLinha3,
                            dto.instrucaoLinha4,
                            dto.instrucaoLinha5)
                    .comLocaisDePagamento(dto.localPagamento);

            GeradorDeBoleto gerador = new GeradorDeBoleto(boleto);

            response.type("application/pdf");
            return gerador.geraPDF();
        });

    }


}
