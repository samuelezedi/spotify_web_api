
import 'package:spotify_web_api/src/scopes.dart';

String spotifyBaseUrl = "https://accounts.spotify.com/api";

Map<SpotifyScopes, String> spotifyScopeList = {
  SpotifyScopes.userReadEmail: "user-read-email",
  SpotifyScopes.playlistReadPrivate: "playlist-read-private"
};