import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetabling/models/classes.dart';

class FbHelper {
  FbHelper._();
  static FbHelper fbHelper = FbHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> selectAllLecturers() async {
    final snapshot = await firestore.collection('lecturers').get();
    List<String> lecs = [];
    snapshot.docs.forEach((element) {
      lecs.add(element.data()['name']);
    });
    lecs = lecs.toSet().toList();
    // print(lecs);
    return lecs;
  }

  addNewLecturer(String name, int load) async {
    await firestore
        .collection('lecturers')
        .add({'name': name, 'maxLoad': load});
    print('added $name');
  }

  addNewClassroom(String name, List<String> rooms) async {
    await firestore.collection('classrooms').add({'name': rooms});
  }

  addRoom(String building, String room) async {
    final doc = await firestore
        .collection('classrooms')
        .where(building, isNotEqualTo: '5')
        .get();
    var x = await doc.docs.first.data().update(building, (value) {
      value.add(room);
    });
    print(x);
  }

  Future<List<Classes>> selectAllClasses() async {
    final ref = await firestore.collection('classes').orderBy('for').get();

    List s = ref.docs.map((e) => e.data()).toList();
    List<Classes> cls = s.map((e) => Classes.fromJson(e)).toList();

    return cls;
  }

  addNewClass(Classes classes) async {
    final ref = await firestore.collection('classes').add(classes.toJson());
    print('added');
  }

  removeClass(Classes classes) async {
    final ref = await firestore
        .collection('classes')
        .where('Subject', isEqualTo: classes.subject)
        .get();
    ref.docs.first.reference.delete();
    print('deleted');
  }

  Future<Map<String, dynamic>> selectAllDepartments() async {
    final ref = await firestore.collection('departments').get();
    var x = ref.docs.first.data() as Map<String, dynamic>;
    print(x);
    return x;
  }

  updateDepsCapacity(String name, int capacity) async {
    final ref = await firestore.collection('departments').get();
    await ref.docs.first.reference.update({name: capacity});
    print('upadted $name');
  }

  Future<Map<String, dynamic>> selectAllClassrooms() async {
    final ref = await firestore.collection('classrooms').get();
    List s = ref.docs.map((e) => e.data()).toList();
    Map<String, dynamic> map = {};
    s.forEach((element) {
      map.addAll(element);
    });
    print(map);
    return map;
  }
}
