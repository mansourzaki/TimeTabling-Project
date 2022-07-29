// import 'dart:convert';

// import 'dart:io';
// import 'dart:html' as html;

// import 'package:timetabling/models/classes.dart';

// class JsonApi {
//   static Future<File> generateFile(List<Classes> classes) async {
//     //final dir = await getApplicationDocumentsDirectory();
//     //print(dir.path);

//     final data = classes
//         .map(
//           (e) => e.toMap(),
//         )
//         .toList();

//     return saveJson(name: 'sec.json', inputFile: data);
//   }

//   static saveJson({
//     required String name,
//     required List<Map<String, dynamic>> inputFile,
//   }) async {
//     // File file = // generated somewhere
//     // final rawData = file.readAsBytesSync();
//     try {
//       final content = jsonEncode(inputFile);
//       final anchor = html.AnchorElement(
//           href:
//               "data:application/octet-stream;charset=utf-16le;base64,$content")
//         ..setAttribute("download", "inputJson.json")
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
