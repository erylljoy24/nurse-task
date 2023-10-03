import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:task_nurses/model/nurse_model.dart';

Future<Uint8List> makePdf(List<NurseModel> nurseModel) async {
  final pdf = pw.Document();
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.landscape,
      ),
      build: (context) {
        return pw.Column(
          children: [
            pw.Center(
                child: pw.Column(
                    children: [
                      pw.Text('Medical Telemetry'),
                      pw.Text('Assignment'),
                    ]
                )
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text(date.toString().replaceAll("00:00:00.000", "")),
                    pw.Text('Charge Nurse: Jigzy'),
                  ],
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                ),
              ],
            ),
            pw.Container(height: 30),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.GridView(
                    crossAxisCount: 2,
                    childAspectRatio: .4,
                    children: List<pw.Widget>.generate(
                      nurseModel.length, // Total number of items
                          (index) => pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  nurseModel[index].name,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.ListView.builder(
                                    itemCount: nurseModel[index].tasks.length,
                                    itemBuilder: ((context, index2) {
                                      return pw.Text(
                                          nurseModel[index].tasks[index2],
                                          style: const pw.TextStyle(
                                              fontSize: 9
                                          )
                                      );
                                    })
                                )
                              ]
                          )
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.GridView(
                    crossAxisCount: 2,
                    childAspectRatio: .4,
                    children: List<pw.Widget>.generate(
                        nurseModel.length, // Total number of items
                            (index) => pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                nurseModel[index].name,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.orange
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.ListView.builder(
                                  itemCount: nurseModel[index].tasks.length,
                                  itemBuilder: ((context, index2) {
                                    return pw.Text(
                                        nurseModel[index].tasks[index2],
                                        style: const pw.TextStyle(
                                            fontSize: 9
                                        )
                                    );
                                  })
                              )
                            ]
                        )
                    ),
                  ),
                ),
              ]
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     SizedBox(
            //       width: 500,
            //       child: GridView(
            //         crossAxisCount: 1,
            //         childAspectRatio: .5,
            //         children: List<Widget>.generate(
            //           nurseModel.length, (index) {
            //           print('printEveryOne');
            //           return Container(
            //             alignment: Alignment.center,
            //             child: Text(
            //               nurseModel[index].name,
            //               style: TextStyle(
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.bold,
            //                 color: PdfColors.black
            //               ),
            //             ),
            //             decoration: BoxDecoration(
            //               border: Border.all(),
            //             ),
            //           );
            //         },
            //         ),
            //       )
            //     ),
            //     SizedBox(
            //         width: 500,
            //         child: GridView(
            //           crossAxisCount: 1,
            //           childAspectRatio: .5,
            //           children: List<Widget>.generate(
            //             nurseModel.length, (index) {
            //             print('printEveryOne');
            //             return Container(
            //               alignment: Alignment.center,
            //               child: Text(
            //                 nurseModel[index].name,
            //                 style: TextStyle(
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.bold,
            //                   color: PdfColors.black
            //                 ),
            //               ),
            //               decoration: BoxDecoration(
            //                 border: Border.all(),
            //               ),
            //             );
            //           },
            //           ),
            //         )
            //     ),
            //   ]
            // )
            // ListView.builder(
            //   direction: Axis.horizontal,
            //   itemCount: nurseModel.length,
            //   itemBuilder: ((context, index){
            //     return Container(
            //         padding: const EdgeInsets.only(right: 20),
            //         child: Column(
            //             children: [
            //               Text(
            //                 nurseModel[index].name,
            //                 style: TextStyle(
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               SizedBox(height: 5),
            //               ListView.builder(
            //                   itemCount: nurseModel[index].tasks.length,
            //                   itemBuilder: ((context, index2) {
            //                     return Text(
            //                         nurseModel[index].tasks[index2],
            //                         style: const TextStyle(
            //                             fontSize: 9
            //                         )
            //                     );
            //                   })
            //               )
            //             ]
            //         )
            //     );
            //   }
            //   ),
            // ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );