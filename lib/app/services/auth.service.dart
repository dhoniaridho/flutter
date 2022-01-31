import 'package:http/http.dart' as http;

class AuthService {
  login(payload) async {
    try {
      print(payload);
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await http.post(url, body: payload);
      if (response.statusCode == 400) {
        throw Exception('Invalid credentials');
      } else {
        return response.body;
      }
    } catch (e) {
      throw e;
    }
  }
}
