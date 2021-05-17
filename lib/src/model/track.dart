class Track{
  String id,name,albumName,previewUrl;
  List<String> artists;

  Track({this.id,this.name, this.albumName, this.previewUrl, this.artists});

  factory Track.fromMap(Map<String,dynamic> data){
    return Track(
        id: data['track']['id'],
      name: data['track']['name'],
      previewUrl: data['track']['preview_url'],
      albumName: data['track']['album']['name'],
      artists: List<String>.from((data['track']['artists'] as List).map((e) => e['name']).toList())
    );
  }
}