import 'package:flutter/material.dart';
import 'package:task_nurses/constants/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  String selectedTask = '';
  String selectedBed = '';

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedBed = bedNumber[0];
    selectedTask = tasks[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Telemetry Assignment'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  const Text(
                    'Bed Number: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                        underline: const SizedBox.shrink(),
                        value: selectedBed,
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedBed = newValue!;
                          });
                        },
                        items: bedNumber.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      )
                  )
                ],
              ),

              Row(
                children: [
                  const Text(
                    'Task Assign: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                        underline: const SizedBox.shrink(),
                        value: selectedTask,
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTask = newValue!;
                          });
                        },
                        items: tasks.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
