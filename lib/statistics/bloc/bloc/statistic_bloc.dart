import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../models/month.dart';
import '../../../../../models/week.dart';
import '../../../../../models/year.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial()) {
    on<GetWeak>((event, emit) async {
      emit(LoadingGetStatistic());
      WeeklyStatsResponse result = await WeeklyStatsService().fetchWeeklyStats(
        event.id,
        event.currentWeek,
      );
      emit(SuccessGetWeek(week: result));
    });
    on<GetMonth>((event, emit) async {
      log("iam in month");
      emit(LoadingGetStatistic());
      MonthlyStatsResponse result = await PrayerStatsService().getMonthlyStats(
        id: event.id,
        currentMonth: event.currentMonth,
      );
      emit(SuccessGetMonth(month: result));
    });
    on<GetYear>((event, emit) async {
      emit(LoadingGetStatistic());
      YearlyStatsResponse result = await YearlyStatsService().fetchYearlyStats(
        event.id,
        event.currentYear,
      );
      emit(SuccessGetYear(year: result));
    });
  }
}
