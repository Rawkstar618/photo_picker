import 'package:flutter/material.dart';

class HSButtonTemplate extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const HSButtonTemplate(
      {required this.onPressed, required this.text, super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(
          Color.fromARGB(255, 65, 1, 76),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Color.fromARGB(255, 214, 171, 237),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        minimumSize: const MaterialStatePropertyAll(Size.square(200)),
      ),
      child: Text(
          style: const TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
          text),
    );
  }
}
