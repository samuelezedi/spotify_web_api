import 'package:flutter/material.dart';
import 'package:spotify_web_api/src/core.dart';
import 'package:spotify_web_api/src/scopes.dart';
import 'package:spotify_web_api/src/view/spotify-webview.dart';

class Spotify {
  String clientID;

  String redirectUrl;

  String clientSecret;

  SpotifyWebApi _spotifyWebApi;

  String _authorizationCode;

  String get authorizationCode => _authorizationCode;

  String _accessToken;

  String get accessToken => _accessToken;

  Spotify(
      {@required this.clientID,
      @required this.clientSecret,
      @required this.redirectUrl})
      : assert(clientID != null),
        assert(clientSecret != null),
        assert(redirectUrl != null) {
    _spotifyWebApi =
        SpotifyWebApi(this.clientID, this.clientSecret, this.redirectUrl);
  }

  Future<Spotify> getAccessToken() async {
    _accessToken = await _spotifyWebApi.getAccessToken();
    return this;
  }

  Future<String> getAuthorizationCode(List<SpotifyScopes> scope,BuildContext context) async {
      this._authorizationCode = _spotifyWebApi.getAuthorization(scope);
      //call Webview
      var data = await Navigator.push(context,MaterialPageRoute(builder: (context)=>SpotifyWebView(url: this._authorizationCode,redirectUrl: this.redirectUrl,)));
      if(data!=null) {
        return data;
      }
      return null;
  }


}
