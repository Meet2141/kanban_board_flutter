import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/utils/app_utils.dart';
import 'package:kanban_flutter/src/features/splash/bloc/splash_event.dart';
import 'package:kanban_flutter/src/features/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashNavigateEvent>((event, emit) async {
      if (appState.isLogin) {
        await AppUtils.futureDelay(afterDelay: () {
          emit(SplashSuccess());
        });
      } else {
        emit(SplashFailure());
      }
    });
  }
}
