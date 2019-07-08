//model
import 'package:flutter/material.dart';

class Movie {
  String title, posterPath, id, overview;
  bool favored, isExpand;

  Movie(
      {@required this.title,
      @required this.posterPath,
      @required this.id,
      @required this.overview,
      this.favored,
      this.isExpand});

  Movie.fromJson(Map json)
      : title = json["title"],
        posterPath = json["posterPath"],
        id = json["id"],
        overview = json["overview"],
        favored = false;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['posterPath'] = posterPath;
    map['overview'] = overview;
    map['favored'] = favored;
    return map;
  }

  Movie.fromDb(Map map)
      : title = map["title"],
        posterPath = map["posterPath"],
        id = map["id"],
        overview = map["overview"],
        favored = (map['favored'] == 1);
}
