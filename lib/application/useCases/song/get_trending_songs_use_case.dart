import '../../../domain/song/song.dart';
import '../../../domain/song/repository/song_repository.dart';
import '../../../commons/result.dart';

class GetTrendingSongsUseCase {
  final SongRepository songRepository;

  GetTrendingSongsUseCase({required this.songRepository});

  Future<Result<List<Song>>> execute() async {
    return await songRepository.getSongs();
  }
}
