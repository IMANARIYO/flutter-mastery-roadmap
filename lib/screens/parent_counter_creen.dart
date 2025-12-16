import 'package:flutter/material.dart';
import 'package:flutter_mastery_roadmap/screens/todo_counter_app.dart';

class ParentCounterScreen extends StatefulWidget {
  const ParentCounterScreen({super.key});

  @override
  State<ParentCounterScreen> createState() => _ParentCounterScreenState();
}

class _ParentCounterScreenState extends State<ParentCounterScreen> {
  int currentvalue = 12;
  void increment() {
    setState(() {
      currentvalue++;
    });
  }

  void decrement() {
    setState(() {
      if (currentvalue > 0) {
        currentvalue--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Column(children: [
        Flexible(
          child: TodoCounterApp(currentvalue),
        ),
        Text(currentvalue.toString()),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                increment();
              },
              child: const Text("Increment"),
            ),
            ElevatedButton(
              onPressed: () {
                decrement();
              },
              child: const Text("Decrement"),
            ),
          ],
        ),
      ]),
    );
  }
}
