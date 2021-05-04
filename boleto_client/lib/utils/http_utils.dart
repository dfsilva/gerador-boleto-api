import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:boleto_client/utils/message.dart';
import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String HOST = "http://192.168.31.39:8080";

  // static const String HOST = "https://sm.diegosilva.com.br";
  static const String URL = "$HOST/";

  static handleError(error) {
    showError(error.message);
    throw error;
  }

  static Future<dynamic> doPost({String url = URL, String uri = "", Map<String, dynamic> bodyParams = const {}}) async {
    print("POST $url$uri");
    try {
      return http
          .post(
        Uri.parse(url + uri),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(bodyParams),
      )
          .then((response) {
        if (response.statusCode == 200) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return handleError(Exception(utf8.decode(response.bodyBytes)));
        }
      });
    } on SocketException {
      handleError("Sem conexão com a internet!");
    }
  }

  static Future<dynamic> doPostDownloadPdf(
      {String url = URL, String uri = "", Map<String, dynamic> bodyParams = const {}}) async {
    print("POST $url$uri");
    print(json.encode(bodyParams));
    try {
      return http
          .post(
        Uri.parse(url + uri),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(bodyParams),
      )
          .then((response) async {
        if (response.statusCode == 200) {
          return FileSaver.instance.saveFile("boleto", response.bodyBytes, "pdf", mimeType: MimeType.PDF);
        } else {
          return handleError(Exception(utf8.decode(response.bodyBytes)));
        }
      });
    } on SocketException {
      handleError("Sem conexão com a internet!");
    }
  }

  static Future<dynamic> doPut({String url = URL, String uri = "", Map<String, dynamic> bodyParams = const {}}) async {
    print("PUT $url$uri");
    try {
      return http
          .put(
        Uri.parse(url + uri),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(bodyParams),
      )
          .then((response) {
        if (response.statusCode == 200) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return handleError(Exception(utf8.decode(response.bodyBytes)));
        }
      });
    } on SocketException {
      handleError("Sem conexão com a internet!");
    }
  }

  static Future<dynamic> doGet({String url = URL, String uri = "", Map<String, dynamic> params = const {}}) async {
    print("GET $url$uri");
    try {
      return http.get(
          Uri.parse(url +
              uri +
              params.entries
                  .where((entry) => (entry.value != null && entry.value.toString().isNotEmpty))
                  .fold("?", (previousValue, element) => previousValue + "${element.key}=${element.value}&")),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}).then((response) {
        if (response.statusCode == 200) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return handleError(Exception(utf8.decode(response.bodyBytes)));
        }
      });
    } on SocketException {
      handleError("Sem conexão com a internet!");
    }
  }

  static Future<dynamic> doDelete({String url = URL, String uri = "", Map<String, dynamic> params = const {}}) async {
    print("DEL $url $uri");
    try {
      return http.delete(
          Uri.parse(url +
              uri +
              params.entries
                  .where((entry) => (entry.value != null && entry.value.toString().isNotEmpty))
                  .fold("?", (previousValue, element) => previousValue + "${element.key}=${element.value}&")),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}).then((response) {
        if (response.statusCode == 200) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return handleError(Exception(utf8.decode(response.bodyBytes)));
        }
      });
    } on SocketException {
      handleError("Sem conexão com a internet!");
    }
  }
}
