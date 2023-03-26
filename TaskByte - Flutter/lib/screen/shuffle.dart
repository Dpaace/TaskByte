import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class Shuffle extends StatefulWidget {
  const Shuffle({super.key});

  static const String route = "Shuffle";

  @override
  State<Shuffle> createState() => _ShuffleState();
}

class _ShuffleState extends State<Shuffle> {
  static const List<String> quotes = [
    'You only live once, but if you do it right, once is enough.Hahaaa',
    'If you want to live a happy life, tie it to a goal, not to people or things.',
    'In order to write about life first you must live it.',
  ];

  String quote = quotes.first;
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final newQuote = (List.of(quotes)
              ..remove(quote)
              ..shuffle())
            .first;

        setState(() {
          quote = newQuote;
        });
      },
    );
  }

  @override
  void dispose() {
    detector!.stopListening();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shake Sensor"),
      ),
      body: Container(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: Text(
            quote,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
