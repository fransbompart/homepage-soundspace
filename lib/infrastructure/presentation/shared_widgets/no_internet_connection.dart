import 'package:flutter/material.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/background.dart';

class NoInternetConnection extends Background {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget child(BuildContext context) {
    return const Scaffold(
      body: Text('No connection',
          style: TextStyle(
            color: Colors.black,
          )),
    );
  }
}
