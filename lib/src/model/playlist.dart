class Playlist{
  String id,name;

  Playlist({this.id,this.name});

  factory Playlist.fromMap(Map<String,dynamic> data){
    return Playlist(
        id: data['id'],
      name: data['name'],
    );
  }
}