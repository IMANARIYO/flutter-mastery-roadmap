⭐ Challenge 2 – “Mood & Activity Tracker Pro with Lifecycle Awareness”
Problem Name:

Mood & Activity Tracker Pro

Problem Statement (Upgraded)

Create a StatefulWidget app that tracks three independent states, handles the widget lifecycle, and updates the UI dynamically:

Mood: String (Happy, Sad, Excited, Tired)

Cycle through moods with a single button.

Show an emoji next to the mood.

Energy Level: Integer 0–10

Buttons to increase or decrease energy.

Background color changes dynamically:

0–3 → Red

4–7 → Orange

8–10 → Green

Buttons disabled at limits (0 and 10).

Steps Count: Integer (daily steps)

Increment by 100 with a button.

Show messages based on steps:

<1000 → “Keep walking!”

1000–5000 → “Good job!”

5000 → “Excellent!”

Widget Lifecycle Features

initState(): Initialize all states from parent widget parameters.

didUpdateWidget(): Detect when parent values change and update state accordingly.

dispose(): Clean up any controllers, timers, or listeners (if added in bonus).

Parent Widget Parameters
MoodActivityApp(
  initialMood: 'Happy',
  initialEnergy: 5,
  initialSteps: 0,
);


All states should be initialized in initState().

States should update if parent widget values change (practice didUpdateWidget).

Layout & Styling Requirements

Each state in its own Container:

margin and padding

border and borderRadius

Optional shadow

Use Column layout with spacing (SizedBox) between states.

Add a Reset All button at the bottom to reset all states to initial values.

Use dynamic styling for energy level color and mood emoji.

Optional Bonus / Stretch Goals

Animate color transitions for energy level when updated.

Add a progress bar for steps (0–10000).

Animate mood text scaling when it changes.

Highlight the container of the last updated state (shadow/glow).

Add timers or listeners (optional) to practice dispose() cleanup.

Learning Objectives

StatefulWidget mastery: Multiple states, lifecycle awareness.

Lifecycle methods practice: initState, didUpdateWidget, dispose.

UI layout & styling: Containers, borders, padding, margin, shadows.

Dynamic conditional rendering: Messages, emojis, and colors.

Button interactivity: Disabling at limits, cycling values, resetting.

Parent-to-child state handling: Reacting to changed props in child.