import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          List<DropdownMenuItem> useritems = [];
          if (!snapshot.hasData) {
            const CircularProgressIndicator();
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            var users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var name = users[index].get('name');
                var age = users[index].get('age');
                var photo = users[index].get('imageLink');

                return ListTile(
                  title: Text(name ?? 'N/A'),
                  subtitle: Text(age?.toString() ?? 'N/A'),
                  leading:,
                );
              },
            );
          }
          // else {
          // final clients = snapshot.data?.docs.reversed.toList();
          // for (var client in clients!);{
          //   useritems.add(DropdownMenuItem(
          //     value: client .
          //     child: child))
          // }
          // }
        },
      ),
    );
  }
}
