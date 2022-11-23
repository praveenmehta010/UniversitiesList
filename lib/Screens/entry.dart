import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/services/entry.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  EntryService entryService = EntryService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    entryService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
