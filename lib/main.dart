import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/background.dart';
import 'application/BLoC/trendings/trendings_bloc.dart';
import 'infrastructure/presentation/homePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TrendingsBloc())],
        child: const GradientBackground(child: HomePage()),
      ),
    );
  }
}
