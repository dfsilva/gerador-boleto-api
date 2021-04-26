import 'package:boleto_client/boleto_screen.dart';
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Container()),
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
            )
          ],
        ));
  }
}
