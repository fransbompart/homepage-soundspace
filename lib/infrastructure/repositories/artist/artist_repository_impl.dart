import 'package:sign_in_bloc/domain/artist/repository/artist_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/core/result.dart';
import '../../../domain/artist/artist.dart';

class ArtistRepositoryImpl extends ArtistRepository {
  final NetworkManager networkManager = NetworkManager(
      apiPath:
          'https://soundspace-api-production.up.railway.app/api/'); //mejorar esto

  @override
  Future<Result<List<Artist>>> getTrendingArtists() async {
    final result = await networkManager.getRequest('artists/top_artists');
    if (result.hasValue()) {
      return Result(
          value: ArtistMapper.fromJsonList(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
