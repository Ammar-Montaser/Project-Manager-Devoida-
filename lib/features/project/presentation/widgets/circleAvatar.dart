import 'package:flutter/material.dart';

class CircAvatar extends StatelessWidget {
  final String text;
  const CircAvatar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 30,
      backgroundColor: const Color.fromARGB(255, 130, 199, 255),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
      ),
    );
  }
}
