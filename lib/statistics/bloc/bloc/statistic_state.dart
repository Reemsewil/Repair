// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_bloc.dart';

@immutable
sealed class StatisticState {}

final class StatisticInitial extends StatisticState {}

class SuccessGetWeek extends StatisticState {
  final WeeklyStatsResponse week;

  SuccessGetWeek({required this.week});
}

class SuccessGetMonth extends StatisticState {
  final MonthlyStatsResponse month;

  SuccessGetMonth({required this.month});
}

class SuccessGetYear extends StatisticState {
  final YearlyStatsResponse year;

  SuccessGetYear({required this.year});
}

class FailedGetStatistic extends StatisticState {}

class LoadingGetStatistic extends StatisticState {}
