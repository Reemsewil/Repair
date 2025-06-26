import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../handling_model.dart';
import '../../services_/note_service.dart';
import '../model/notificate_model.dart';

part 'notific_event.dart';
part 'notific_state.dart';

class NotificBloc extends Bloc<NotificEvent, NotificState> {
  NotificBloc() : super(NotificInitial()) {
    on<GetNotific>((event, emit) async {
      emit(NotificLoading());
      ResultModel result = await NoteServiceImp().getNote();
      if (result is ListOf<NotificateModel>) {
        if (result.data.isEmpty) {
          emit(NotificEmpty());
        } else {
          emit(NotificSuccess(notificate: result.data));
        }
      } else {
        emit(NotificFailed());
      }
    });
  }
}
