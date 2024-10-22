import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/services/socket_service.dart';
import 'package:chat_app02/pages/pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      if (context.mounted) {
        socketService.connect();
        //Navigator.pushReplacementNamed(context, 'Usuarios');
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0),
          ),
        );
      }
    } else {
      if (context.mounted) {
        //Navigator.pushReplacementNamed(context, 'login');
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0),
          ),
        );
      }
    }
  }
}
