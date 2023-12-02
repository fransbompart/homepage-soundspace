import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/homePage/widgets/promotional_banner_widget.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/tracklist.dart';
import '../widgets/albums_carousel.dart';
import 'widgets/artists_carousel.dart';
import 'widgets/playlist_wrap.dart';
import '../widgets/music_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingsBloc()..add(FetchTrendingsEvent()),
      child: BlocBuilder<TrendingsBloc, TrendingsState>(
        builder: (context, state) {
          if (state is TrendingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TrendingsLoaded) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        actions: const [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      PromotionalBannerWidget(
                        banner: state.promotionalBanner,
                      ),
                      _Collapse(name: 'Playlist', child: [
                        PlaylistWrap(playlists: state.trendingPlaylists)
                      ]),
                      _Collapse(name: 'Aqustico Experience', child: [
                        AlbumsCarousel(albums: state.trendingAlbums)
                      ]),
                      _Collapse(name: 'Artistas Trending', child: [
                        ArtistsCarousel(artists: state.trendingArtists)
                      ]),
                      const Divider(
                        color: Color.fromARGB(18, 142, 139, 139),
                        height: 40,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      _Collapse(
                          name: 'Tracklist',
                          child: [Tracklist(songs: state.trendingSongs)]),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: MusicPlayer(key: key),
                )
              ],
            );
          } else {
            return const Placeholder(); //Pantalla de error
          }
        },
      ),
    );
  }
}

class _Collapse extends StatelessWidget {
  final String name;
  final List<Widget> child;

  const _Collapse({required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: List.generate(child.length, (index) => child[index]),
        ),
      ),
    );
  }
}
