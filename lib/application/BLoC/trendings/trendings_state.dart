part of 'trendings_bloc.dart';

abstract class TrendingsState extends Equatable {
  const TrendingsState();
}

class TrendingsLoading extends TrendingsState {
  @override
  List<Object?> get props => [];
}

class TrendingsLoaded extends TrendingsState {
  final List<Artist> trendingArtist;
  final List<Album> trendingAlbum;
  final PromotionalBanner promotionalBanner;
  final List<Playlist> playlists;
  final List<Song> songs;

  TrendingsLoaded({
    required this.trendingArtist,
    required this.trendingAlbum,
    required this.promotionalBanner,
    required this.playlists,
    required this.songs,
  });

  @override
  List<Object?> get props => [
        trendingArtist,
        trendingAlbum,
        promotionalBanner,
        playlists,
        songs,
      ];
}

class TrendingsFailed extends TrendingsState {
  @override
  List<Object?> get props => [];
}
