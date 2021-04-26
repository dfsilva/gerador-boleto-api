import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class BoletoScreen extends StatefulWidget {
  final String? cpf;

  const BoletoScreen({Key? key, this.cpf}) : super(key: key);

  @override
  _BoletoScreenState createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
  MaskedTextController _digitableLineController =
      MaskedTextController(mask: "00000.00000 00000.000000 00000.000000 0 00000000000000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Geração de Boleto"),
        ),
        body: Container(
          child: Form(
              child: Column(
            children: [
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
                  },
                  decoration: InputDecoration(hintText: "Linha digitável", labelText: "Linha digitável"),
                ),
              ),

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
                  },
                  decoration: InputDecoration(hintText: "Linha digitável", labelText: "Linha digitável"),
                ),
              ),
            ],
          )),
        ));
  }
}
