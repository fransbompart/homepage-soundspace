import 'package:sign_in_bloc/domain/artist/artist.dart';

import '../../../domain/artist/repository/artist_repository.dart';
import '../../../result.dart';

class GetTrendingArtistUseCase {
  final ArtistRepository artistRepository;

  GetTrendingArtistUseCase({required this.artistRepository});

  Future<Result<List<Artist>>> execute() async {
    return await artistRepository.getTrendingArtists();
  }
}
