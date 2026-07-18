import 'package:flutter/material.dart';

class Shell extends StatelessWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 240,
            color: const Color(0xffE8E1D6),
            child: const Center(
              child: Text("Books"),
            ),
          ),

          Container(
            width: 320,
            color: Colors.white,
            child: const Center(
              child: Text("Entries"),
            ),
          ),

          Expanded(
            child: Container(
              color: const Color(0xffF8F6F2),
              child: const Center(
                child: Text("Editor"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}