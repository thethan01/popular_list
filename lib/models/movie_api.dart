import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:popular_list/models/movie.dart';

class MovieApi {


  static Future<List<Movie>> getMovie() async{
    const String apikey = '26763d7bf2e94098192e629eb975dab0';
    const String  baseurl = 'https://api.themoviedb.org/3/discover';
    var url = '$baseurl/movie?api_key=$apikey&page=1';
    final Uri url_lt = Uri.parse(url);
    final response = await http.get(url_lt);
    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['results']){
      _temp.add(i);
    }
    return Movie.movieFromSnapshot(_temp);
  }
}