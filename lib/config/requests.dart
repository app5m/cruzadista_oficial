import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestsWebServices {
  final String urlBase;

  RequestsWebServices(this.urlBase);

  Future<String> sendPostRequest(String urlResquet, dynamic body) async {
    try {
      final response = await http.post(
        Uri.parse(urlBase + urlResquet),

        body: jsonEncode(body),
      );
      print(urlBase + urlResquet);
      print(response.body.toString() + " " + response.statusCode.toString());
      print(body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Falha na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro durante a solicitação POST: $e');
    }
  }

  Future<List<dynamic>> sendPostRequestList(String urlResquet, dynamic body) async {
    try {
      final response = await http.post(
        Uri.parse(urlBase + urlResquet),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print(urlBase + urlResquet);
      print(response.body.toString() + " " + response.statusCode.toString());
      print(body);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody;
      } else {
        throw Exception('Falha na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro durante a solicitação POST: $e');
    }
  }


  Future<String> loginRequestData(String user, String password, String token) async {
    try {
      final url = Uri.parse('$urlBase/login?user=$user&password=$password&token=$token');

      final response = await http.post(url);
      print('$urlBase/login?user=$user&password=$password&token=$token');
      print(response.body.toString() + " " + response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.body.toString();
      } else if(response.statusCode == 401){
        return response.body.toString();
      }
      else {
        throw Exception('Falha na solicitação POST: ${response.statusCode}');
      }

    } catch (e) {
      print('Erro durante a requisição: $e');
      throw Exception('Erro durante a requisição: $e');
    }
  }
}
