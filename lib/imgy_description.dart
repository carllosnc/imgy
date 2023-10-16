import 'package:flutter/material.dart';
import './imgy.dart';

class ImgyDescription extends StatelessWidget {
  const ImgyDescription({
    super.key,
    required this.context,
    required this.widget,
  });

  final BuildContext context;
  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: const Key('imgy_full_screen_description'),
      bottom: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: Text(
          widget.description!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
