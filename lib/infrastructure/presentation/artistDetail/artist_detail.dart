import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../application/BLoC/player/player_bloc.dart';
import '../shared_widgets/music_player.dart';

class ArtistDetail extends StatelessWidget {
  const ArtistDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final PlayerBloc playerBloc = getIt.get<PlayerBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => playerBloc,
        ),
      ],
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, playerState) {
          return Column(
            children: [
              const Text('Artist Detail'),
              Visibility(
                visible: playerState is PlayingState,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: MusicPlayer(key: key),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
