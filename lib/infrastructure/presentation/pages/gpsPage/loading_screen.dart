import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sign_in_bloc/application/BLoC/gps/gps_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/gpsPage/gps_access_screen.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/gpsPage/map_screen.dart';

class LoadingScreen extends StatelessWidget {
   
   const LoadingScreen({Key? key}) : super(key: key);
   
   @override
   Widget build(BuildContext context) {
   return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
            ? const MapScreen()
            : const GpsAccessScreen();
        },
      )
   );
   }
}