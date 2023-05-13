import 'dart:convert';
import 'package:googlemap_demo/model/login_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttPConfig {
//  DbManager handler = DbManager();

  static const String API_BASE = "https://jsonplaceholder.typicode.com/users";
  Future<List<LoginUserDialogModel>> getUserData() async {
    List<LoginUserDialogModel> productModelList = [];
    final response = await http.get(
      Uri.parse(API_BASE),
    );
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      for (var singleProduct in parsed) {

        LoginUserDialogModel productModel = LoginUserDialogModel(
            id: singleProduct['id'],
            name: singleProduct['name'],
            username: singleProduct['username'],
            email: singleProduct['email'],
            address: Address(
                street: singleProduct['address']['street'],
                suite: singleProduct['address']['suite'],
                city: singleProduct['address']['city'],
                zipcode: singleProduct['address']['zipcode'],
                geo: Geo(
                    lat: singleProduct['address']['geo']['lat'],
                    lng: singleProduct['address']['geo']['lng'])),
            phone: singleProduct['phone'],
            website: singleProduct['website'],
            company: Company(
                name: singleProduct['company']['name'],
                catchPhrase: singleProduct['company']['catchPhrase'],
                bs: singleProduct['company']['bs']));
        productModelList.add(productModel);
      }
    }
    return productModelList;
  }
}
