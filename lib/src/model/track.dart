class Track{
  String id,name,albumName,previewUrl,spotifyUrl,uri;
  List<String> artists;

  Track({this.id,this.name, this.albumName, this.previewUrl, this.spotifyUrl, this.uri, this.artists});

  factory Track.fromMap(Map<String,dynamic> data){
    return Track(
        id: data['track']['id'],
      name: data['track']['name'],
      previewUrl: data['track']['preview_url'],
      albumName: data['track']['album']['name'],
      spotifyUrl: data['track']['external_urls']['spotify'],
      uri: data['track']['uri'],
      artists: List<String>.from((data['track']['artists'] as List).map((e) => e['name']).toList())
    );
  }
}