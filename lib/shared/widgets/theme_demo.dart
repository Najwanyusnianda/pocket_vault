import 'package:flutter/material.dart';

class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Modern Fortress Theme Demo'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Typography Demo
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Typography (Nunito Font)',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Display Large',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    'Headline Large',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Title Large',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Body Large - The Modern Fortress theme provides a clean, secure feeling with the blue-grey color palette.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Body Medium - Perfect for document management applications.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Button Demo
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buttons',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Elevated'),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Filled'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Outlined'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Text'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Form Demo
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Form Elements',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Document Title',
                      hintText: 'Enter document title',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter description',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // List Demo
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'List Items',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Passport'),
                  subtitle: const Text('Expires in 2 years'),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text('Driver\'s License'),
                  subtitle: const Text('Valid until 2026'),
                  trailing: const Icon(Icons.warning, color: Colors.orange),
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text('Credit Card'),
                  subtitle: const Text('Bank of Security'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
