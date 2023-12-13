part of 'subscribe_bloc.dart';

sealed class SubscribeState extends Equatable {
  const SubscribeState();
  
  @override
  List<Object> get props => [];
}

final class SubscribeInitial extends SubscribeState {}
