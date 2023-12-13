import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super (key:key); // Instancia del Bloc ficticio

  @override
  Widget build(BuildContext context) {
    bool enabled;
    bool location;

            return BlocListener<GpsBloc, GpsState>(listener: (context, state) {
            if (state.isGpsEnabled ) {
              Scaffold(
              appBar: AppBar(
              title: const Text('Location App'),
              ),
              body:const Center(
              child: LocationActivationPage()
            )
            );
            
            }
            else{
              Scaffold(
              appBar: AppBar(
              title: const Text('Location App'),
              ),
              body:const Center(
              child: PermissionActivationPage()
            )
            );
            }
          },
          child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
              title: const Text('Location App'),
              ),
              body: Center(
                child: state.isGpsEnabled ? const PermissionActivationPage() : const LocationActivationPage())
          
            );
          }
        ),
            );
    
    }
}


class LocationActivationPage extends StatelessWidget {
  const LocationActivationPage({Key? key}) : super (key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.purple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Text(
            'Debe activar su location',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PermissionActivationPage extends StatelessWidget {
  const PermissionActivationPage({Key? key}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.purple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Active el permiso de location para la app',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final gpsBloc = BlocProvider.of<GpsBloc>(context);
                gpsBloc.askGpsAccess();
              },
              child: const Text('Activar permiso'),
            ),
          ],
        ),
      ),
    );
  }
}