import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class QueryService {
  Future<List<String>> getSuggestions(String query) async {
    List<String> results = [];
    try {
      if (query.isEmpty) return results;

      var url = Uri(
          path:
              'http://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=$query');
      var response = await http.get(url);

      var array = json.decode(response.body);
      for (String r in array[1]) {
        results.add(r);
      }
    } on DioError catch (error) {
      print(error);
    }

    return results;
  }
}
