import 'package:flutter/material.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import '../widgets/music_album_card.dart';
import '../widgets/music_albums_carousel.dart';
import '../widgets/music_track_item.dart';
import 'widgets/music_artist_card.dart';
import 'widgets/music_artists_carousel.dart';
import 'widgets/music_categories.dart';
import '../widgets/music_player.dart';
import 'widgets/promotional_banner.dart';
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
                      const PromotionalBanner(
                        imgPath:
                            'https://aqustico.com/wp-content/uploads/2023/08/Banners-web_Mesa-de-trabajo-1-1.png',
                      ),
                      _Collapse(name: 'Playlist', child: [
                        PlaylistWrap(playlists: [
                          Playlist(
                              id: '1',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                          Playlist(
                              id: '2',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                          Playlist(
                              id: '3',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                          Playlist(
                              id: '4',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                          Playlist(
                              id: '5',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                          Playlist(
                              id: '6',
                              name: 'name',
                              iconPath:
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/emojis/55102/purple-square-emoji-clipart-md.png'),
                        ])
                        //requestCategories
                      ]),
                      const _Collapse(name: 'Aqustico Experience', child: [
                        MusicAlbumsCarousel(albums: [
                          MusicAlbumCard(),
                          MusicAlbumCard(),
                          MusicAlbumCard(),
                          MusicAlbumCard(),
                        ])
                      ]),
                      const _Collapse(name: 'Artistas Trending', child: [
                        MusicArtistsCarousel(
                          artists: [
                            MusicArtistCard(),
                            MusicArtistCard(),
                            MusicArtistCard(),
                          ],
                        )
                      ]),
                      const Divider(
                        color: Color.fromARGB(18, 142, 139, 139),
                        height: 40,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const _Collapse(name: 'Tracklist', child: [
                        MusicTrackItem(),
                        MusicTrackItem(),
                        MusicTrackItem(),
                        MusicTrackItem()
                      ]),
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
            return const Placeholder();
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
