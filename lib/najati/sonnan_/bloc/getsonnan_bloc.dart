// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import '../../../handling_model.dart';
// import '../../services_/get_sunnan_services.dart';

// part 'getsonnan_event.dart';
// part 'getsonnan_state.dart';

// class GetsonnanBloc extends Bloc<GetsonnanEvent, GetsonnanState> {
//   GetsonnanBloc() : super(GetsonnanInitial()) {
//     on<GetSunnan>((event, emit) async {
//       emit(GetsonnanLoading());
//       ResultModel result = await GetSunnanServicesImp().getSonnan(event.childId);
//       if (result is ListOf<GetSunnan>) {
//         emit(GetsonnanSusess(sonnan: result.data));
//       } else {
//         emit(GetsunnanFailed());
//       }
//     });
//   }
// }
