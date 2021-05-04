import 'package:boleto_client/screens/boleto_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoletosScreen extends StatefulWidget {
  final String? cpf;

  const BoletosScreen({Key? key, this.cpf}) : super(key: key);

  @override
  _BoletosScreenState createState() => _BoletosScreenState();
}

class _BoletosScreenState extends State<BoletosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Boletos Gerados"),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("users/${widget.cpf}/boletos").get(),
          builder: (__, AsyncSnapshot<QuerySnapshot> snp) {
            if (!snp.hasData) {
              return Center(child: Text("Carregando..."));
            }

            if (snp.data?.size == 0) {
              return Center(child: Text("Sem registros para exibir."));
            }

            return Center(child: Text("Listagem"));
          },
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
                  "Novo Boleto",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (__) => BoletoScreen(cpf: widget.cpf)));
            },
          ),
        ));
  }
}
