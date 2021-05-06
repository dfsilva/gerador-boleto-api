import 'package:boleto_client/dto/boleto.dart';
import 'package:boleto_client/utils/http_utils.dart';
import 'package:boleto_client/utils/string_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class BoletoScreen extends StatefulWidget {
  final String? cpf;
  final Boleto? boleto;

  const BoletoScreen({Key? key, this.cpf, this.boleto}) : super(key: key);

  @override
  _BoletoScreenState createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
  final _formKey = GlobalKey<FormState>();

  final MaskedTextController _digitableLineController =
      MaskedTextController(mask: "00000.00000 00000.000000 00000.000000 0 00000000000000");
  final FocusNode _digitableLineFocus = new FocusNode();

  final MaskedTextController _dataDocumentoController = MaskedTextController(mask: "00/00/0000");
  final FocusNode _dataDocumentoFocus = new FocusNode();

  final MaskedTextController _dataProcessamentoController = MaskedTextController(mask: "00/00/0000");
  final FocusNode _dataProcessamentoFocus = new FocusNode();

  final MaskedTextController _dataVencimentoController = MaskedTextController(mask: "00/00/0000");
  final FocusNode _dataVencimentoFocus = new FocusNode();

  final MoneyMaskedTextController _valorController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$ ");
  final FocusNode _valorFocus = new FocusNode();

  final FocusNode _numeroDocumentoFocus = new FocusNode();
  final TextEditingController _numeroDocumentoController = TextEditingController();
  final FocusNode _instrucaoLinha1Focus = new FocusNode();
  final TextEditingController _instrucaoLinha1Controller = TextEditingController();
  final FocusNode _instrucaoLinha2Focus = new FocusNode();
  final TextEditingController _instrucaoLinha2Controller = TextEditingController();
  final FocusNode _instrucaoLinha3Focus = new FocusNode();
  final TextEditingController _instrucaoLinha3Controller = TextEditingController();
  final FocusNode _instrucaoLinha4Focus = new FocusNode();
  final TextEditingController _instrucaoLinha4Controller = TextEditingController();
  final FocusNode _instrucaoLinha5Focus = new FocusNode();
  final TextEditingController _instrucaoLinha5Controller = TextEditingController();
  final FocusNode _localPagamentoFocus = new FocusNode();
  final TextEditingController _localPagamentoController = TextEditingController();

  final FocusNode _nomePagadorFocus = new FocusNode();
  final TextEditingController _nomePagadorController = TextEditingController();

  final FocusNode _documentoPagadorFocus = new FocusNode();
  final TextEditingController _documentoPagadorController = TextEditingController();

  final FocusNode _logradouroPagadorFocus = new FocusNode();
  final TextEditingController _logradouroPagadorController = TextEditingController();

  final FocusNode _bairroPagadorFocus = new FocusNode();
  final TextEditingController _bairroPagadorController = TextEditingController();

  final FocusNode _cepPagadorFocus = new FocusNode();
  final MaskedTextController _cepPagadorController = MaskedTextController(mask: "00000-000");

  final FocusNode _cidadePagadorFocus = new FocusNode();
  final TextEditingController _cidadePagadorController = TextEditingController();

  final FocusNode _ufPagadorFocus = new FocusNode();
  final TextEditingController _ufPagadorController = TextEditingController();

  final FocusNode _nomeBeneficiarioFocus = new FocusNode();
  final TextEditingController _nomeBeneficiarioController = TextEditingController();

  final FocusNode _documentoBeneficiarioFocus = new FocusNode();
  final TextEditingController _documentoBeneficiarioController = TextEditingController();

  final FocusNode _logradouroBeneficiarioFocus = new FocusNode();
  final TextEditingController _logradouroBeneficiarioController = TextEditingController();

  final FocusNode _bairroBeneficiarioFocus = new FocusNode();
  final TextEditingController _bairroBeneficiarioController = TextEditingController();

  final FocusNode _cepBeneficiarioFocus = new FocusNode();
  final MaskedTextController _cepBeneficiarioController = MaskedTextController(mask: "00000-000");

  final FocusNode _cidadeBeneficiarioFocus = new FocusNode();
  final TextEditingController _cidadeBeneficiarioController = TextEditingController();

  final FocusNode _ufBeneficiarioFocus = new FocusNode();
  final TextEditingController _ufBeneficiarioController = TextEditingController();

  Boleto? _boleto;

  @override
  void initState() {
    super.initState();
    this._boleto = widget.boleto ?? Boleto();
  }

  @override
  void dispose() {
    _digitableLineController.dispose();
    _dataDocumentoController.dispose();
    _dataDocumentoFocus.dispose();
    _dataProcessamentoController.dispose();
    _dataProcessamentoFocus.dispose();
    _dataVencimentoController.dispose();
    _dataVencimentoFocus.dispose();

    _valorController.dispose();
    _valorFocus.dispose();

    _numeroDocumentoController.dispose();
    _numeroDocumentoFocus.dispose();

    _instrucaoLinha1Controller.dispose();
    _instrucaoLinha1Focus.dispose();

    _instrucaoLinha2Controller.dispose();
    _instrucaoLinha2Focus.dispose();

    _instrucaoLinha3Controller.dispose();
    _instrucaoLinha3Focus.dispose();

    _instrucaoLinha4Controller.dispose();
    _instrucaoLinha4Focus.dispose();

    _instrucaoLinha5Controller.dispose();
    _instrucaoLinha5Focus.dispose();

    _localPagamentoController.dispose();
    _localPagamentoFocus.dispose();

    _nomePagadorFocus.dispose();
    _documentoPagadorFocus.dispose();
    _logradouroPagadorFocus.dispose();
    _bairroPagadorFocus.dispose();
    _cepPagadorController.dispose();
    _cepPagadorFocus.dispose();
    _cidadePagadorFocus.dispose();
    _ufPagadorFocus.dispose();

    _nomeBeneficiarioFocus.dispose();
    _documentoBeneficiarioFocus.dispose();
    _logradouroBeneficiarioFocus.dispose();
    _bairroBeneficiarioFocus.dispose();
    _cepBeneficiarioController.dispose();
    _cepBeneficiarioFocus.dispose();
    _cidadeBeneficiarioFocus.dispose();
    _ufBeneficiarioFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Geração de Boleto"),
        ),
        body: Container(
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text("DADOS DO BOLETO", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(height: .4, color: Colors.black26),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _digitableLineController,
                      focusNode: _digitableLineFocus,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o número do boleto";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(linhaDigitavel: StringUtils.removeSpecial(value!));
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(linhaDigitavel: StringUtils.removeSpecial(value));
                      },
                      onFieldSubmitted: (value) {
                        _digitableLineFocus.unfocus();
                        _dataDocumentoFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Número do Boleto", labelText: "Número do Boleto"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _dataDocumentoController,
                      focusNode: _dataDocumentoFocus,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _dataDocumentoFocus.unfocus();
                        _dataProcessamentoFocus.requestFocus();
                      },
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Informe a data do documento";
                        }
                        try {
                          DateFormat("dd/MM/yyyy").parse(data);
                        } catch (e) {
                          return "Data inválida";
                        }
                        return null;
                      },
                      onSaved: (data) {
                        this._boleto =
                            this._boleto?.copyWith(dataDocumento: DateFormat("dd/MM/yyyy").parse(data ?? ""));
                      },
                      onChanged: (data) {
                        this._boleto = this._boleto?.copyWith(dataDocumento: DateFormat("dd/MM/yyyy").parse(data));
                      },
                      decoration: InputDecoration(
                          hintText: "Data do documento",
                          labelText: "Data do documento",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? finishDate = await showDatePicker(
                                  context: context,
                                  initialDate: this._boleto?.dataDocumento != null
                                      ? this._boleto!.dataDocumento!
                                      : DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 3650)));
                              if (finishDate != null) {
                                this._boleto = this._boleto?.copyWith(dataDocumento: finishDate);
                                _dataDocumentoController.text = DateFormat("dd/MM/yyyy").format(finishDate);
                                _dataDocumentoFocus.unfocus();
                                _dataProcessamentoFocus.requestFocus();
                              }
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _dataProcessamentoController,
                      focusNode: _dataProcessamentoFocus,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _dataProcessamentoFocus.unfocus();
                        _dataVencimentoFocus.requestFocus();
                      },
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Informe a data de processamento";
                        }
                        try {
                          DateFormat("dd/MM/yyyy").parse(data);
                        } catch (e) {
                          return "Data inválida";
                        }
                        return null;
                      },
                      onSaved: (data) {
                        this._boleto =
                            this._boleto?.copyWith(dataProcessamento: DateFormat("dd/MM/yyyy").parse(data ?? ""));
                      },
                      onChanged: (data) {
                        this._boleto = this._boleto?.copyWith(dataProcessamento: DateFormat("dd/MM/yyyy").parse(data));
                      },
                      decoration: InputDecoration(
                          hintText: "Data do documento",
                          labelText: "Data do documento",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? finishDate = await showDatePicker(
                                  context: context,
                                  initialDate: this._boleto?.dataProcessamento != null
                                      ? this._boleto!.dataProcessamento!
                                      : DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 3650)));
                              if (finishDate != null) {
                                this._boleto = this._boleto?.copyWith(dataProcessamento: finishDate);
                                _dataProcessamentoController.text = DateFormat("dd/MM/yyyy").format(finishDate);
                                _dataProcessamentoFocus.unfocus();
                                _dataVencimentoFocus.requestFocus();
                              }
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      focusNode: _dataVencimentoFocus,
                      controller: _dataVencimentoController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _dataVencimentoFocus.unfocus();
                        _nomePagadorFocus.requestFocus();
                      },
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Informe a data de vencimento";
                        }
                        try {
                          DateFormat("dd/MM/yyyy").parse(data);
                        } catch (e) {
                          return "Data inválida";
                        }
                        return null;
                      },
                      onSaved: (data) {
                        this._boleto =
                            this._boleto?.copyWith(dataVencimento: DateFormat("dd/MM/yyyy").parse(data ?? ""));
                      },
                      onChanged: (data) {
                        this._boleto = this._boleto?.copyWith(dataVencimento: DateFormat("dd/MM/yyyy").parse(data));
                      },
                      decoration: InputDecoration(
                          hintText: "Data vencimento",
                          labelText: "Data vencimento",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: this._boleto?.dataVencimento != null
                                      ? this._boleto!.dataVencimento!
                                      : DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 3650)));
                              if (selectedDate != null) {
                                this._boleto = this._boleto?.copyWith(dataVencimento: selectedDate);
                                _dataVencimentoController.text = DateFormat("dd/MM/yyyy").format(selectedDate);
                                _dataProcessamentoFocus.unfocus();
                                _dataVencimentoFocus.requestFocus();
                              }
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      focusNode: _valorFocus,
                      controller: _valorController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _valorFocus.unfocus();
                        _numeroDocumentoFocus.requestFocus();
                      },
                      validator: (value) {
                        if (StringUtils.isBlank(value!)) {
                          return "Informe o valor";
                        }
                        if (_valorController.numberValue <= 0.0) {
                          return "Valor deve ser maior que 0";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(valor: _valorController.numberValue);
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(valor: _valorController.numberValue);
                      },
                      decoration: InputDecoration(
                        hintText: "Valor do boleto",
                        labelText: "Valor do boleto",
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _numeroDocumentoFocus,
                      controller: _numeroDocumentoController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o numero do documento";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print("saved $value");
                        this._boleto = this._boleto?.copyWith(numeroDocumento: value);
                      },
                      onFieldSubmitted: (value) {
                        print("submit $value");
                        _numeroDocumentoFocus.unfocus();
                      },
                      onChanged: (value) {
                        print("change $value");
                        this._boleto = this._boleto?.copyWith(numeroDocumento: value);
                      },
                      decoration: InputDecoration(hintText: "Número do documento", labelText: "Número do Documento"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _instrucaoLinha1Focus,
                      controller: _instrucaoLinha1Controller,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha1: value);
                      },
                      onFieldSubmitted: (value) {
                        _instrucaoLinha1Focus.unfocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha1: value);
                      },
                      decoration: InputDecoration(hintText: "Linha 1 instrução", labelText: "Linha 1 instrução"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _instrucaoLinha2Focus,
                      controller: _instrucaoLinha2Controller,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha2: value);
                      },
                      onFieldSubmitted: (value) {
                        _instrucaoLinha2Focus.unfocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha2: value);
                      },
                      decoration: InputDecoration(hintText: "Linha 2 instrução", labelText: "Linha 2 instrução"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _instrucaoLinha3Focus,
                      controller: _instrucaoLinha3Controller,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha3: value);
                      },
                      onFieldSubmitted: (value) {
                        _instrucaoLinha3Focus.unfocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha3: value);
                      },
                      decoration: InputDecoration(hintText: "Linha 3 instrução", labelText: "Linha 3 instrução"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _instrucaoLinha4Focus,
                      controller: _instrucaoLinha4Controller,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha4: value);
                      },
                      onFieldSubmitted: (value) {
                        _instrucaoLinha4Focus.unfocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha4: value);
                      },
                      decoration: InputDecoration(hintText: "Linha 4 instrução", labelText: "Linha 4 instrução"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _instrucaoLinha5Focus,
                      controller: _instrucaoLinha5Controller,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha5: value);
                      },
                      onFieldSubmitted: (value) {
                        _instrucaoLinha5Focus.unfocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(instrucaoLinha5: value);
                      },
                      decoration: InputDecoration(hintText: "Linha 5 instrução", labelText: "Linha 5 instrução"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _localPagamentoFocus,
                      controller: _localPagamentoController,
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(localPagamento: value);
                      },
                      onFieldSubmitted: (value) {
                        _localPagamentoFocus.unfocus();
                        _nomePagadorFocus.requestFocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(localPagamento: value);
                      },
                      decoration: InputDecoration(hintText: "Local de Pagamento", labelText: "Local de Pagamento"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text("DADOS DO PAGADOR", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(height: .4, color: Colors.black26),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _nomePagadorFocus,
                      controller: _nomePagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o nome do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(nomePagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _nomePagadorFocus.unfocus();
                        _documentoPagadorFocus.requestFocus();
                      },
                      onChanged: (value) {
                        this._boleto = this._boleto?.copyWith(nomePagador: value);
                      },
                      decoration: InputDecoration(hintText: "Nome do Pagador", labelText: "Nome do Pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      focusNode: _documentoPagadorFocus,
                      controller: _documentoPagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o documento do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(documentoPagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _documentoPagadorFocus.unfocus();
                        _logradouroPagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Documento do Pagador", labelText: "Documento do Pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _logradouroPagadorFocus,
                      controller: _logradouroPagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o logradouro do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(logradouroPagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _logradouroPagadorFocus.unfocus();
                        _bairroPagadorFocus.requestFocus();
                      },
                      decoration:
                          InputDecoration(hintText: "Logradouro do pagador", labelText: "Logradouro do pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _bairroPagadorFocus,
                      controller: _bairroPagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o bairro do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(bairroPagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _bairroPagadorFocus.unfocus();
                        _cepPagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Bairro do pagador", labelText: "Bairro do pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _cepPagadorController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _cepPagadorFocus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o cep do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(cepPagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _cepPagadorFocus.unfocus();
                        _cidadePagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Cep do pagador", labelText: "Cep do pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _cidadePagadorFocus,
                      controller: _cidadePagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a cidade do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(cidadePagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _cidadePagadorFocus.unfocus();
                        _ufPagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Cidade do pagador", labelText: "Cidade do pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _ufPagadorFocus,
                      controller: _ufPagadorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a UF do pagadodor";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(ufPagador: value);
                      },
                      onFieldSubmitted: (value) {
                        _ufPagadorFocus.unfocus();
                        _nomeBeneficiarioFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "UF do pagador", labelText: "UF do pagador"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child:
                          Text("DADOS DO BENEFICIÁRIO", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(height: .4, color: Colors.black26),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _nomeBeneficiarioFocus,
                      controller: _nomeBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o nome do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(nomeBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _nomeBeneficiarioFocus.unfocus();
                        _documentoPagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Nome do beneficiário", labelText: "Nome do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _documentoBeneficiarioController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      focusNode: _documentoBeneficiarioFocus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o documento do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(documentoBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _documentoBeneficiarioFocus.unfocus();
                        _logradouroBeneficiarioFocus.requestFocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Documento do beneficiário", labelText: "Documento do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _logradouroBeneficiarioFocus,
                      controller: _logradouroBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o logradouro do pagador";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(logradouroBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _logradouroBeneficiarioFocus.unfocus();
                        _bairroBeneficiarioFocus.requestFocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Logradouro do beneficiário", labelText: "Logradouro do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _bairroBeneficiarioFocus,
                      controller: _bairroBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o bairro do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(bairroBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        this._boleto = this._boleto?.copyWith(bairroBeneficiario: value);
                        _bairroBeneficiarioFocus.unfocus();
                        _cepBeneficiarioFocus.requestFocus();
                      },
                      decoration:
                          InputDecoration(hintText: "Bairro do beneficiário", labelText: "Bairro do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _cepBeneficiarioFocus,
                      controller: _cepBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe o cep do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(cepBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _cepBeneficiarioFocus.unfocus();
                        _cidadeBeneficiarioFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Cep do beneficiário", labelText: "Cep do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _cidadeBeneficiarioFocus,
                      controller: _cidadeBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a cidade do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(cidadeBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _cidadeBeneficiarioFocus.unfocus();
                        _ufBeneficiarioFocus.requestFocus();
                      },
                      decoration:
                          InputDecoration(hintText: "Cidade do beneficiário", labelText: "Cidade do beneficiário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _ufBeneficiarioFocus,
                      controller: _ufBeneficiarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a UF do beneficiário";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(ufBeneficiario: value);
                      },
                      onFieldSubmitted: (value) {
                        _ufBeneficiarioFocus.unfocus();
                      },
                      decoration: InputDecoration(hintText: "UF do beneficiário", labelText: "UF do beneficiário"),
                    ),
                  ),
                ],
              )),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 5),
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 15),
                Text(
                  "Gerar Boleto",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                Api.doPostDownloadPdf(uri: "gerar-boleto", bodyParams: this._boleto!.toJson()).then((value) {
                  FirebaseFirestore.instance
                      .collection("users/${widget.cpf}/boletos")
                      .add(this._boleto!.toFirebase())
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                });
              }
            },
          ),
        ));
  }
}
