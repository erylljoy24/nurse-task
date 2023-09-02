import 'dart:typed_data';

import 'package:pdf/widgets.dart';
import 'package:task_nurses/model/nurse_model.dart';

Future<Uint8List> makePdf(List<NurseModel> nurseModel) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to: Lorem Ipsum"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
            Container(height: 50),
            ListView.builder(
              itemCount: nurseModel.length,
              itemBuilder: ((context, index){
                  return Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: Theme.of(context).header3.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            )
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