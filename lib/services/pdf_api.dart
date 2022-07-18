// import 'dart:convert';
// import 'dart:io';
// import 'dart:html' as html;
// import 'package:flutter/services.dart';
// //import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// import 'package:timetabling/shared/constants.dart';

// import '../models/subject.dart';

// class PdfApi {
//   static Future<File> generateTable(List<Subject> subjects) async {
//     //final dir = await getApplicationDocumentsDirectory();
//     //print(dir.path);
//     final pdf = Document();

//     final headers = [
//       'Subject',
//       'Lecturer Name',
//       'Group',
//       'ClassRoom',
//       saturday,
//       sunday,
//       monday,
//       tuesday,
//       wednesday
//     ];

//     final data = subjects
//         .map((e) => [
//               e.subject,
//               e.lecturer,
//               e.group[0],
//               e.assignedClassroom,
//               e.daysNum() == 33 || e.daysNum() == 1 ? e.getTime : '',
//               e.daysNum() == 22 || e.daysNum() == 2 ? e.getTime : '',
//               e.daysNum() == 33 || e.daysNum() == 3 ? e.getTime : '',
//               e.daysNum() == 22 || e.daysNum() == 4 ? e.getTime : '',
//               e.daysNum() == 33 || e.daysNum() == 5 ? e.getTime : '',
//             ])
//         .toList();

//     pdf.addPage(MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         orientation: PageOrientation.landscape,
//         build: (context) => [
//               Table.fromTextArray(
//                 headers: headers,
//                 data: data,
//               ),
//             ]));

//     return openPdf(name: 'table.pdf', pdf: pdf);
//   }

//   static Future<File> generateImage() async {
//     final pdf = Document();

//     final imageSvg = await rootBundle.loadString('assets/fruit.svg');
//     final imageJpg =
//         (await rootBundle.load('assets/person.jpg')).buffer.asUint8List();

//     final pageTheme = PageTheme(
//       pageFormat: PdfPageFormat.a4,
//       buildBackground: (context) {
//         if (context.pageNumber == 1) {
//           return FullPage(
//             ignoreMargins: true,
//             child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );

//     pdf.addPage(
//       MultiPage(
//         pageTheme: pageTheme,
//         build: (context) => [
//           Container(
//             height: pageTheme.pageFormat.availableHeight - 1,
//             child: Center(
//               child: Text(
//                 'Foreground Text',
//                 style: TextStyle(color: PdfColors.white, fontSize: 48),
//               ),
//             ),
//           ),
//           SvgImage(svg: imageSvg),
//           Image(MemoryImage(imageJpg)),
//           Center(
//             child: ClipRRect(
//               horizontalRadius: 32,
//               verticalRadius: 32,
//               child: Image(
//                 MemoryImage(imageJpg),
//                 width: pageTheme.pageFormat.availableWidth / 2,
//               ),
//             ),
//           ),
//           GridView(
//             crossAxisCount: 3,
//             childAspectRatio: 1,
//             children: [
//               SvgImage(svg: imageSvg),
//               SvgImage(svg: imageSvg),
//               SvgImage(svg: imageSvg),
//               SvgImage(svg: imageSvg),
//               SvgImage(svg: imageSvg),
//               SvgImage(svg: imageSvg),
//             ],
//           )
//         ],
//       ),
//     );

//     return openPdf(name: 'my_example.pdf', pdf: pdf);
//   }

//   static openPdf({
//     required String name,
//     required Document pdf,
//   }) async {
//     final bytes = await pdf.save();

//     // File file = // generated somewhere
//     // final rawData = file.readAsBytesSync();
//     try {
//       final content = base64Encode(bytes);
//       final anchor = html.AnchorElement(
//           href:
//               "data:application/octet-stream;charset=utf-16le;base64,$content")
//         ..setAttribute("download", "file.pdf")
//         ..click();
//     } catch (e) {
//       print(e);
//     }

//     // downloadFile("https://images.unsplash.com/photo-1655667995118-56d57c6f628e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=714&q=80");
//   }

//   // static downloadFile(String url) {
//   //   html.AnchorElement anchorElement = html.AnchorElement(href: url);
//   //   anchorElement.download = "test";
//   //   anchorElement.click();
//   // }

//   // static Future openFile(File file) async {
//   //   final url = file.path;

//   //   await OpenFile.open(url);
//   // }
// }
