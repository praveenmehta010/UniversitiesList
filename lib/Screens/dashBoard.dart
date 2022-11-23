import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/Screens/UniversityList.dart';
import 'package:offsetfarm_assignment/Screens/entry.dart';
import 'package:offsetfarm_assignment/wigets/myButton.dart';

class DashBoardScreen extends StatefulWidget {
  String id;
  DashBoardScreen({super.key, required this.id});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final dataBaseRef = FirebaseDatabase.instance.ref("ProfileData");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Dash Board"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FirebaseAnimatedList(
          query: dataBaseRef,
          itemBuilder: (context, snapshot, animation, index) {
            final profileName = snapshot.child('name').value.toString();
            final profileAge = snapshot.child('age').value.toString();
            final id = snapshot.child('id').value.toString();
            final url = snapshot.child('downloadURL').value.toString();

            return id == widget.id
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(url),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 100,
                            width: 250,
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileName,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    Text(
                                      profileAge,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      myButton(
                        loading: loading,
                        myheight: 70,
                        mywidth: 300,
                        mycolor: Colors.deepPurple,
                        mytitle: "View Universities",
                        ontap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Going wiht online mode will give the latest list of universities"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    myButton(
                                      myheight: 50,
                                      mywidth: 150,
                                      mycolor: Colors.deepPurple,
                                      mytitle: "Online",
                                      ontap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UniversityListScreen(
                                                  choice: true),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 150,
                                    ),
                                    const Text(
                                        "Going wiht offline mode will give the unUpdated list of universities"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    myButton(
                                      myheight: 50,
                                      mywidth: 150,
                                      mycolor: Colors.deepPurple,
                                      mytitle: "Offline",
                                      ontap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UniversityListScreen(
                                                  choice: false),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
