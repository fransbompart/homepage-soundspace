import '../../../result.dart';
import '../album.dart';

abstract class AlbumRepository {
  Future<Result<List<Album>>> getTrendingAlbums();
}
