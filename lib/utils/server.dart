import 'local.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fetcher {
  static String host = "https://hightech-sweater.herokuapp.com";

  static Future<String> getSavedToken() async {
    String savedToken = await LocalSave.getString("token");

    if (savedToken == null) return "";

    return savedToken;
  }
  
  static Future<bool> testToken() async {
    String token = await getSavedToken();

    if (token.isEmpty) return false;
    
    Map data = await fetch("""
      query {
        me {
          _id
        }
      }
    """, token);
    
    return !data.containsKey("errors");
  }

  static Future<String> getNewToken(String email, String password) async {
    Map data = await fetch("""
      mutation {
        createToken (email: "$email", password: "$password") {
          _id
        }
      }
    """, "");
    
    if (data.containsKey("errors")) return "";
    
    return data["data"]["createToken"]["_id"];
  }

  static Future<bool> authenticate(String email, String password) async {
    String token = await getNewToken(email, password);

    if (token.isEmpty) return false;

    await LocalSave.setString("token", token);
    return true;
  }

  static Future<Map> fetch(String data, String token) async {
    String url = host + "/graphql";

    http.Response resp = await http.post(
        url,
        headers: {
          "token": token,
          "Content-Type": "application/graphql"
        },
        body: data
    );

    return jsonDecode(resp.body);
  }

  static Future<Map> fetchWithToken(String data) async {
    String token = await getSavedToken();

    if (token.isEmpty) return {"error": "Couldn't get token"};

    return await fetch(data, token);
  }
}