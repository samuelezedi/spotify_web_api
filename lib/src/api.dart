import 'package:flutter/material.dart';
import 'package:spotify_web_api/src/core.dart';
import 'package:spotify_web_api/src/endpoints.dart';
import 'package:spotify_web_api/src/scopes.dart';

class Spotify {

  String clientID;

  String redirectUrl;

  String clientSecret;

  SpotifyWebApi _spotifyWebApi;

  SpotifyEndpoints endpoints = SpotifyEndpoints();

  Spotify({@required this.clientID,@required this.clientSecret, @required this.redirectUrl}):assert(clientID!=null),assert(clientSecret!=null),assert(redirectUrl!=null) {
    _spotifyWebApi = SpotifyWebApi(this.clientID,this.clientSecret,this.redirectUrl);
  }

  Future<String> get getAccessToken => _spotifyWebApi.getAccessToken();

  String getAuthorizationCode(List<SpotifyScopes> scope) => _spotifyWebApi.getAuthorization(scope);

}

