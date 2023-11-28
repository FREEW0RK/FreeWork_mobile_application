import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets get to know you better',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const PollingPage(),
    );
  }
}

class PollingPage extends StatefulWidget {

  static const routeName = '/poll';

  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}


class _PollingPageState extends State<PollingPage> {
  List<int> sliderValues = List.generate(10, (index) => 5); // Initialize slider values to 5

  // Define questions for each slider
  List<String> sliderQuestions = [
    'Coffee',
    'Electricity.',
    "Wind safety",
    'Shade',
    'Ergonomics seating',
    'Noise',
    'Restrooms',
    'Food',
    'WiFi',
    'Community ',
    'Remoteness',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Let us know you better'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text(
                  sliderQuestions[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: sliderValues[index].toDouble(),
                  onChanged: (newValue) {
                    setState(() {
                      sliderValues[index] = newValue.round();
                    });
                  },
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: sliderValues[index].toString(),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the next page or perform any action
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPage(sliderValues),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final List<int> sliderValues;

  const NextPage(this.sliderValues, {super.key});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  bool resultsConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll Results'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Poll Results:',
              style: TextStyle(
                fontSize: 24.0, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int i = 0; i < 10; i++)
              Text(
                'Question ${i + 1}: ${widget.sliderValues[i]}',
                style: const TextStyle(
                  fontSize: 20.0, // Increase font size
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Are the results fine?'),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      resultsConfirmed = true;
                    });
                  },
                  child: const Text('Yes'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context,"/poll");
                  },
                  child: const Text('No'),
                ),
              ],
            ),
            if (resultsConfirmed)
              ElevatedButton(
                onPressed: () {
                  // Finish the poll and navigate back to the poll page
                  Navigator.pushReplacementNamed(context,"/home");
                },
                child: const Text('Finish Poll'),
              ),
          ],
        ),
      ),
    );
  }
}
