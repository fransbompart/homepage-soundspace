import 'package:sign_in_bloc/domain/song/repository/song_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/song/song_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/commons/result.dart';

import '../../../domain/song/song.dart';

class SongRepositoryImpl extends SongRepository {
  final NetworkManager networkManager;

  SongRepositoryImpl({required this.networkManager}); //mejorar esto

  @override
  Future<Result<List<Song>>> getSongs() async {
    final result = await networkManager.getRequest('songs/tracklist');
    if (result.hasValue()) {
      return Result(
          value: SongMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
