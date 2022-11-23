import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offsetfarm_assignment/Screens/dashBoard.dart';
import 'package:offsetfarm_assignment/Screens/entry.dart';
import 'package:offsetfarm_assignment/wigets/customMsg.dart';
import 'package:offsetfarm_assignment/wigets/myButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  final id = DateTime.now().millisecondsSinceEpoch.toString();
  File? _imageFile;
  final picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("Create Profile"),
          actions: [
            IconButton(
              onPressed: () {
                _auth.signOut().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EntryScreen(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _imageFile != null
                          ? Image.file(_imageFile!.absolute)
                          : const Icon(
                              Icons.image,
                              size: 300,
                            ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is a must to create profile";
                          }
                        },
                        controller: _nameController,
                        decoration:
                            const InputDecoration(hintText: "Enter your Name"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Age is a must to create profile";
                          }
                        },
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: "Enter your age"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                myButton(
                  loading: loading,
                  mycolor: Colors.deepPurple,
                  myheight: 50,
                  mywidth: 150,
                  mytitle: "Submit",
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      uploadeProfileData();
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  void uploadeProfileData() {
    final storageDirRef = FirebaseStorage.instance.ref("ProfileImage/$id");
    final uploadTask = storageDirRef.putFile(_imageFile!.absolute);
    Future.value(uploadTask).then((value) async {
      var downloadUrl = await storageDirRef.getDownloadURL();

      final dataBaseRef = FirebaseDatabase.instance.ref("ProfileData");
      dataBaseRef.child(id).set({
        "name": _nameController.text.toString(),
        "age": _ageController.text.toString(),
        "downloadURL": downloadUrl.toString(),
        "id": id,
      });
      CustonMsg().custonMsg("Profile Created");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(id: id),
        ),
      );
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      CustonMsg().custonMsg(error.toString());
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }
}
