import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:googlemap_demo/handler/database_handler.dart';
import 'package:googlemap_demo/home_page.dart';
import 'package:googlemap_demo/http_config.dart';
import 'package:googlemap_demo/main.dart';
import 'package:googlemap_demo/model/login_user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<LoginUserDialogModel> userList = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.teal.shade500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ' Enter Email Address',
                contentPadding: EdgeInsets.only(top: 14),
              ),
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.teal.shade500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ' Enter Password',
                contentPadding: EdgeInsets.only(top: 14),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Login"))
          ]),
    );
  }

  void checkLogin() {
    userList.forEach((element) {
      if (element.email.toLowerCase() == emailController.text.toLowerCase()) {
        Map<String, dynamic> map = {
          "id": element.id,
          "name": element.name,
          "username": element.username,
          "email": element.email,
          "phone": element.phone,
          "website": element.website,
          "companyName": element.company.name,
          "catchPhrase": element.company.catchPhrase,
          "bs": element.company.bs,
          "street": element.address.street,
          "suite": element.address.suite,
          "city": element.address.city,
          "lat": element.address.geo.lat,
          "lng": element.address.geo.lng,
          "zipcode": element.address.zipcode
        };
        DbManager().insertModel(map);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsPage(),
            ));
      }
    });
  }

  void getUserData() async {
    userList = await HttPConfig().getUserData();
  }
}
