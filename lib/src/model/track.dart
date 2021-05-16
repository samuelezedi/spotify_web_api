class Track{
  String id,name,albumName,url;
  List<String> artists;

  Track({this.id,this.name, this.albumName, this.url, this.artists});

  factory Track.fromMap(Map<String,dynamic> data){
    return Track(
        id: data['track']['id'],
      name: data['track']['name'],
      albumName: data['track']['album']['name'],
      artists: List<String>.from((data['track']['artists'] as List).map((e) => e['name']).toList())
    );
  }
}