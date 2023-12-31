import 'package:sign_in_bloc/domain/album/repository/album_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/api_connection_manager.dart';
import 'package:sign_in_bloc/commons/result.dart';
import '../../../domain/album/album.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final IApiConnectionManager _apiConnectionManager;

  AlbumRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;
//mejorar esto

  @override
  Future<Result<List<Album>>> getTrendingAlbums() async {
    final result = await _apiConnectionManager.request(
        'playlist/top_playlists?type=album', 'GET'); //TODO: carefull here
    if (result.hasValue()) {
      return Result(
          value: AlbumMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
