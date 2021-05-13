
import 'package:spotify_web_api/src/scopes.dart';

String spotifyApiBaseUrl = "https://accounts.spotify.com/api";

String spotifyBaseUrl = "https://accounts.spotify.com";

Map<SpotifyScopes, String> spotifyScopeList = {
  SpotifyScopes.userReadEmail: "user-read-email",
  SpotifyScopes.playlistReadPrivate: "playlist-read-private",
};