import 'dart:convert';

import 'package:majoo_test/model/people.dart';

PeopleResponse peopleResponseFromJson(String str) => PeopleResponse.fromJson(json.decode(str));

String peopleResponseToJson(PeopleResponse data) => json.encode(data.toJson());

class PeopleResponse {
  int count;
  String next;
  dynamic previous;
  List<People> results;

  PeopleResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PeopleResponse.fromJson(Map<String, dynamic> json) => PeopleResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<People>.from(json["results"].map((x) => People.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}
