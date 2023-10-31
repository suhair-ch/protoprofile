import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protoprofile/controlloer/profile_control.dart';
import 'package:protoprofile/model/loginmodel.dart';
import 'package:protoprofile/unusedfile/signupmodel.dart';

import 'package:protoprofile/model/add_data.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  StoreData sd = StoreData();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  // File? _pickedImage;

  Uint8List? _image;
  void Selectimage() async {
    Uint8List imG = await pickImage(
      ImageSource.gallery,
    );
    // Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = imG;
    });
  }

  void saveprofile() async {
    String name = _nameController.text;
    int age = int.parse(_ageController.text);

    String resp =
        await StoreData().saveallData(name: name, age: age, file: _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _formKey,
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SAVE YOUR ",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 30)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DATA",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30))
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg.freepik.com%2Fpremium-vector%2Fman-avatar-profile-picture-vector-illustration_268834-538.jpg&tbnid=DPknMIWk0qJ9zM&vet=12ahUKEwjA1YOAi52CAxUy7DgGHYPbDg4QMygEegQIARB4..i&imgrefurl=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fprofile&docid=WIYPytbMl_8XfM&w=626&h=626&q=profile&ved=2ahUKEwjA1YOAi52CAxUy7DgGHYPbDg4QMygEegQIARB4'),
                                    ),
                              Positioned(
                                child: IconButton(
                                  onPressed: Selectimage,
                                  icon: Icon(Icons.add_a_photo),
                                ),
                              ),
                              Column(
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _ageController,
                                    decoration:
                                        InputDecoration(labelText: 'Age'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your age';
                                      }
                                      return null;
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: saveprofile,
                                   
                                    child: Text('Submit'),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){
                                             Navigator.of(context)
                                             .push(MaterialPageRoute(builder: (context) => 
                                             SavedDataes(collectionName: _nameController.text)
                                               )) ;},
                                          child: Icon(Icons.abc_sharp))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])
                ]))));
  }
}
