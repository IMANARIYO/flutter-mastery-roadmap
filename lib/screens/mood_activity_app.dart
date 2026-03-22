import 'package:flutter/material.dart';

class MoodActivityApp extends StatefulWidget {
  const MoodActivityApp({super.key});
  @override
  State<MoodActivityApp> createState() => _MoodActivityAppState();
}

class _MoodActivityAppState extends State<MoodActivityApp> {
  String mood = "Happy";
  int energyLevel = 5;
  int steps = 0;

  final List<String> moods = ["Happy", "Sad", "Excited", "Tired"];
  final Map<String, String> moodEmojis = {
    "Happy": "😊",
    "Sad": "😢",
    "Excited": "🤩",
    "Tired": "😴"
  };

  void cycleMood() {
    setState(() {
      int currentIndex = moods.indexOf(mood);
      mood = moods[(currentIndex + 1) % moods.length];
    });
  }

  void increaseEnergy() {
    if (energyLevel < 10) {
      setState(() {
        energyLevel++;
      });
    }
  }

  void decreaseEnergy() {
    if (energyLevel > 0) {
      setState(() {
        energyLevel--;
      });
    }
  }

  void incrementSteps() {
    setState(() {
      steps += 100;
    });
  }

  Color getBackgroundColor() {
    if (energyLevel <= 3) return Colors.red.shade100;
    if (energyLevel <= 7) return Colors.orange.shade100;
    return Colors.green.shade100;
  }

  String getStepsMessage() {
    if (steps < 1000) return "Keep walking!";
    if (steps <= 5000) return "Good job!";
    return "Excellent!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      appBar: AppBar(
        title: Text("Mood & Activity Tracker Pro"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mood Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Current Mood", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "${moodEmojis[mood]} $mood",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: cycleMood,
                      child: Text("Change Mood"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Energy Level Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Energy Level", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "$energyLevel / 10",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: energyLevel > 0 ? decreaseEnergy : null,
                          child: Icon(Icons.remove),
                        ),
                        ElevatedButton(
                          onPressed: energyLevel < 10 ? increaseEnergy : null,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Steps Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Daily Steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "$steps",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      getStepsMessage(),
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: incrementSteps,
                      child: Text("+100 Steps"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
