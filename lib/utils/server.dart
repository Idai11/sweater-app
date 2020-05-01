/*
FILE: server.dart
 */

import 'local.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
This is a helper class for sending requests to the API
It also has helper methods to ease authentication
 */
class Fetcher {
  // API adress
  static String host = "https://hightech-sweater.herokuapp.com";

  /*
  Get the saved authToken from memory
   */
  static Future<String> getSavedToken() async {
    String savedToken = await LocalSave.getString("token");

    if (savedToken == null) return "";

    return savedToken;
  }

  // Test if the saved token is a valid authToken
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

  /*
  Create a new authToken using an email and password
   */
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

  /*
  Try and create a new authToken from email and password
  If success:
    Save the token locally and return true
  Else:
    Return false
   */
  static Future<bool> authenticate(String email, String password) async {
    String token = await getNewToken(email, password);

    if (token.isEmpty) return false;

    await LocalSave.setString("token", token);
    return true;
  }

  /*
  Send a generic GraphQL request to the API
   */
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

  /*
  Send a generic GraphQL request to the API with the saved token
   */
  static Future<Map> fetchWithToken(String data) async {
    String token = await getSavedToken();

    if (token.isEmpty) return {"error": "Couldn't get token"};

    return await fetch(data, token);
  }
}