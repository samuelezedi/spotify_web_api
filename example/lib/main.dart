import 'package:flutter/material.dart';
import 'package:spotify_web_api/spotify_web_api.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CheckSpot(),
    );
  }
}

class CheckSpot extends StatefulWidget {
  @override
  _CheckSpotState createState() => _CheckSpotState();
}

class _CheckSpotState extends State<CheckSpot> {
  List<Playlist> playlists = [];
  List<String> tokenList = [];
  List<Track> tracks = [];
  Spotify sp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sp = Spotify(
        clientID: "",
        clientSecret: "",
        redirectUrl: "http://sheepmachine.com/spotify-callback.html");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: InkWell(
              onTap: () async {

                var data = await sp.getAuthorizationCode(
                    [SpotifyScopes.playlistReadPrivate], context);

                tokenList = await sp.getAccessToken(data);

                playlists = await sp.getUserPlaylists(tokenList[0]);
                setState(() {});
              },
              child: Text('Check',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          ...playlists
              .map((e) => ListTile(
              onTap: ()async{
                tracks = await sp.getTracksOfPlaylist(accessToken : tokenList[0], playlistId: e.id);
                setState(() {
                });
              },
              title: Text(e.name), subtitle: Text('${e.trackCount} Track(s)')))
              .toList(),
          ...tracks
              .map((track) => ListTile(
              title: Text(track.name), subtitle: Text('${track.artists.join(', ')}'),))
              .toList()
        ],
      ),
    );
  }
}
