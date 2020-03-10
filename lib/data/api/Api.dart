
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:majoo_test/model/PeopleResponse.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = "https://swapi.co/api/people/";

  Future<PeopleResponse> fetchPeopleList() async {
    final response = await client.get("$_baseUrl");
    print(response.body.toString());

    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load people');
    }
  }
}