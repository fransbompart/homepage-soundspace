part of 'trendings_bloc.dart';

abstract class TrendingsState extends Equatable {}

class TrendingsLoading extends TrendingsState {
  @override
  List<Object?> get props => [];
}

class TrendingsLoaded extends TrendingsState {
  final List<Artist> trendingArtist;

  TrendingsLoaded({required this.trendingArtist});

  @override
  List<Object?> get props => [trendingArtist];
}

class TrendingsFailed extends TrendingsState {
  @override
  List<Object?> get props => [];
}
