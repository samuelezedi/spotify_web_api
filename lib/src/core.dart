

import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify_web_api/src/constants.dart';
import 'package:spotify_web_api/src/endpoints.dart';
import 'package:spotify_web_api/src/scopes.dart';

class SpotifyWebApi {
  String _clientId;
  String _clientSecret;
  String _redirectUri;

  SpotifyWebApi(this._clientId, this._clientSecret,this._redirectUri);

  Future<List<String>> _getAccessToken(String code) async {

    Map<String, dynamic> headers = {
      'content-type' : 'application/x-www-form-urlencoded',
      'Authorization' : "Basic " + base64.encode(utf8.encode("${this._clientId} : ${this._clientSecret}")),
    };

    Map<String, dynamic> body = {
      'grant_type' : 'authorization_code',
      'code' : '$code',
      'redirect_uri' : '$_redirectUri'
    };

    try{
      Uri path = Uri.parse("$spotifyApiBaseUrl"+"${SpotifyEndpoints.token}");
      final response = await post(path,headers: headers,body: body);
      print(response.body);
      final result = jsonDecode(response.body);
      return [result['access_token'],result['refresh_token']];
    }catch(e){
      print(e.toString());
    }

  }
  
  Future<List<String>> getAccessToken(String code) => _getAccessToken(code);

  String _getAuthorization(List<SpotifyScopes> scopes) {
    String allScopes = this.scopesCompiler(scopes);
    String url = "$spotifyBaseUrl/en"+"${SpotifyEndpoints.authorize}?client_id=$_clientId&response_type=code&redirect_uri=$_redirectUri&scope=$allScopes";
    return url;
  }

  getAuthorization(List<SpotifyScopes> scopes) => _getAuthorization(scopes);

  String scopesCompiler(List<SpotifyScopes> scopesList) {
    String scopes = "";
      scopesList.map((v) {
        scopes += "${spotifyScopeList[v]},";
      }).toList();
    return scopes;
  }

}