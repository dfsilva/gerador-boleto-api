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

        port(8080);

        staticFileLocation("/web");

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

            BoletoDTO boletoDto = new GsonBuilder().registerTypeAdapter(LocalDate.class, (JsonDeserializer<LocalDate>) (json, type, jsonDeserializationContext) -> LocalDate.parse(json.getAsJsonPrimitive().getAsString(), DateTimeFormatter.ofPattern("dd/MM/yyyy"))).create()
                    .fromJson(request.body(), BoletoDTO.class);

            Datas datas = Datas.novasDatas()
                    .comDocumento(boletoDto.dataDocumento.getDayOfMonth(),
                            boletoDto.dataDocumento.getMonthValue(),
                            boletoDto.dataDocumento.getYear())
                    .comProcessamento(boletoDto.dataProcessamento.getDayOfMonth(),
                            boletoDto.dataProcessamento.getMonthValue(),
                            boletoDto.dataProcessamento.getYear())
                    .comVencimento(boletoDto.dataVencimento.getDayOfMonth(),
                            boletoDto.dataVencimento.getMonthValue(),
                            boletoDto.dataVencimento.getYear());

            Endereco enderecoBeneficiario = Endereco.novoEndereco()
                    .comLogradouro("Av das Empresas, 555")
                    .comBairro("Bairro Grande")
                    .comCep("01234-555")
                    .comCidade("São Paulo")
                    .comUf("SP");

            Beneficiario beneficiario = Beneficiario.novoBeneficiario()
                    .comNomeBeneficiario("QUALICORP ADM. E SERV. LTDA")
                    .comDocumento("18236120000158")
                    .comAgencia("1")
                    .comDigitoAgencia("0")
                    .comCodigoBeneficiario("1435")
                    .comDigitoCodigoBeneficiario("0")
                    .comNumeroConvenio("5897")
                    .comCarteira("36")
                    .comEndereco(enderecoBeneficiario)
                    .comNossoNumero("26")
                    .comDigitoNossoNumero("0");

            Pagador pagador = Pagador.novoPagador()
                    .comNome(boletoDto.nomePagador)
                    .comDocumento(boletoDto.documentoPagador)
                    .comEndereco(Endereco.novoEndereco()
                            .comLogradouro(boletoDto.logradouroPagador)
                            .comBairro(boletoDto.bairroPagador)
                            .comCep(boletoDto.cepPagador)
                            .comCidade(boletoDto.cidadePagador)
                            .comUf(boletoDto.ufPagador));

            Banco banco = new Bradesco(BoletoUtils.getBarcodeFromDigitableLine(boletoDto.linhaDigitavel));
            Boleto boleto = Boleto.novoBoleto()
                    .comBanco(banco)
                    .comDatas(datas)
                    .comBeneficiario(beneficiario)
                    .comPagador(pagador)
                    .comValorBoleto("1365.76")
                    .comEspecieDocumento("DM")
                    .comNumeroDoDocumento("564985873")
                    .comInstrucoes("Mensalidade de recomposicao anual (3/12) R$ 46,84",
                            "Mensalidade de recomposicao anual (3/12) R$ 46,84",
                            "Sr. Caixa:", "1) Não aceitar pagamento em cheque;",
                            "Não aceitar mais de um pagamento com o mesmo boleto;")
                    .comLocaisDePagamento("local 1", "local 2");

            GeradorDeBoleto gerador = new GeradorDeBoleto(boleto);

            response.type("application/pdf");
            return gerador.geraPDF();
        });

    }


}
