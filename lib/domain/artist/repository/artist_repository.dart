import '../../../commons/result.dart';
import '../artist.dart';

abstract class ArtistRepository {
  Future<Result<List<Artist>>> getTrendingArtists();
}
