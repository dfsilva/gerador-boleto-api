package br.com.diego.silva.boleto.dto;

import java.io.Serializable;
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

}
