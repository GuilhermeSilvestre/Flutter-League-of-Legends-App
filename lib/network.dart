import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class Network {
  Network(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Riot-Token': apiLolKey,
      },
    );
    if (response.statusCode == 200) {
      String data = response.body;
      //print('Endpoint deu certo');
      return jsonDecode(data);
    } else {
      //print('Erro com a requisição');
      //print(response.statusCode);
      return -1;
    }
  }
}
