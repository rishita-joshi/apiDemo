import 'package:flutter/material.dart';
import 'package:googlemap_demo/handler/database_handler.dart';
import 'package:googlemap_demo/model/login_user_model.dart';

class UserDetailsPage extends StatefulWidget {
  UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  List<LoginUserDialogModel> loginUserDialogModel = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    setState(() async {
      loginUserDialogModel = await DbManager().getModelList();
    });
    print("----> ${loginUserDialogModel}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListTile(
        title: Text(loginUserDialogModel.first.email),
        subtitle: Text(loginUserDialogModel.first.name),
      )),
    );
  }
}
