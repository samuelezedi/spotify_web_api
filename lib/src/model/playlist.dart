class Playlist {
  String id, name;
  int trackCount;

  Playlist({this.id, this.name, this.trackCount});

  factory Playlist.fromMap(Map<String, dynamic> data) {
    return Playlist(
        id: data['id'],
        name: data['name'],
        trackCount: data['tracks']['total']);
  }
}
