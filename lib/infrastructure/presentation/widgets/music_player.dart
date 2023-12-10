import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/sockets/socket_bloc.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  void sendIdSong(BuildContext context, [String idSong = '']) {
    context.read<SocketBloc>().add(SocketSend(idSong));
  }

  @override
  Widget build(BuildContext context) {
    final len =
        context.select((SocketBloc socketBloc) => socketBloc.state.buffer);
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 24, 15, 35)),
      child: Column(
        children: [
          const LinearProgressIndicator(
            backgroundColor: Color.fromARGB(255, 33, 31, 34),
            value:
                0.2, //porcentaje que debe coincidir con el porcentaje que va de audio
            minHeight: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Color(0xff1de1ee),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(children: [
                    Text(
                      len.length.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '1:00',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => sendIdSong(context, 'cancion123'),
                        child: const Icon(
                          Icons.play_arrow_sharp,
                          color: Color(0xff1de1ee),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
