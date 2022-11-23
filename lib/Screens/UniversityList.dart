import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/models/onlineData.dart';
import 'package:http/http.dart' as http;

class UniversityListScreen extends StatefulWidget {
  final choice;
  const UniversityListScreen({super.key, required this.choice});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  List<MyModel> dataList = [];

  Future<List<MyModel>> getOnlineData() async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=India'),
    );
    var decodeddata = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in decodeddata) {
        dataList.add(MyModel.fromJson(i));
      }
      return dataList;
    } else {
      return dataList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("University List"),
      ),
      body: widget.choice
          ? Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: getOnlineData(),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      } else {
                        return ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 150,
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                          content: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                      "--- ${dataList[index].name.toString()} ---"),
                                                  Text(
                                                      " State ==> ${dataList[index].stateProvince.toString()}"),
                                                  Text(
                                                      " Country ==> ${dataList[index].country.toString()}"),
                                                  Text(
                                                      " Domain ==> ${dataList[index].domains![0].toString()}"),
                                                  Text(
                                                      " State ==> ${dataList[index].webPages![0].toString()}"),
                                                ],
                                              ),
                                            ),
                                          ));
                                    },
                                  );
                                },
                                child: Card(
                                  elevation: 10,
                                  shadowColor: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            "--- ${dataList[index].name.toString()} ---"),
                                        Text(
                                            " State ==> ${dataList[index].stateProvince.toString()}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ),
              ],
            )
          : FutureBuilder(
              builder: (context, snapshot) {
                var myJsondata = json.decode(snapshot.data.toString());
                return ListView.builder(
                    itemCount: myJsondata.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    backgroundColor: Colors.lightBlueAccent,
                                    content: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "---${myJsondata[index]["name"]}---",
                                              style:
                                                  const TextStyle(fontSize: 25),
                                            ),
                                            Text(
                                              " State-Province ==> ${myJsondata[index]["state-province"]}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              " Country ==> ${myJsondata[index]["country"]}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              " Domain ==> ${myJsondata[index]["domains"][0]}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              " Web-Site ==> ${myJsondata[index]["web_pages"][0]}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("--- ${myJsondata[index]["name"]}---"),
                                  Text(
                                      " State ==> ${myJsondata[index]["state-province"]}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              future: DefaultAssetBundle.of(context)
                  .loadString("lib/models/my.json"),
            ),
    );
  }
}
