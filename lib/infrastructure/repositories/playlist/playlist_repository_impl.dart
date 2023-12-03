import 'package:sign_in_bloc/domain/playlist/repository/playlist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/playlist/playlist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/commons/result.dart';

import '../../../domain/playlist/playlist.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  final NetworkManager networkManager;

  PlaylistRepositoryImpl({required this.networkManager}); //mejorar esto

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
