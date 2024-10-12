import 'package:flutter/material.dart';
import 'package:chat_app02/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'Usuarios': (_) => const UsuariosPage(),
  'Chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
};
