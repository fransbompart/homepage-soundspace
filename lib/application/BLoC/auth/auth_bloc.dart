import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/useCases/user/is_authenticated.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsAuthenticatedUseCase isAuthenticatedUseCase;

  AuthBloc({required this.isAuthenticatedUseCase})
      : super((NoAuthenticated())) {
    on<UserAuthenticatedEvent>(_userAuthenticatedEventHandler);
  }

  void _userAuthenticatedEventHandler(
      UserAuthenticatedEvent event, Emitter<AuthState> emit) {
    // final authResult = isAuthenticatedUseCase.execute();
    // if (authResult.hasValue()) {
    //   if (authResult.value!) {
    emit(Authenticated());
    //   } else {
    //     emit(NoAuthenticated());
    //   }
    // } else {
    //   emit(NoAuthenticated());
    // }
  }
}
