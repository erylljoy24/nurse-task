import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:task_nurses/model/nurse_model.dart';

Future<Uint8List> makePdf(List<NurseModel> nurseModel) async {
  final pdf = Document();
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  pdf.addPage(
    Page(
      pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4.landscape,
      ),
      build: (context) {
        return Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text('Medical Telemetry'),
                  Text('Assignment'),
                ]
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(date.toString().replaceAll("00:00:00.000", "")),
                    Text('Charge Nurse: Jigzy'),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
            Container(height: 30),
            ListView.builder(
              direction: Axis.horizontal,
              itemCount: nurseModel.length,
              itemBuilder: ((context, index){
                  return Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Text(
                          nurseModel[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        ListView.builder(
                          itemCount: nurseModel[index].tasks.length,
                          itemBuilder: ((context, index2) {
                            return Text(nurseModel[index].tasks[index2]);
                          })
                        )
                      ]
                    )
                  );
                }
              ),
            ),
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