import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  FileHelper._();
  static FileHelper fileHelper = FileHelper._();
  writeInFile(String content) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'test.json';
    String fullPath = join(directory.path, fileName);
    File file = File(fullPath);
    file.writeAsString(content);
  }

  readFromFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'test.txt';
    String fullPath = join(directory.path, fileName);
    File file = File(fullPath);
    String content = await file.readAsString();
    log(content);
  }
}
