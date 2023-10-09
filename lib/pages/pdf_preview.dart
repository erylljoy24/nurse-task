import 'package:flutter/material.dart';
import 'package:task_nurses/model/nurse_model.dart';
import 'package:task_nurses/model/pct_model.dart';
import 'package:task_nurses/pages/pdf/pdf_export.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  List<NurseModel> nurseModel;
  List<PctModel> pctData;
  PdfPreviewPage({Key? key, required this.nurseModel, required this.pctData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(nurseModel),
      ),
    );
  }
}