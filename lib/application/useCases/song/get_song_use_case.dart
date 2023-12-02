import '../../../domain/song/song.dart';
import '../../../domain/song/repository/song_repository.dart';
import '../../../result.dart';

class GetSongUseCase {
  final SongRepository songRepository;

  GetSongUseCase({required this.songRepository});

  Future<Result<List<Song>>> execute() async {
    return await songRepository.getSongs();
  }
}
