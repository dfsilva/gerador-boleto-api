import 'package:intl/intl.dart';

class Boleto {
  final String? linhaDigitavel;
  final DateTime? dataDocumento;
  final DateTime? dataProcessamento;
  final DateTime? dataVencimento;

  final String? nomePagador;
  final String? documentoPagador;
  final String? logradouroPagador;
  final String? bairroPagador;
  final String? cepPagador;
  final String? cidadePagador;
  final String? ufPagador;

  Boleto(
      {this.linhaDigitavel,
      this.dataDocumento,
      this.dataProcessamento,
      this.dataVencimento,
      this.nomePagador,
      this.documentoPagador,
      this.logradouroPagador,
      this.bairroPagador,
      this.cepPagador,
      this.cidadePagador,
      this.ufPagador});

  Map<String, dynamic> toJson() {
    return {
      "linhaDigitavel": this.linhaDigitavel,
      "dataDocumento": this.dataDocumento != null ? DateFormat("dd/MM/yyyy").format(this.dataDocumento!) : null,
      "dataProcessamento":
          this.dataProcessamento != null ? DateFormat("dd/MM/yyyy").format(this.dataProcessamento!) : null,
      "dataVencimento": this.dataVencimento != null ? DateFormat("dd/MM/yyyy").format(this.dataVencimento!) : null,
      "nomePagador": this.nomePagador,
      "documentoPagador": this.documentoPagador,
      "logradouroPagador": this.logradouroPagador,
      "bairroPagador": this.bairroPagador,
      "cepPagador": this.cepPagador,
      "cidadePagador": this.cidadePagador,
      "ufPagador": this.ufPagador,
    };
  }

  Boleto copyWith(
          {String? linhaDigitavel,
          DateTime? dataDocumento,
          DateTime? dataProcessamento,
          DateTime? dataVencimento,
          String? nomePagador,
          String? documentoPagador,
          String? logradouroPagador,
          String? bairroPagador,
          String? cepPagador,
          String? cidadePagador,
          String? ufPagador}) =>
      Boleto(
          linhaDigitavel: linhaDigitavel ?? this.linhaDigitavel,
          dataDocumento: dataDocumento ?? this.dataDocumento,
          dataProcessamento: dataProcessamento ?? this.dataProcessamento,
          dataVencimento: dataVencimento ?? this.dataVencimento,
          nomePagador: nomePagador ?? this.nomePagador,
          documentoPagador: documentoPagador ?? this.documentoPagador,
          logradouroPagador: logradouroPagador ?? this.logradouroPagador,
          bairroPagador: bairroPagador ?? this.bairroPagador,
          cepPagador: cepPagador ?? this.cepPagador,
          cidadePagador: cidadePagador ?? this.cidadePagador,
          ufPagador: ufPagador ?? this.ufPagador);
}
