import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';
import 'package:timetabling/services/api.dart';

class ShellHelper {
  ShellHelper._();
  static ShellHelper shellHelper = ShellHelper._();
  final Shell _shell = Shell();

  runGrouping() async {
    io.Directory path = await getApplicationDocumentsDirectory();
    print(path.path);
    // await shell.run('c:');
    await _shell.run(
        'c: && cd ${path.path}//timetablingProject//gproject && python grouping.py');
  }

  runFirstSolution() async {
    io.Directory path = await getApplicationDocumentsDirectory();
    print(path.path);
    // await shell.run('c:');
    // final x = await _shell.run(
    //     'c: && cd ${path.path}//timetablingProject//gproject && python grouping.py');
    final x = await _shell.run(
        'c: && cd ${path.path}//timetablingProject//gproject && python grouping.py',
        );
    
  
     
    //return x;
  }

  stopMutation(){
    
    _shell.kill();
  }

  runMutation() async {
    io.Directory path = await getApplicationDocumentsDirectory();
    print(path.path);
    // await shell.run('c:');

    final x = await _shell.run(
        'c: && cd ${path.path}//timetablingProject//gproject && python mutation.py');
    print(x);
  }
}
