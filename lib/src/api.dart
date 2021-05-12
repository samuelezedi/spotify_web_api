import 'package:flutter/material.dart';
import 'package:spotify_web_api/src/core.dart';
import 'package:spotify_web_api/src/endpoints.dart';
import 'package:spotify_web_api/src/scopes.dart';

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

  Spotify getAuthorizationCode(List<SpotifyScopes> scope) {
      this._authorizationCode = _spotifyWebApi.getAuthorization(scope);
      return this;
  }
}
