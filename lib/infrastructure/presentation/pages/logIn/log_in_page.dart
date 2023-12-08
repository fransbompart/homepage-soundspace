import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/LogInSubscriber/log_in_subscriber_cubit.dart';
import 'package:sign_in_bloc/application/useCases/user/log_in_use_case.dart';
import 'package:sign_in_bloc/domain/user/repository/user_repository.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import '../../shared_widgets/ipage.dart';
import 'Widgets/custom_text_form_field.dart';
import 'Widgets/error_square.dart';
import 'Widgets/my_button.dart';
import 'Widgets/operators_button.dart';

class RegisterScreen extends IPage {
  const RegisterScreen({super.key});

  @override
  Widget child(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 140),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Numero de teléfono text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Número de teléfono',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => LogInSubscriberCubit(
                          logInUseCase: LogInUseCase(
                              userRepository: UserRepositoryImpl(
                                  networkManager: NetworkManager())))),
                ],
                child: const _RegisterForm(),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<LogInSubscriberCubit>();
    final appNavigator = GetIt.instance.get<AppNavigator>();
    final phone = registerCubit.state.phone;
    final phoneError = phone.error;
    final isSubmitting = registerCubit.state.formStatus == FormStatus.posting;
    final isFailure = registerCubit.state.formStatus == FormStatus.failure;

    return BlocListener<LogInSubscriberCubit, LogInSubscriberState>(
        listener: (context, state) => state.formStatus == FormStatus.success
            ? appNavigator.navigateTo('/home')
            : null,
        child: Form(
            child: Column(
          children: [
            CustomTextFormField(
              label: 'Nombre de usuario',
              onChanged: registerCubit.phoneChanged,
              errorMessage: phoneError != null ? phone.errorMessage : null,
              hint: 'Ej. 584241232323 o 4121232323',
              icon: Icons.info_outlined,
            ),

            const SizedBox(height: 15),

            if (isFailure)
              const ErrorSquare(
                invalidData: true,
                mensaje:
                    'Datos inválidos, intenta nuevamente.', //TODO: este mensaje puede ser de la api, hacerlo dinamico
              ),

            if (isSubmitting) const CircularProgressIndicator(),

            const SizedBox(height: 15),

            if (!isSubmitting) MyButton(onTap: () => registerCubit.onSubmit()),
            // Suscríbete text
            const SizedBox(height: 65),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinea el Row a la izquierda
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Suscríbete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 37,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Otros widgets aquí si los hay
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Si no tienes cuenta suscríbete con tu operadora',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ImageContainer(
                  imagePath: 'images/digitel_blanco.png',
                  onTap: () {
                    //TODO: metodo operadoras;
                  }),
            ),
            //Boton digitel
            const SizedBox(height: 25),
            Center(
              child: ImageContainer(
                  imagePath: 'images/movistar_blanco.png',
                  onTap: () {
                    //TODO: metodo operadoras;
                  }),
            ),
          ],
        )));
  }
}
