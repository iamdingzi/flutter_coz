import 'package:flutter/material.dart';
import 'package:flutter_coz/MovieDatabase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

import 'movie_model.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Movie> filteredMovies = List();
  List<Movie> movieCache = List();

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    filteredMovies = [];
    movieCache = [];
    subject.stream.listen(searchDataList);
    setupList();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void setupList() async {
    MovieDatabase db = MovieDatabase();
    filteredMovies = await db.getMovies();
    setState(() {
      movieCache = filteredMovies;
    });
  }

  void searchDataList(query) {
    if (query.isEmpty) {
      setState(() {
        filteredMovies = movieCache;
      });
    }

    setState(() {});

    filteredMovies = filteredMovies
        .where((m) => m.title
            .toLowerCase()
            .trim()
            .contains(RegExp(r'' + query.toLowerCase().trim() + '')))
        .toList();

    setState(() {});
  }

  void onPressed(int index) {
    MovieDatabase db = MovieDatabase();
    db.deleteMovie(filteredMovies[index].id);

    setState(() {
      filteredMovies.remove(filteredMovies[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (str) => subject.add(str),
            keyboardType: TextInputType.url,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  initiallyExpanded: filteredMovies[index].isExpand ?? false,
                  onExpansionChanged: (b) => filteredMovies[index].isExpand = b,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                            text: filteredMovies[index].overview,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300)),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share('${filteredMovies[index].title}');
                      },
                    )
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onPressed(index);
                    },
                  ),
                  title: Container(
                    height: 200,
                    child: Row(
                      children: <Widget>[
                        filteredMovies[index].posterPath != null
                            ? Hero(
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w92${filteredMovies[index].posterPath}"),
                                tag: filteredMovies[index].id,
                              )
                            : Container(),
                        Expanded(
                          child: Text(
                            filteredMovies[index].title,
                            textAlign: TextAlign.center,
                            maxLines: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
