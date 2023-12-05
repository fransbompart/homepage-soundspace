import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_bloc/application/BLoC/LogInSubscriber/log_in_subscriber_cubit.dart';
import 'package:sign_in_bloc/infrastructure/inputs/phone.dart';
import 'Widgets/error_square.dart';
import 'Widgets/my_button.dart';
import 'Widgets/operators_button.dart';
import 'Widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocProvider(
        create: (context) => LogInSubscriberCubit(),
        child: Container(
          width: double.infinity, // Ancho del container igual al ancho de la pantalla
          height: double.infinity,
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color.fromARGB(255, 52, 13, 131),
              Color.fromARGB(255, 30, 8, 58),
              Color.fromARGB(255, 30, 8, 58),
              Color.fromARGB(255, 57, 13, 145),
            ],
          ),
        ),
          child: const _RegisterView()),
      )
      
       
    );
  }

}


class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 140),
                 Padding(
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

                 SizedBox(height: 30),

                //Numero de teléfono text

                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Número de teléfono',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      
                    ),
                  ),
                ),

                 SizedBox(height: 15),

              _RegisterForm(),              

              SizedBox(height: 20),
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
    final phone = registerCubit.state.phone;
    final phoneError = phone.error;
    final isSubmitting = registerCubit.state.formStatus == FormStatus.validating;

    return Form(
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: registerCubit.phoneChanged,
            errorMessage: phoneError == PhoneError.empty
        ? phone.errorMessage : null,
            hint: 'Ej. 584241232323 o 4121232323',
            icon: Icons.info_outlined,
          ),

          isSubmitting && phoneError == PhoneError.length? const ErrorSquare(
            invalidData: true,
            mensaje: 'Datos inválidos, intenta nuevamente.',
          ):const SizedBox(height: 15) ,

          const SizedBox(height: 15),

          MyButton(onTap: () {
                  registerCubit.onSubmit();
                }),
           // Suscríbete text
                const SizedBox(height: 65),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Alinea el Row a la izquierda
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
                      }
                  ),
                ),

        ],
      )
    );
  }
}