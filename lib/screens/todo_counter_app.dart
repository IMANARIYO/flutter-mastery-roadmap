import 'package:flutter/material.dart';

class TodoCounterApp extends StatefulWidget {
  final int initialValue;
  const TodoCounterApp({Key? key, this.initialValue = 200}) : super(key: key);

  @override
  State<TodoCounterApp> createState() {
    print('🟢 TodoCounterApp createState() - Widget created');
    return _TodoCounterAppState();
  }
}

class _TodoCounterAppState extends State<TodoCounterApp> {
  late int counter;

  @override
  void initState() {
    super.initState();
    print('🔵 TodoCounterApp initState() - One-time setup');
    counter = widget.initialValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🟡 TodoCounterApp didChangeDependencies() - Context ready');
  }

  @override
  void dispose() {
    print('🔴 TodoCounterApp dispose() - Destroyed forever');
    // ✅ Always call the parent class's dispose to clean up resources properly
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TodoCounterApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('🟠 TodoCounterApp didUpdateWidget() - Parent changed props');
    // Update counter if parent changes the value
    if (oldWidget.initialValue != widget.initialValue) {
      print('   └─ Initial value changed: ${oldWidget.initialValue} → ${widget.initialValue}');
      counter = widget.initialValue;
    }
  }

  @override
  void deactivate() {
    print('🟣 TodoCounterApp deactivate() - Temporarily removed');
    super.deactivate();
  }

  void incrementCounter() {
    print('⚡ TodoCounterApp setState() - Internal state changed (increment)');
    setState(() => counter++);
  }
  void decrementCounter() {
    if (counter > 0) {
      print('⚡ TodoCounterApp setState() - Internal state changed (decrement)');
      setState(() => counter--);
    }
  }

  void resetCounter() {
    print('⚡ TodoCounterApp setState() - Internal state changed (reset)');
    setState(() => counter = widget.initialValue);
  }

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
    print('🎨 TodoCounterApp build() - UI rendering (counter: $counter)');
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
                heroTag: "increment",
                onPressed: incrementCounter, child: const Icon(Icons.add)),
            const SizedBox(width: 10),
            FloatingActionButton(
                heroTag: "decrement",
                onPressed: decrementCounter, child: const Icon(Icons.remove)),
            const SizedBox(width: 10),
            FloatingActionButton(
                heroTag: "reset",
                onPressed: resetCounter, child: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
