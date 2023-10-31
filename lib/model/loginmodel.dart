import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:protoprofile/model/add_data.dart';
import 'package:protoprofile/model/usermodel.dart';

class SavedDataes extends StatefulWidget {
  final String collectionName; // Set this value based on user input
  final StoreData controller;
  SavedDataes({required this.collectionName}) : controller = StoreData();

  @override
  State<SavedDataes> createState() => _SavedDataesState();
}

class _SavedDataesState extends State<SavedDataes> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final StoreData sdd = StoreData();

  Uint8List? imageData;

  Future<void> uploadimage(
      {required String name, required Uint8List file}) async {
    if (imageData != null) {
      final String imageurl = await sdd.uploadimagetostorage(name, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('USERA DETAILS'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark)),
        body: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Align(
                    alignment: const AlignmentDirectional(3, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.3),
                    child: Container(
                      height: 500,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 8, 113, 211)),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 400,
                      width: 600,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  StreamBuilder<List<User>>(
                      stream: sdd.getUsers(widget.collectionName),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        var userData = snapshot.data!;

                        return ListView.builder(
                          itemCount: userData.length,
                          itemBuilder: (context, index) {
                            var user = userData[index];
                            var Age = userData[index].age;
                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.imageUrl),
                                ),
                                title: Text('Name: ${user.name}'),
                                subtitle: 
                                 user.age != null
                                    ? Text('Age: ${user.age}')
                                    : Text('Age: N/A'),
                                );
                          },
                        );
                      }),
                ]))));
  }
}
