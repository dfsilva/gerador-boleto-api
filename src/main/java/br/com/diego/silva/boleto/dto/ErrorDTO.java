package br.com.diego.silva.boleto.dto;

public class ErrorDTO {

    public String message;
    public int code;

    public ErrorDTO(String message, int code) {
        this.message = message;
        this.code = code;
    }
}
