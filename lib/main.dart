import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app02/services/socket_service.dart';
import 'package:chat_app02/services/auth_service.dart';
import 'package:chat_app02/services/chat_service.dart';
import 'package:chat_app02/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
