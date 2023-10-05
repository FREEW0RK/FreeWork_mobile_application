import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Polling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PollingPage(),
    );
  }
}

class PollingPage extends StatefulWidget {

  static const routeName = '/poll';

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
        title: Text('Quick Polling Page'),
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final List<int> sliderValues;

  NextPage(this.sliderValues);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  bool resultsConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll Results'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Poll Results:',
              style: TextStyle(
                fontSize: 24.0, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int i = 0; i < 10; i++)
              Text(
                'Question ${i + 1}: ${widget.sliderValues[i]}',
                style: TextStyle(
                  fontSize: 20.0, // Increase font size
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Are the results fine?'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      resultsConfirmed = true;
                    });
                  },
                  child: Text('Yes'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context,"/poll");
                  },
                  child: Text('No'),
                ),
              ],
            ),
            if (resultsConfirmed)
              ElevatedButton(
                onPressed: () {
                  // Finish the poll and navigate back to the poll page
                  Navigator.pushReplacementNamed(context,"/main_map");
                },
                child: Text('Finish Poll'),
              ),
          ],
        ),
      ),
    );
  }
}
