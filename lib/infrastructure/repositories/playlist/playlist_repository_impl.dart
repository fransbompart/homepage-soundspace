import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/result.dart';

import '../../../domain/playlist/playlist.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  final NetworkManager networkManager = NetworkManager(
      apiPath:
          'https://soundspace-api-production.up.railway.app/api/'); //mejorar esto

  @override
  Future<Result<List<Playlist>>> getPlayList() async {
    final result = await networkManager.getRequest('playlist/top_playlists');
    if (result.hasValue()) {
      return Result(
          value: PlaylistMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
