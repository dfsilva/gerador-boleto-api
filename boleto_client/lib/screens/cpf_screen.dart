import 'package:boleto_client/screens/boletos_screen.dart';
import 'package:boleto_client/utils/validations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _cpf;
  MaskedTextController _cpfController = MaskedTextController(mask: CPF.MASK);

  @override
  void initState() {
    super.initState();
  }

  _renderForm() => Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(10), child: Text("Informe o CPF para continuar")),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: _cpfController,
                autofocus: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o seu CPF";
                  }

                  if (!CPF.isValid(value)) {
                    return "CPF Invalido";
                  }

                  return null;
                },
                onSaved: (value) {
                  this._cpf = value;
                },
                decoration: InputDecoration(hintText: "CPF", labelText: "CPF", prefixIcon: Icon(Icons.recent_actors)),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 5),
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Próximo",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (__) => BoletosScreen(cpf: this._cpfController.text)));
                  }
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("CPF"),
        ),
        body: Container(
          child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (__, snp) {
              if (!snp.hasData) {
                return Center(child: Text("Carregando..."));
              }
              return _renderForm();
            },
          ),
        ));
  }
}
