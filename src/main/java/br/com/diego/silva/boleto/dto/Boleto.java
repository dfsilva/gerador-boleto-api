package br.com.diego.silva.boleto.dto;


import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;

public class Boleto implements Serializable {

    private static final long serialVersionUID = 1L;

    private String numeroFormatadoComDigito;
    private String linhaDigitavel;
    private String nomePagador;
    private String documentoPagador;
    private String documentoBeneficiario;
    private String nomeBeneficiario;
    private String enderecoBeneficiario;
    private Calendar vencimento;
    private BigDecimal valorCobrado;
    private String codigoDeBarras;


    public Boleto() {
    }

    public String getNumeroFormatadoComDigito() {
        return numeroFormatadoComDigito;
    }

    public void setNumeroFormatadoComDigito(String numeroFormatadoComDigito) {
        this.numeroFormatadoComDigito = numeroFormatadoComDigito;
    }

    public String getLinhaDigitavel() {
        return linhaDigitavel;
    }

    public void setLinhaDigitavel(String linhaDigitavel) {
        this.linhaDigitavel = linhaDigitavel;
    }

    public String getNomePagador() {
        return nomePagador;
    }

    public void setNomePagador(String nomePagador) {
        this.nomePagador = nomePagador;
    }

    public String getDocumentoPagador() {
        return documentoPagador;
    }

    public void setDocumentoPagador(String documentoPagador) {
        this.documentoPagador = documentoPagador;
    }

    public String getDocumentoBeneficiario() {
        return documentoBeneficiario;
    }

    public void setDocumentoBeneficiario(String documentoBeneficiario) {
        this.documentoBeneficiario = documentoBeneficiario;
    }

    public String getNomeBeneficiario() {
        return nomeBeneficiario;
    }

    public void setNomeBeneficiario(String nomeBeneficiario) {
        this.nomeBeneficiario = nomeBeneficiario;
    }

    public String getEnderecoBeneficiario() {
        return enderecoBeneficiario;
    }

    public void setEnderecoBeneficiario(String enderecoBeneficiario) {
        this.enderecoBeneficiario = enderecoBeneficiario;
    }

    public Calendar getVencimento() {
        return vencimento;
    }

    public void setVencimento(Calendar vencimento) {
        this.vencimento = vencimento;
    }

    public BigDecimal getValorCobrado() {
        return valorCobrado;
    }

    public void setValorCobrado(BigDecimal valorCobrado) {
        this.valorCobrado = valorCobrado;
    }

    public String getCodigoDeBarras() {
        return codigoDeBarras;
    }

    public void setCodigoDeBarras(String codigoDeBarras) {
        this.codigoDeBarras = codigoDeBarras;
    }
}
