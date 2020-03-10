import 'dart:convert';

People welcomeFromJson(String str) => People.fromJson(json.decode(str));

String welcomeToJson(People data) => json.encode(data.toJson());

class People {
  int id;
  String name;
  int height;
  int mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  List<String> films;
  List<String> species;
  List<String> vehicles;
  List<String> starships;
  DateTime created;
  DateTime edited;
  String url;

  People({
    this.id,
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
    name: json["name"],
    height: json["height"],
    mass: json["mass"],
    hairColor: json["hair_color"],
    skinColor: json["skin_color"],
    eyeColor: json["eye_color"],
    birthYear: json["birth_year"].toString(),
    gender: json["gender"],
    homeworld: json["homeworld"],
    films: json["films"]==null?[]:List<String>.from(json["films"].map((x) => x)),
    species: json["species"]==null?[]:List<String>.from(json["species"].map((x) => x)),
    vehicles: json["vehicle"]==null?[]:List<String>.from(json["vehicle"].map((x) => x)),
    starships:json["startships"]==null?[]:List<String>.from(json["starships"].map((x) => x)),
    //created: DateTime.parse(json["created"]),
    //edited: DateTime.parse(json["edited"]),
    url: json["url"],
  );

  List<String> checkForNull(dynamic s){
    if(s!=null){
      return List<String>.from(s.map((x)=>x));
    }else{
      return [];
    }
  }


  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "height": height,
    "mass": mass,
    "hair_color": hairColor,
    "skin_color": skinColor,
    "eye_color": eyeColor,
    "birth_year": birthYear,
    "gender": gender,
    "homeworld": homeworld,
    "films": List<dynamic>.from(films.map((x) => x)),
    "species": List<dynamic>.from(species.map((x) => x)),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "starships": List<dynamic>.from(starships.map((x) => x)),
    "created": created.toIso8601String(),
    "edited": edited.toIso8601String(),
    "url": url,
  };

  Map<String, dynamic> toDbJson() => {
    "name": name,
    "height": int.parse(height.toString()),
    "mass": int.parse(mass.toString()),
    "hair_color": hairColor,
    "skin_color": skinColor,
    "eye_color": eyeColor,
    "birth_year": birthYear,
    "gender": gender,
    "homeworld": homeworld,
    "films": List<dynamic>.from(films.map((x) => x)),
    "species": List<dynamic>.from(species.map((x) => x)),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "starships": List<dynamic>.from(starships.map((x) => x)),
    "created": created.toIso8601String(),
    "edited": edited.toIso8601String(),
    "url": url,
  };
}
