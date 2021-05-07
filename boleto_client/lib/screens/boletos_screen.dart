import 'package:boleto_client/dto/boleto.dart';
import 'package:boleto_client/screens/boleto_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          future: FirebaseFirestore.instance
              .collection("users/${widget.cpf}/boletos")
              .orderBy("dataVencimento", descending: true)
              .get()
              .then((qnp) => qnp.docs.map((e) => Boleto.fromDocument(e)).toList()),
          builder: (__, AsyncSnapshot<List<Boleto>> snp) {
            if (!snp.hasData) {
              return Center(child: Text("Carregando..."));
            }

            if (snp.data?.length == 0) {
              return Center(child: Text("Sem registros para exibir."));
            }

            List<Boleto> documents = snp.data!;

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (__, idx) {
                  final _boleto = documents[idx];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                              MaterialPageRoute(builder: (__) => BoletoScreen(boleto: documents[idx], cpf: widget.cpf)))
                          .then((___) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Número: ${_boleto.linhaDigitavel}"),
                              SizedBox(height: 5),
                              Text("Vencimento: ${DateFormat("dd/MM/yyyy").format(_boleto.dataVencimento!)}"),
                              SizedBox(height: 5),
                              Text("Beneficiário: ${_boleto.nomeBeneficiario}")
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
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
              Navigator.of(context).push(MaterialPageRoute(builder: (__) => BoletoScreen(cpf: widget.cpf))).then((_) {
                setState(() {});
              });
            },
          ),
        ));
  }
}
