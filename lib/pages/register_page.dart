import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app02/helpers/mostrar_alerta.dart';
import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/services/socket_service.dart';
import 'package:chat_app02/widgets/boton_azul.dart';
import 'package:chat_app02/widgets/custom_input.dart';
import 'package:chat_app02/widgets/labels.dart';
import 'package:chat_app02/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                Logo(
                  titulo: 'Registro',
                ),
                _Form(),
                Labels(
                  ruta: 'login',
                  titulo: 'Ya tiene una cuenta?',
                  subtitulo: 'Ingresa ahora!',
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
  final nameCtrl = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameCtrl,
            keboardType: TextInputType.text,
          ),
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
            text: 'Crear Cuentas',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus(); //Ocultar el teclado
                    final registroOk = await authService.register(
                        emailCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());

                    if (registroOk == true) {
                      socketService.connect();
                      //Navegar a otras pantallas
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, 'Usuarios');
                      }
                    } else {
                      //Mostrar Alerta
                      if (context.mounted) {
                        mostratAlerta(
                            context, 'Registro incorrecto', registroOk);
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}
