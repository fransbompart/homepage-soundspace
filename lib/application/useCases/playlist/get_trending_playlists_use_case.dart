import '../../../domain/playlist/playlist.dart';
import '../../../domain/playlist/repository/playlist_repository.dart';
import '../../../commons/result.dart';

class GetTrendingPlaylistsUseCase {
  final PlaylistRepository playlistRepository;

  GetTrendingPlaylistsUseCase({required this.playlistRepository});

  Future<Result<List<Playlist>>> execute() async {
    return await playlistRepository.getPlayList();
  }
}
