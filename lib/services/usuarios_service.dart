import 'package:http/http.dart' as http;

import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/global/environment.dart';
import 'package:chat_app02/models/usuarios_response.dart';
import 'package:chat_app02/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      //Recibe la respuesta
      final url = Uri.http(Environment.apiURL, 'api/usuarios');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
