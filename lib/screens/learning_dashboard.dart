import 'package:flutter/material.dart';
import 'package:flutter_mastery_roadmap/screens/flutter_forms.dart';
import 'package:flutter_mastery_roadmap/screens/parent_counter_creen.dart';
import 'package:flutter_mastery_roadmap/screens/mood_activity_app.dart';
// import 'package:flutter_mastery_roadmap/screens/home_page.dart';

class LearningDashboard extends StatelessWidget {
  const LearningDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Learning Journey'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Flutter Projects',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildProjectCard(
                    context,
                    title: 'Counter App',
                    description: 'Stateful vs Stateless Widgets',
                    status: '✅ Completed',
                    screen: ParentCounterScreen(),
                  ),
                  _buildProjectCard(
                    context,
                    title: 'Mood & Activity Tracker',
                    description: 'Multiple State Management',
                    status: '✅ Completed',
                    screen: MoodActivityApp(),
                  ),
                  _buildProjectCard(
                    context,
                    title: 'Flutter Forms & Input Fields',
                    description:
                        'Empty & Pre-filled Forms with Tabs - All Input Types',
                    status: '✅ Completed',
                    screen: const FlutterForms(),
                  ),
                  _buildProjectCard(
                    context,
                    title: 'Layouts & Positioning',
                    description: 'Flex, Expanded, Positioned',
                    status: '🚧 In Progress',
                    screen: null,
                  ),
                  _buildProjectCard(
                    context,
                    title: 'Images & Assets',
                    description: 'AssetImage, NetworkImage',
                    status: '🚧 In Progress',
                    screen: null,
                  ),
                  _buildProjectCard(
                    context,
                    title: 'User Input',
                    description: 'TextField, Button, Forms',
                    status: '🚧 In Progress',
                    screen: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String description,
    required String status,
    Widget? screen,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            if (screen != null) Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: screen != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen),
                );
              }
            : null,
      ),
    );
  }
}
