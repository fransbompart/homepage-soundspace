import 'package:flutter/material.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/ipage.dart';

class NoInternetConnection extends IPage {
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
