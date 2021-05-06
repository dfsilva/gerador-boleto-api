package br.com.diego.silva.boleto.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public class BoletoDTO implements Serializable {

    public String linhaDigitavel;

    public LocalDate dataDocumento;
    public LocalDate dataProcessamento;
    public LocalDate dataVencimento;

    public String nomePagador;
    public String documentoPagador;
    public String logradouroPagador;
    public String bairroPagador;
    public String cepPagador;
    public String cidadePagador;
    public String ufPagador;

    public String nomeBeneficiario;
    public String documentoBeneficiario;
    public String logradouroBeneficiario;
    public String bairroBeneficiario;
    public String cepBeneficiario;
    public String cidadeBeneficiario;
    public String ufBeneficiario;

    public BigDecimal valor;
    public String numeroDocumento;

    public String instrucaoLinha1;
    public String instrucaoLinha2;
    public String instrucaoLinha3;
    public String instrucaoLinha4;
    public String instrucaoLinha5;

    public String localPagamento;

}
