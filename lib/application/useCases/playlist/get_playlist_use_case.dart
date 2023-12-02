import '../../../domain/playlist/playlist.dart';
import '../../../domain/playlist/repository/playlist_repository.dart';
import '../../../result.dart';

class GetPlaylistUseCase {
  final PlaylistRepository playlistRepository;

  GetPlaylistUseCase({required this.playlistRepository});

  Future<Result<List<Playlist>>> execute() async {
    return await playlistRepository.getPlayList();
  }
}
