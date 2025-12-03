import 'package:flutter/material.dart';

class TodoCounterApp extends StatefulWidget {
  final int initialValue;
  const TodoCounterApp(this.initialValue, {super.key});

  @override
  State<TodoCounterApp> createState() => _TodoCounterAppState();
}

class _TodoCounterAppState extends State<TodoCounterApp> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
  }

  void incrementCounter() => setState(() => counter++);
  void decrementCounter() {
    if (counter > 0) setState(() => counter--);
  }

  void resetCounter() => setState(() => counter = widget.initialValue);

  String getTextBasedOnCounter() {
    if (counter == 0) return 'Nothing left!';
    if (counter >= 5) return 'You’re doing great!';
    return 'Keep going…';
  }

  Color getColorBasedOnCounter() {
    if (counter == 0) return Colors.red;
    if (counter >= 5) return Colors.green;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Counter: $counter', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Text(
                getTextBasedOnCounter(),
                style: TextStyle(color: getColorBasedOnCounter(), fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: incrementCounter, child: const Icon(Icons.add)),
            const SizedBox(width: 10),
            FloatingActionButton(
                onPressed: decrementCounter, child: const Icon(Icons.remove)),
            const SizedBox(width: 10),
            FloatingActionButton(
                onPressed: resetCounter, child: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
