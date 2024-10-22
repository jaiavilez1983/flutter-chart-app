import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/services/socket_service.dart';

import 'package:chat_app02/helpers/mostrar_alerta.dart';

import 'package:chat_app02/widgets/custom_input.dart';
import 'package:chat_app02/widgets/logo.dart';
import 'package:chat_app02/widgets/labels.dart';
import 'package:chat_app02/widgets/boton_azul.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Messenger'),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: 'No tienes cuenta?',
                  subtitulo: 'Crea una Ahora!',
                ),
                Text('Terminos y condiciones de uso',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailCtrl,
            keboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          const SizedBox(height: 10),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus(); //Ocultar el teclado
                    final loginok = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginok) {
                      socketService.connect();
                      //Navegar a otras pantallas
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, 'Usuarios');
                      }
                    } else {
                      //Mostrar Alerta
                      if (context.mounted) {
                        mostratAlerta(context, 'Login incorrecto',
                            'Revise sus credenciales nuevamente');
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}
