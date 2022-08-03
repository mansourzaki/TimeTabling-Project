// import 'dart:convert';

// import 'dart:io';
// import 'dart:html' as html;
// import 'dart:developer';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:timetabling/file_helper.dart';
// import 'package:timetabling/models/classes.dart';

// class JsonApi {
//   static Future<File> generateFile(Map<String, dynamic> data) async {
//     //final dir = await getApplicationDocumentsDirectory();
//     //print(dir.path);

//     return saveJson(name: 'sec.json', inputFile: data);
//   }

//   static saveJson({
//     required String name,
//     required Map<String, dynamic> inputFile,
//   }) async {
//     try {
//       // final rawData = f.readAsBytesSync();
//       // final content = base64Encode(rawData);
//       // final anchor = html.AnchorElement(
//       //     href: "data:application/octet-stream;charset=utf-16le;base64,$f")
//       //   ..setAttribute("download", "inputJson.json")
//       //   ..click();
//       // final rawData = f.readAsBytesSync();
//       // final content = base64Encode(rawData);
//       final anchor =
//           html.AnchorElement(href: "data:text/json;charset=utf-8,$inputFile")
//             ..setAttribute("download", name)
//             ..click();
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
