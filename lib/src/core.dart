import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify_web_api/src/constants.dart';
import 'package:spotify_web_api/src/endpoints.dart';
import 'package:spotify_web_api/src/model/track.dart';
import 'package:spotify_web_api/src/scopes.dart';

class SpotifyWebApi {
  String _clientId;
  String _clientSecret;
  String _redirectUri;

  SpotifyWebApi(this._clientId, this._clientSecret, this._redirectUri);

  Future<List<String>> _getAccessToken(String code) async {
    Map<String, dynamic> headers = {
      'Authorization': "Basic " +
          base64.encode(utf8.encode("${this._clientId}:${this._clientSecret}")),
    };

    Map<String, dynamic> body = {
      'grant_type': 'authorization_code',
      'code': '$code',
      'redirect_uri': '$_redirectUri'
    };

    try {
      Uri path = Uri.parse("$spotifyApiBaseUrl" + "${SpotifyEndpoints.token}");
      final response = await post(path,
          headers: {
            'Authorization': "Basic " +
                base64.encode(
                    utf8.encode("${this._clientId}:${this._clientSecret}")),
          },
          body: body);
      final result = jsonDecode(response.body);
      return <String>[result['access_token'], result['refresh_token']];
    } catch (e) {
      print('error ' + e.toString());
    }
    return [];
  }

  Future<List<String>> getAccessToken(String code) => _getAccessToken(code);

  Future<List<Map<String, dynamic>>> _getUserPlaylists(
      String accessToken) async {
    try {
      Uri path = Uri.parse("$spotifyPlaylistBaseUrl?limit=50");

      final response = await get(
        path,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<Map<String, dynamic>> playlists = (result['items'] as List)
            .map((e) => {'playlistId': e['id'], 'playlistName': e['name']})
            .toList();
        return playlists;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getUserPlaylists(String accessToken) =>
      _getUserPlaylists(accessToken);


  Future<List<Track>> _getTracksOfPlaylist(
      String accessToken, String playListId) async {
    try {
      Uri path = Uri.parse("$spotifyTrackBaseUrl/$playListId${SpotifyEndpoints.tracks}");
      final response = await get(
        path,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('tracks ' + result.toString());
        List<Track> tracks = (result['items'] as List)
            .map((e) => Track.fromMap(e))
            .toList();
        return tracks;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
    return [];
  }

  Future<List<Track>> getTracksOfPlaylist(String accessToken,String playListId) =>
      _getTracksOfPlaylist(accessToken,playListId);

  String _getAuthorization(List<SpotifyScopes> scopes) {
    String allScopes = this.scopesCompiler(scopes);
    String url = "$spotifyBaseUrl/en" +
        "${SpotifyEndpoints.authorize}?client_id=$_clientId&response_type=code&redirect_uri=$_redirectUri&scope=$allScopes";
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

  Future<dynamic> getPlaylist() => _getPlaylist();

  Future<dynamic> _getPlaylist() async {
    //write what you need here
  }
}
