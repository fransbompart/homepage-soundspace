import 'package:sign_in_bloc/domain/album/repository/album_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/album/album_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/commons/result.dart';
import '../../../domain/album/album.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final NetworkManager networkManager = NetworkManager(
      apiPath:
          'https://soundspace-api-production.up.railway.app/api/'); //mejorar esto

  @override
  Future<Result<List<Album>>> getTrendingAlbums() async {
    final result =
        await networkManager.getRequest('playlist/top_playlists?type=album');
    if (result.hasValue()) {
      return Result(
          value: AlbumMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
