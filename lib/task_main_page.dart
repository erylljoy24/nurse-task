import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_nurses/constants/constants.dart';
import 'package:task_nurses/model/nurse_model.dart';
import 'package:task_nurses/model/pct_model.dart';
import 'package:task_nurses/pages/pdf_preview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<NurseModel> nurseModel = [];
  List<PctModel> pctModel = [];
  String selectedTask = '';
  String selectedBed = '';
  String tempSelectedBed = '';
  bool itContains = false;

  int x = 1;
  int y = 9;

  void _incrementCounter() {
    NurseModel model = nurseModel.last;

    setState(() {
      if(model.tasks.length == 5){
        _showAlertDialog('List already full');
      } else {
        for(var v in nurseModel) {
          if(x == v.id && v.tasks.length < 6) {
            print('printIndexHere $x');
            String selectedItem = '$selectedBed - $selectedTask';
            for (int i = 0; v.tasks.length > i; i++) {
              if (v.tasks[i].contains(selectedBed)) {
                // x-1;
                itContains = true;
                selectedItem = v.tasks[i] += ', $selectedTask';
                v.tasks[i] = selectedItem;

              }
            }
            v.tasks.add(selectedItem);
          }
        }
        print('printTrue $tempSelectedBed $selectedBed');
        if(tempSelectedBed != selectedBed) {
          if(x == 9) {
            x = 1;
          } else {
            x++;
          }
        } else {
          print('itGoesHere true');
        }
        tempSelectedBed = selectedBed;

      }
    });
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
    rootBundle.loadString('assets/data/pct-data.json').then((value) {
      List list = json.decode(value);
      for (var v in list) {
        pctModel.add(PctModel.fromJson(v));
      }
    });
  }

  Future<void> _showAlertDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wrong input'),
          content: SingleChildScrollView(
            child: Text(message)
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the first grid
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          childAspectRatio: 4,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nurseModel[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: nurseModel[index].tasks.length,
                                    itemBuilder: ((context, index2) {
                                      return Text(
                                          nurseModel[index].tasks[index2],
                                          style: const TextStyle(
                                              fontSize: 16
                                          )
                                      );
                                    })
                                )
                              ]
                          );
                        },
                        itemCount: nurseModel.length,// Total number of items in the first GridView
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the first grid
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pctModel[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: pctModel[index].tasks.length,
                                    itemBuilder: ((context, index2) {
                                      return Text(
                                          pctModel[index].tasks[index2],
                                          style: const TextStyle(
                                              fontSize: 16
                                          )
                                      );
                                    })
                                )
                              ]
                          );
                        },
                        itemCount: pctModel.length,/// Total number of items in the first GridView
                      ),
                    ),
                  ],
                ),
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
                              if(newValue!.contains('West Side') || newValue!.contains('South Side')) {
                                _showAlertDialog('Please select a correct room.');
                              } else {
                                selectedBed = newValue;
                              }
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
                        builder: (context) => PdfPreviewPage(nurseModel: nurseModel, pctData: pctModel,),
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
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
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