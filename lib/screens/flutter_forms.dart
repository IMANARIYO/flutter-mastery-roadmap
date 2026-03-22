import 'package:flutter/material.dart';
import 'package:flutter_mastery_roadmap/screens/flutter_form.dart';
import 'package:flutter_mastery_roadmap/screens/flutter_form_with_constructor.dart';

class FlutterForms extends StatelessWidget {
  const FlutterForms({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Forms Learning'),
          backgroundColor: Colors.purple.shade100,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add_circle_outline),
                text: 'Empty Form',
              ),
              Tab(
                icon: Icon(Icons.edit),
                text: 'Pre-filled Form',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Empty Form
            const FlutterForm(),
            
            // Tab 2: Pre-filled Form with sample data
            FlutterFormWithConstructor(
              initialName: "John Doe",
              initialEmail: "john.doe@example.com",
              initialPhone: "1234567890",
              initialAge: "28",
              initialWebsite: "https://johndoe.com",
              initialSelectedGender: "Male",
              initialSelectedCountry: "USA",
              initialSelectedEducation: "Bachelor's Degree",
              initialSelectedHobbies: const ["Reading", "Gaming", "Sports"],
              initialSelectedDate: DateTime(1995, 5, 15),
              initialSelectedTime: const TimeOfDay(hour: 14, minute: 30),
              initialSelectedDateTime: DateTime(2024, 12, 25, 10, 0),
              initialSliderValue: 75.0,
              initialRangeValues: const RangeValues(30, 90),
              initialSwitchValue: true,
              initialIsChecked: true,
              initialComments: "This is a sample comment to show pre-filled data in the form.",
              initialPassword: "password123",
              initialConfirmPassword: "password123",
            ),
          ],
        ),
      ),
    );
  }
}