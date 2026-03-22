import 'package:flutter/material.dart';
import 'package:flutter_mastery_roadmap/screens/todo_counter_app.dart';

class ParentCounterScreen extends StatefulWidget {
  const ParentCounterScreen({super.key});

  @override
  State<ParentCounterScreen> createState() {
    print('🟢 ParentCounterScreen createState() - Widget created');
    return _ParentCounterScreenState();
  }
}

class _ParentCounterScreenState extends State<ParentCounterScreen> {
  int currentvalue = 12;

  @override
  void initState() {
    super.initState();
    print('🔵 ParentCounterScreen initState() - One-time setup');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🟡 ParentCounterScreen didChangeDependencies() - Context ready');
  }

  @override
  void didUpdateWidget(covariant ParentCounterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('🟠 ParentCounterScreen didUpdateWidget() - Parent changed props');
  }

  @override
  void deactivate() {
    print('🟣 ParentCounterScreen deactivate() - Temporarily removed');
    super.deactivate();
  }

  @override
  void dispose() {
    print('🔴 ParentCounterScreen dispose() - Destroyed forever');
    super.dispose();
  }
  void increment() {
    print('⚡ ParentCounterScreen setState() - Internal state changed (increment)');
    setState(() {
      currentvalue++;
    });
  }

  void decrement() {
    print('⚡ ParentCounterScreen setState() - Internal state changed (decrement)');
    setState(() {
      if (currentvalue > 0) {
        currentvalue--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('🎨 ParentCounterScreen build() - UI rendering (currentvalue: $currentvalue)');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Column(children: [
        Flexible(
          child: TodoCounterApp(initialValue: currentvalue),
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
