import 'package:boleto_client/dto/boleto.dart';
import 'package:boleto_client/utils/http_utils.dart';
import 'package:boleto_client/utils/string_utils.dart';
import 'package:flutter/material.dart';
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

  final FocusNode _nomePagadorFocus = new FocusNode();
  final FocusNode _documentoPagadorFocus = new FocusNode();
  final FocusNode _logradouroPagadorFocus = new FocusNode();
  final FocusNode _bairroPagadorFocus = new FocusNode();
  final MaskedTextController _cepPagadorController = MaskedTextController(mask: "00000-000");
  final FocusNode _cepPagadorFocus = new FocusNode();
  final FocusNode _cidadePagadorFocus = new FocusNode();
  final FocusNode _ufPagadorFocus = new FocusNode();

  Boleto? _boleto;

  @override
  void initState() {
    super.initState();
    this._boleto = widget.boleto ?? Boleto();
  }

  @override
  void dispose() {
    _digitableLineController.dispose();
    _dataDocumentoFocus.dispose();
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
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a linha digitável";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        this._boleto = this._boleto?.copyWith(linhaDigitavel: StringUtils.removeSpecial(value!));
                      },
                      onFieldSubmitted: (value) {
                        this._boleto = this._boleto?.copyWith(linhaDigitavel: StringUtils.removeSpecial(value));
                        _dataDocumentoFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Linha digitável", labelText: "Linha digitável"),
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
                                _dataDocumentoController.text = DateFormat("dd/MM/yyyy").format(finishDate);
                                _dataDocumentoFocus.unfocus();
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
                      controller: _dataVencimentoController,
                      focusNode: _dataVencimentoFocus,
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
                              DateTime? finishDate = await showDatePicker(
                                  context: context,
                                  initialDate: this._boleto?.dataVencimento != null
                                      ? this._boleto!.dataVencimento!
                                      : DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 3650)));
                              if (finishDate != null) {
                                _dataVencimentoController.text = DateFormat("dd/MM/yyyy").format(finishDate);
                                _dataVencimentoFocus.unfocus();
                              }
                            },
                          )),
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
                        this._boleto = this._boleto?.copyWith(nomePagador: value);
                        _nomePagadorFocus.unfocus();
                        _documentoPagadorFocus.requestFocus();
                      },
                      decoration: InputDecoration(hintText: "Nome do Pagador", labelText: "Nome do Pagador"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _documentoPagadorFocus,
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
                        this._boleto = this._boleto?.copyWith(documentoPagador: value);
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
                        this._boleto = this._boleto?.copyWith(logradouroPagador: value);
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
                        this._boleto = this._boleto?.copyWith(bairroPagador: value);
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
                        this._boleto = this._boleto?.copyWith(cepPagador: value);
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
                        this._boleto = this._boleto?.copyWith(cidadePagador: value);
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
                        this._boleto = this._boleto?.copyWith(ufPagador: value);
                      },
                      decoration: InputDecoration(hintText: "UF do pagador", labelText: "UF do pagador"),
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
                Api.doPostDownloadPdf(uri: "gerar-boleto", bodyParams: _boleto!.toJson()).then((value) {
                  Navigator.of(context).pop();
                });
              }
            },
          ),
        ));
  }
}
