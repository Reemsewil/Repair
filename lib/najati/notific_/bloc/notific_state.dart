part of 'notific_bloc.dart';

@immutable
sealed class NotificState {}

final class NotificInitial extends NotificState {}

class NotificSuccess extends NotificState {
  final List<NotificateModel> notificate;

  NotificSuccess({required this.notificate});
}

class NotificFailed extends NotificState {}

class NotificLoading extends NotificState {}

class NotificEmpty extends NotificState {}
