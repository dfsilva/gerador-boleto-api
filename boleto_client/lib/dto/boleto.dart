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

  final String? nomeBeneficiario;
  final String? documentoBeneficiario;
  final String? logradouroBeneficiario;
  final String? bairroBeneficiario;
  final String? cepBeneficiario;
  final String? cidadeBeneficiario;
  final String? ufBeneficiario;

  final double? valor;
  final String? numeroDocumento;

  final String? instrucaoLinha1;
  final String? instrucaoLinha2;
  final String? instrucaoLinha3;
  final String? instrucaoLinha4;
  final String? instrucaoLinha5;

  final String? localPagamento;

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
      this.ufPagador,
      this.nomeBeneficiario,
      this.documentoBeneficiario,
      this.logradouroBeneficiario,
      this.bairroBeneficiario,
      this.cepBeneficiario,
      this.cidadeBeneficiario,
      this.ufBeneficiario,
      this.valor,
      this.numeroDocumento,
      this.instrucaoLinha1,
      this.instrucaoLinha2,
      this.instrucaoLinha3,
      this.instrucaoLinha4,
      this.instrucaoLinha5,
      this.localPagamento});

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
      "nomeBeneficiario": this.nomeBeneficiario,
      "documentoBeneficiario": this.documentoBeneficiario,
      "logradouroBeneficiario": this.logradouroBeneficiario,
      "bairroBeneficiario": this.bairroBeneficiario,
      "cepBeneficiario": this.cepBeneficiario,
      "cidadeBeneficiario": this.cidadeBeneficiario,
      "ufBeneficiario": this.ufBeneficiario,
      "valor": this.valor,
      "numeroDocumento": this.numeroDocumento,
      "instrucaoLinha1": this.instrucaoLinha1,
      "instrucaoLinha2": this.instrucaoLinha2,
      "instrucaoLinha3": this.instrucaoLinha3,
      "instrucaoLinha4": this.instrucaoLinha4,
      "instrucaoLinha5": this.instrucaoLinha5,
      "localPagamento": this.localPagamento,
    };
  }

  Map<String, dynamic> toFirebase() {
    return {
      "linhaDigitavel": this.linhaDigitavel,
      "dataDocumento": this.dataDocumento,
      "dataProcessamento": this.dataProcessamento,
      "dataVencimento": this.dataVencimento,
      "nomePagador": this.nomePagador,
      "documentoPagador": this.documentoPagador,
      "logradouroPagador": this.logradouroPagador,
      "bairroPagador": this.bairroPagador,
      "cepPagador": this.cepPagador,
      "cidadePagador": this.cidadePagador,
      "ufPagador": this.ufPagador,
      "nomeBeneficiario": this.nomeBeneficiario,
      "documentoBeneficiario": this.documentoBeneficiario,
      "logradouroBeneficiario": this.logradouroBeneficiario,
      "bairroBeneficiario": this.bairroBeneficiario,
      "cepBeneficiario": this.cepBeneficiario,
      "cidadeBeneficiario": this.cidadeBeneficiario,
      "ufBeneficiario": this.ufBeneficiario,
      "valor": this.valor,
      "numeroDocumento": this.numeroDocumento,
      "instrucaoLinha1": this.instrucaoLinha1,
      "instrucaoLinha2": this.instrucaoLinha2,
      "instrucaoLinha3": this.instrucaoLinha3,
      "instrucaoLinha4": this.instrucaoLinha4,
      "instrucaoLinha5": this.instrucaoLinha5,
      "localPagamento": this.localPagamento,
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
          String? ufPagador,
          String? nomeBeneficiario,
          String? documentoBeneficiario,
          String? logradouroBeneficiario,
          String? bairroBeneficiario,
          String? cepBeneficiario,
          String? cidadeBeneficiario,
          String? ufBeneficiario,
          double? valor,
          String? numeroDocumento,
          String? instrucaoLinha1,
          String? instrucaoLinha2,
          String? instrucaoLinha3,
          String? instrucaoLinha4,
          String? instrucaoLinha5,
          String? localPagamento}) =>
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
          ufPagador: ufPagador ?? this.ufPagador,
          nomeBeneficiario: nomeBeneficiario ?? this.nomeBeneficiario,
          documentoBeneficiario: documentoBeneficiario ?? this.documentoBeneficiario,
          logradouroBeneficiario: logradouroBeneficiario ?? this.logradouroBeneficiario,
          bairroBeneficiario: bairroBeneficiario ?? this.bairroBeneficiario,
          cepBeneficiario: cepBeneficiario ?? this.cepBeneficiario,
          cidadeBeneficiario: cidadeBeneficiario ?? this.cidadeBeneficiario,
          ufBeneficiario: ufBeneficiario ?? this.ufBeneficiario,
          valor: valor ?? this.valor,
          numeroDocumento: numeroDocumento ?? this.numeroDocumento,
          instrucaoLinha1: instrucaoLinha1 ?? this.instrucaoLinha1,
          instrucaoLinha2: instrucaoLinha2 ?? this.instrucaoLinha2,
          instrucaoLinha3: instrucaoLinha3 ?? this.instrucaoLinha3,
          instrucaoLinha4: instrucaoLinha4 ?? this.instrucaoLinha4,
          instrucaoLinha5: instrucaoLinha5 ?? this.instrucaoLinha5,
          localPagamento: localPagamento ?? this.localPagamento);
}
