import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app02/global/environment.dart';
import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/models/mensajes_response.dart';
import 'package:chat_app02/models/usuario.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      //Recibe la respuesta
      final url = Uri.http(Environment.apiURL, 'api/mensajes/$usuarioID');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final mensajesResponse = mensajesResponseFromJson(resp.body);
      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
