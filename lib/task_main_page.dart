import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_nurses/constants/constants.dart';
import 'package:task_nurses/model/nurse_model.dart';
import 'package:task_nurses/pages/pdf_preview.dart';

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

  List<NurseModel> nurseModel = [];
  String selectedTask = '';
  String selectedBed = '';

  int x = 1;
  int y = 9;

  void _incrementCounter() {
    print('printExecuted true');
    setState(() {
      for(var v in nurseModel) {
        if(x == v.id && v.tasks.length < 6){
          v.tasks.add(selectedBed);
        }
      }
      // if(x == 9)
      x++;
    });
    print('printExecuted ${nurseModel[0].tasks}');
  }

  @override
  void initState() {
    super.initState();
    selectedBed = bedNumber[0];
    selectedTask = tasks[0];

    rootBundle.loadString('assets/data/nurse-data.json').then((value) {
      List list = json.decode(value);
      for (var v in list) {
        nurseModel.add(NurseModel.fromJson(v));
      }
    });
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
              const SizedBox(height: 10,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewPage(nurseModel: nurseModel),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFF725C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Color(0xFFFF725C))),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Text(
                    'Generate PDF',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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
