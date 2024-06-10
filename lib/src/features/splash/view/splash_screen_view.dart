import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/src/core/constants/routing_constants.dart';
import 'package:kanban_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:kanban_flutter/src/core/extensions/scaffold_extension.dart';
import 'package:kanban_flutter/src/core/utils/app_utils.dart';
import 'package:kanban_flutter/src/core/utils/progress_loader_utils.dart';
import 'package:kanban_flutter/src/core/utils/toast_utils.dart';
import 'package:kanban_flutter/src/core/widgets/text_widgets/text_Widgets.dart';
import 'package:kanban_flutter/src/features/splash/bloc/splash_bloc.dart';
import 'package:kanban_flutter/src/features/splash/bloc/splash_event.dart';
import 'package:kanban_flutter/src/features/splash/bloc/splash_state.dart';
import 'package:kanban_flutter/src/localization/language_constants.dart';

///SplashScreenView - Display Splash Screen View of the app
class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    ///Navigation Event called via SplashBloc
    context.read<SplashBloc>().add(SplashNavigateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          context.goNamed(RoutingConstants.kanban);
        }
        if (state is SplashFailure) {
          ToastUtils.showFailed(message: translation(context).somethingWentWrong);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Splash Text
            Expanded(
              child: Center(
                child: TextWidgets(
                    text: translation(context).appName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///By Text
                TextWidgets(text: translation(context).by.toUpperCase(), style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 10),

                ///Developer Name Text
                TextWidgets(
                    text: translation(context).developerName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )).onPressedWithoutHaptic(() {
                  LoaderUtils.showProgressDialog(context);
                  AppUtils.futureDelay(afterDelay: () {
                    LoaderUtils.dismissProgressDialog(context);
                  });
                }),
              ],
            )
          ],
        ),
      ),
    ).baseScaffoldNoAppBar();
  }
}
