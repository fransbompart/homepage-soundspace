part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent {}

class ConnectivityInitialCheckRequested extends ConnectivityEvent {}

class ConnectivityCheckRequested extends ConnectivityEvent {}
