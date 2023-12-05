import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/infrastructure/repositories/artist/artist_repository_impl.dart';

import '../../useCases/artist/get_trending_artist_use_case.dart';
part 'trendings_event.dart';
part 'trendings_state.dart'; 

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingArtistUseCase getTrendingArtistUseCase =
      GetTrendingArtistUseCase(
          artistRepository:
              ArtistRepositoryImpl()); //esto lo haremos con get it
  TrendingsBloc() : super(TrendingsLoading()) {
    on<FetchTrendingsEvent>(_fetchTrendingsEventHandler);
  }

  void _fetchTrendingsEventHandler(
      FetchTrendingsEvent event, Emitter<TrendingsState> emit) async {
    //activar todos los casos de uso relacionados a trending
    final trendingArtistResult = await getTrendingArtistUseCase.execute();

    if (trendingArtistResult.hasValue()) {
      emit(TrendingsLoaded(trendingArtist: trendingArtistResult.value!));
    } else {
      emit(TrendingsFailed());
    }
  }
}
