import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:protoprofile/model/usermodel.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String imageUrl = '';

class StoreData {
  Future<String> uploadimagetostorage(String childname, Uint8List file) async {
    String imageName = DateTime.fromMillisecondsSinceEpoch.toString(); 
    Reference ref = _storage.ref().child(childname).child('new');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveallData(
      {required String name, required int age, required Uint8List file}) async {
    String resp = "some error ";
    try {
      if (name.isNotEmpty) {
        String imageUrl = await uploadimagetostorage(name, file);
        await _firestore
            .collection('newusers')
            .add({'name': name, 'age ': age, 'imagelink': imageUrl});
        resp = 'succce';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Stream<List<User>> getUsers(String collectionName) {
    return _firestore.collection('newusers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return User(
          name: data['name'] ?? 'N/A',
          age: data['age'] as int?,
          imageUrl: data['imagelink'] ?? '',
        );
      }).toList();
    });
  }
}
