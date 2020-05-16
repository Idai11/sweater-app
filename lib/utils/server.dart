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
  // API address
  static String host = "https://hightech-sweater.herokuapp.com";

  /*
  Get the saved authToken from memory
   */
  static Future<String> getSavedToken() async {
    // Get the token from storage using LocalSave
    String savedToken = await LocalSave.getString("token");

    // If the token does not exist in storage, return an empty string
    if (savedToken == null) return "";

    return savedToken;
  }

  // Test if the saved token is a valid authToken
  static Future<bool> testToken() async {
    // Get saved token
    String token = await getSavedToken();

    // If the token does not exist, the token is not valid
    if (token.isEmpty) return false;

    // Try to get the user using a token
    Map data = await fetch("""
      query {
        me {
          _id
        }
      }
    """, token);

    // If request was a success, the token is valid
    return !data.containsKey("errors");
  }

  /*
  Create a new authToken using an email and password
   */
  static Future<String> getNewToken(String email, String password) async {
    // Create the token
    Map data = await fetch("""
      mutation {
        createToken (email: "$email", password: "$password") {
          _id
        }
      }
    """, "");

    // If request failed, return an empty token
    if (data.containsKey("errors")) return "";

    // Otherwise return created token
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

    // If getNewToken returned an empty token, the creation failed
    if (token.isEmpty) return false;

    await LocalSave.setString("token", token);
    return true;
  }

  /*
  Send a generic GraphQL request to the API
   */
  static Future<Map> fetch(String data, String token) async {
    // Get the graphQl endpoint url
    String url = host + "/graphql";

    // Make a request with the given data, token and relevant headers
    http.Response resp = await http.post(
        url,
        headers: {
          "token": token,
          "Content-Type": "application/graphql" // This tells the API that this is a GraphQl request
        },
        body: data
    );

    // Decode the string response into a Dart object
    return jsonDecode(resp.body);
  }

  /*
  Send a generic GraphQL request to the API with the saved token
  This is a time saver
   */
  static Future<Map> fetchWithToken(String data) async {
    String token = await getSavedToken();

    // Check if a saved token exists
    if (token.isEmpty) return {"error": "Couldn't get token"};

    // Use that token to fetch
    return await fetch(data, token);
  }
}