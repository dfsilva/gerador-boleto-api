package br.com.diego.silva.boleto;

import br.com.caelum.stella.boleto.*;
import br.com.caelum.stella.boleto.bancos.Bradesco;
import br.com.caelum.stella.boleto.transformer.GeradorDeBoleto;
import br.com.diego.silva.boleto.dto.ErrorDTO;
import com.google.gson.Gson;
import spark.servlet.SparkApplication;

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

        exception(Exception.class, (exception, request, response) -> {
            exception.printStackTrace();
            response.status(500);
            response.body(new Gson().toJson(new ErrorDTO(exception.getMessage(), 500)));
        });

        internalServerError((request, response) -> {
            response.status(500);
            return new Gson().toJson(new ErrorDTO("Tivemos um problema, tente novamente mais tarde.", 500));
        });


//        get("/boleto-exemplo", (request, response) -> {
//
//            Boleto boleto = new Boleto();
//            boleto.setCodigoDeBarras();
//
//            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(List.of(boleto));
//
//            InputStream templateJasper = Main.class.getResourceAsStream("templates/boleto-sem-sacador-avalista.jasper");
//            Map<String,Object> parametros = Map.of(JRParameter.REPORT_LOCALE, new Locale("pt", "BR"));
//
//            JasperPrint relatorio = JasperFillManager.fillReport(templateJasper, parametros, dataSource);
//            response.type("application/pdf");
//            return JasperExportManager.exportReportToPdf(relatorio);
//        });


        get("/boleto-exemplo", (request, response) -> {


            Datas datas = Datas.novasDatas()
                    .comDocumento(9, 4, 2021)
                    .comProcessamento(9, 4, 2021)
                    .comVencimento(12, 4, 2021);

            Endereco enderecoBeneficiario = Endereco.novoEndereco()
                    .comLogradouro("Av das Empresas, 555")
                    .comBairro("Bairro Grande")
                    .comCep("01234-555")
                    .comCidade("São Paulo")
                    .comUf("SP");

            //Quem emite o boleto
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

            //Quem paga o boleto
            Pagador pagador = Pagador.novoPagador()
                    .comNome("Janaina Martins da Silva")
                    .comDocumento("01258701162")
                    .comEndereco(Endereco.novoEndereco()
                            .comLogradouro("QNJ 22 31")
                            .comBairro("Taguatinga Norte")
                            .comCep("72140220")
                            .comCidade("Brasília")
                            .comUf("DF"));


            var linhaDigitavel = "23793381286005649858173000063302185880000136576";
            Banco banco = new Bradesco(getCodigoBarra(linhaDigitavel));

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

    private static String getCodigoBarra(String linhaDigitavel) {
        StringBuilder retorno = new StringBuilder();
        retorno.append(linhaDigitavel, 0, 4);
        retorno.append(linhaDigitavel, 32, 47);
        retorno.append(linhaDigitavel, 4, 9);
        retorno.append(linhaDigitavel, 10, 20);
        retorno.append(linhaDigitavel, 21, 31);
        return retorno.toString();
    }

}
