import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConsumer{
  static fetchMovies() async{
    var url = Uri.https('swapi.dev', '/api/films/');
    var response = await http.get(url);
    if (response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List moviesTitle = [];
      for (var element in jsonResponse['results']) {
        moviesTitle.add(element['title']);
      }
      return moviesTitle;
    }
  }

  static fetchCharacters() async{
    var url = Uri.https('swapi.dev', '/api/people/');
    var response = await http.get(url);
    if (response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List charactersName = [];
      for (var element in jsonResponse['results']) {
        charactersName.add(element['name']);
      }
      return charactersName;
    }
  }
}