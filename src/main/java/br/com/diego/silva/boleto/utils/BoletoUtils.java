package br.com.diego.silva.boleto.utils;

public class BoletoUtils {

    public static String getBarcodeFromDigitableLine(String line) {
        StringBuilder retorno = new StringBuilder();
        retorno.append(line, 0, 4);
        retorno.append(line, 32, 47);
        retorno.append(line, 4, 9);
        retorno.append(line, 10, 20);
        retorno.append(line, 21, 31);
        return retorno.toString();
    }
}
