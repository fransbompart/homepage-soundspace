import 'package:sign_in_bloc/domain/album/album.dart';

import '../../../domain/album/repository/album_repository.dart';
import '../../../result.dart';

class GetTrendingAlbumUseCase {
  final AlbumRepository albumRepository;

  GetTrendingAlbumUseCase({required this.albumRepository});

  Future<Result<List<Album>>> execute() async {
    return await albumRepository.getTrendingAlbums();
  }
}
