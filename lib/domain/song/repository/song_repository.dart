import '../../../commons/result.dart';
import '../song.dart';

abstract class SongRepository {
  Future<Result<List<Song>>> getSongs();
}
