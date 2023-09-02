import 'package:flutter/material.dart';
import 'package:task_nurses/model/nurse_model.dart';
import 'package:task_nurses/pages/pdf/pdf_export.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  List<NurseModel> nurseModel;
  PdfPreviewPage({Key? key, required this.nurseModel}) : super(key: key);

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