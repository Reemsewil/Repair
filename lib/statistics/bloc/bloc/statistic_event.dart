part of 'statistic_bloc.dart';

@immutable
sealed class StatisticEvent {}

class GetYear extends StatisticEvent {
  final int id;
  final int currentYear;

  GetYear({required this.id, required this.currentYear});
}

class GetWeak extends StatisticEvent {
  final int id;
  final int currentWeek;

  GetWeak({required this.id, required this.currentWeek});
}

class GetMonth extends StatisticEvent {
  final int id;
  final int currentMonth;

  GetMonth({required this.id, required this.currentMonth});
}
