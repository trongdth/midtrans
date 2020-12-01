import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midtrans/data/local/storage.dart';
import 'package:flutter_midtrans/helpers/theme/theme_provider.dart';
import 'package:flutter_midtrans/helpers/utils.dart';
import 'package:flutter_midtrans/routes.dart';
import 'package:provider/provider.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    utils.toast(error.toString());
  }
}

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZoned(() async {
    Bloc.observer = SimpleBlocObserver();
    await storage.init();

    runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Routes(),
      ),
    ));
  });
}
