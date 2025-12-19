import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ==================== NOTIFIERS ====================
class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData get theme => _isDark ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class UserNotifier extends ChangeNotifier {
  String _name = 'Guest';
  int _age = 0;
  bool _isLoggedIn = false;

  String get name => _name;
  int get age => _age;
  bool get isLoggedIn => _isLoggedIn;

  void login(String name, int age) {
    _name = name;
    _age = age;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _name = 'Guest';
    _age = 0;
    _isLoggedIn = false;
    notifyListeners();
  }
}

// ==================== MAIN DEMO SCREEN ====================
class ProviderDemo extends StatelessWidget {
  const ProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CounterNotifier()),
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => UserNotifier()),
    ], child: ProviderDemoHome());
  }
}

class ProviderDemoHome extends StatelessWidget {
  const ProviderDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider & ChangeNotifier Demo'),
        backgroundColor: themeNotifier.isDark ? Colors.grey[900] : Colors.blue,
        actions: [
          // Theme Toggle Button (using read)
          IconButton(
            onPressed: () => context.read<ThemeNotifier>().toggleTheme(),
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('1. Counter Example (watch vs Consumer)'),
            _CounterSection(),
            SizedBox(height: 32),
            _SectionHeader('2. User Management (Selector Example)'),
            _UserSection(),
            SizedBox(height: 32),
            _SectionHeader('3. Performance Comparison'),
            _PerformanceSection(),
            SizedBox(height: 32),
            _SectionHeader('4. Multiple Notifiers Access'),
            _MultipleNotifiersSection(),
          ],
        ),
      ),
    );
  }
}

// ==================== SECTION COMPONENTS ====================
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CounterSection extends StatelessWidget {
  const _CounterSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Using context.watch (rebuilds entire widget):'),
            const SizedBox(height: 8),
            _CounterDisplayWatch(),
            const SizedBox(height: 16),
            const Text('Using Consumer (rebuilds only Consumer):'),
            const SizedBox(height: 8),
            _CounterDisplayConsumer(),
            const SizedBox(height: 16),
            const Text('Action Buttons (using context.read):'),
            const SizedBox(height: 8),
            _CounterButtons(),
          ],
        ),
      ),
    );
  }
}

class _CounterDisplayWatch extends StatelessWidget {
  const _CounterDisplayWatch();

  @override
  Widget build(BuildContext context) {
    print('🔄 _CounterDisplayWatch rebuilt');
    final counter = context.watch<CounterNotifier>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.refresh, color: Colors.blue),
          const SizedBox(width: 8),
          Text('Watch Count: ${counter.count}'),
          const Spacer(),
          const Text('(Check console for rebuilds)',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _CounterDisplayConsumer extends StatelessWidget {
  const _CounterDisplayConsumer();

  @override
  Widget build(BuildContext context) {
    print('🏗️ _CounterDisplayConsumer built (static part)');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.build, color: Colors.green),
          const SizedBox(width: 8),
          Consumer<CounterNotifier>(
            builder: (context, counter, child) {
              print('🎯 Consumer rebuilt');
              return Text('Consumer Count: ${counter.count}');
            },
          ),
          const Spacer(),
          const Text('(Only Consumer rebuilds)',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _CounterButtons extends StatelessWidget {
  const _CounterButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => context.read<CounterNotifier>().increment(),
          child: const Text('+'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => context.read<CounterNotifier>().decrement(),
          child: const Text('-'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => context.read<CounterNotifier>().reset(),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

class _UserSection extends StatelessWidget {
  const _UserSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Using Selector (rebuilds only when specific data changes):'),
            const SizedBox(height: 8),

            // Name selector - only rebuilds when name changes
            Selector<UserNotifier, String>(
              selector: (context, user) => user.name,
              builder: (context, name, child) {
                print('👤 Name selector rebuilt');
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Name: $name'),
                );
              },
            ),
            const SizedBox(height: 8),

            // Age selector - only rebuilds when age changes
            Selector<UserNotifier, int>(
              selector: (context, user) => user.age,
              builder: (context, age, child) {
                print('🎂 Age selector rebuilt');
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Age: $age'),
                );
              },
            ),
            const SizedBox(height: 16),

            _UserButtons(),
          ],
        ),
      ),
    );
  }
}

class _UserButtons extends StatelessWidget {
  const _UserButtons();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, user, child) {
        return Row(
          children: [
            if (!user.isLoggedIn) ...[
              ElevatedButton(
                onPressed: () =>
                    context.read<UserNotifier>().login('John Doe', 25),
                child: const Text('Login as John'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () =>
                    context.read<UserNotifier>().login('Jane Smith', 30),
                child: const Text('Login as Jane'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () => context.read<UserNotifier>().logout(),
                child: const Text('Logout'),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Performance Comparison (Check console for rebuild logs):'),
            const SizedBox(height: 16),
            const Text('❌ Bad: Expensive widget that rebuilds unnecessarily'),
            _ExpensiveWidgetBad(),
            const SizedBox(height: 16),
            const Text('✅ Good: Expensive widget with Consumer protection'),
            _ExpensiveWidgetGood(),
          ],
        ),
      ),
    );
  }
}

class _ExpensiveWidgetBad extends StatelessWidget {
  const _ExpensiveWidgetBad();

  @override
  Widget build(BuildContext context) {
    print('💸 Expensive widget (BAD) rebuilt - this is wasteful!');
    final counter = context.watch<CounterNotifier>();

    // Simulate expensive computation
    int expensiveComputation = 0;
    for (int i = 0; i < 1000000; i++) {
      expensiveComputation += i;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Counter: ${counter.count}'),
          Text('Expensive computation: $expensiveComputation'),
          const Text('This rebuilds every time counter changes!',
              style: TextStyle(fontSize: 12, color: Colors.red)),
        ],
      ),
    );
  }
}

class _ExpensiveWidgetGood extends StatelessWidget {
  const _ExpensiveWidgetGood();

  @override
  Widget build(BuildContext context) {
    print('🏗️ Expensive widget (GOOD) built - only once!');

    // Simulate expensive computation
    int expensiveComputation = 0;
    for (int i = 0; i < 1000000; i++) {
      expensiveComputation += i;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<CounterNotifier>(
            builder: (context, counter, child) {
              print('🎯 Only Consumer part rebuilt');
              return Text('Counter: ${counter.count}');
            },
          ),
          Text('Expensive computation: $expensiveComputation'),
          const Text(
              'Only the Consumer rebuilds, not the expensive computation!',
              style: TextStyle(fontSize: 12, color: Colors.green)),
        ],
      ),
    );
  }
}

class _MultipleNotifiersSection extends StatelessWidget {
  const _MultipleNotifiersSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Accessing Multiple Notifiers:'),
            const SizedBox(height: 16),
            const Text('Using Consumer2:'),
            const SizedBox(height: 8),
            Consumer2<CounterNotifier, UserNotifier>(
              builder: (context, counter, user, child) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Counter: ${counter.count}'),
                      Text('User: ${user.name} (${user.age} years old)'),
                      Text(
                          'Status: ${user.isLoggedIn ? "Logged In" : "Guest"}'),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text('Using context.select for specific data:'),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                final count =
                    context.select<CounterNotifier, int>((c) => c.count);
                final userName =
                    context.select<UserNotifier, String>((u) => u.name);

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('$userName has clicked $count times'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
