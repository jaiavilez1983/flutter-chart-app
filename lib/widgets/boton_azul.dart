import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BotonAzul({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2, // Elevación del botón
        shadowColor: Colors.blue, // Color de la sombra
        shape:
            const StadiumBorder(), // Forma de bordes redondeados como estadio
        backgroundColor: Colors.blue, // Color de fondo
        padding:
            EdgeInsets.zero, // Para que el container maneje el tamaño del botón
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity, // Botón que toma todo el ancho disponible
        height: 55, // Altura del botón
        alignment: Alignment.center, // Centrar el texto
        child: Text(
          text, // Texto dentro del botón
          style: const TextStyle(
              color: Colors.white, fontSize: 17), // Color del texto
        ),
      ),
    );
  }
}
