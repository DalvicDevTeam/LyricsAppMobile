import 'dart:convert';
import 'package:dalvic_lyrics_sharing_app/data_provider/BaseDataProvider.dart';
import 'package:dalvic_lyrics_sharing_app/models/user.dart';
import 'package:http/http.dart' as http;

class SignUpDataProvider extends BaseDataProvider{
  Future<User> signUp(User user)async{
    var response = await http.post('$baseUrl/register', body: {
      'name':user.name,
      'email':user.email,
      'password':user.password,
      'password_confirmation':user.password,
    });

    if(response.statusCode == 200){
      var rawResponse = jsonDecode(response.body)['response'];
      User user = User.fromJsonComplete(rawResponse['user']);
      var token = rawResponse['token'];
      user.token = token;
      return user;
    }else{
      print(response.body);
      throw Exception("Something went wrong");
    }
  }
}