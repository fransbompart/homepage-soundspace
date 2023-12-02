import '../../domain/playlist/playlist.dart';

class PlaylistMapper {
  static Playlist fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['codigo_playlist'],
      name: json['nombre'],
      iconPath: json['referencia_imagen'],
    );
  }

  static Map<String, dynamic> toJson(Playlist playlist) {
    return {
      'codigo_playlist': playlist.id,
      'nombre': playlist.name,
      'referencia_imagen': playlist.iconPath,
    };
  }

  static List<Playlist> fromJsonList(dynamic jsonList) {
    return jsonList.map<Playlist>((json) => fromJson(json)).toList();
  }
}
