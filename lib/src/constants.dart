
import 'package:spotify_web_api/src/scopes.dart';

String spotifyApiBaseUrl = "https://accounts.spotify.com/api";
String spotifyPlaylistBaseUrl = "https://api.spotify.com/v1/me/playlists";
String spotifyTrackBaseUrl = "https://api.spotify.com/v1/playlists";
String spotifyBaseUrl = "https://accounts.spotify.com";

Map<SpotifyScopes, String> spotifyScopeList = {
  SpotifyScopes.userReadEmail: "user-read-email",
  SpotifyScopes.playlistReadPrivate: "playlist-read-private",
  SpotifyScopes.playlistCollaboratePrivate: "playlist-read-collaborative"
};