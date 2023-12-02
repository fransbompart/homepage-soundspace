import '../../domain/song/song.dart';

class SongMapper {
  static Song fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['codigo_cancion'],
      name: json['nombre'],
      duration: json['duracion'],
      imageURL: json['referencia_imagen'],
    );
  }

  static Map<String, dynamic> toJson(Song song) {
    return {
      'codigo_cancion': song.id,
      'nombre': song.name,
      'duracion': song.duration,
      'referencia_imagen': song.imageURL,
    };
  }

  static List<Song> fromJsonList(dynamic jsonList) {
    return jsonList.map<Song>((json) => fromJson(json)).toList();
  }
}
