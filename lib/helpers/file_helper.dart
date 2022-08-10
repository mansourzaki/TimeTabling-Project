import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  FileHelper._();
  static FileHelper fileHelper = FileHelper._();
  writeInFile(String content,String name) async { 
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'timetablingProject\\gproject\\classes\\classes$name';
    String fullPath = join(directory.path, fileName);
    File file = File(fullPath);
    file.writeAsString(content);
  }

  readFromFile(String name) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'timetablingProject\\gproject\\classes\\$name';
    String fullPath = join(directory.path, fileName);
    print(fullPath + 'cooom');
    File file = File(fullPath);
    String content = await file.readAsString();
    print(content + 'cooom');
  }


    writeClassinInputFile(String content,String name) async { 
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'timetablingProject\\gproject\\classes\\$name';
    String fullPath = join(directory.path, fileName);
    File file = File(fullPath);
    file.writeAsString(content);
  }
   readMapFromFile(String name) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = 'timetablingProject\\gproject\\classes\\$name';
    String fullPath = join(directory.path, fileName);
    print(fullPath + 'cooom');
    File file = File(fullPath);
    String content = await file.readAsString();
    return content;
  }
}