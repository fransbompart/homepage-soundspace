import '../../domain/artist/artist.dart';

class ArtistMapper {
  static Artist fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['codigo_artista'],
      name: json['nombre_artista'],
      imageURL: json['referencia_imagen'],
    );
  }

  static Map<String, dynamic> toJson(Artist artist) {
    return {
      'codigo_artista': artist.id,
      'nombre_artista': artist.name,
      'referencia_imagen': artist.imageURL,
    };
  }

  static List<Artist> fromJsonList(dynamic jsonList) {
    return jsonList.map<Artist>((json) => fromJson(json)).toList();
  }
}
