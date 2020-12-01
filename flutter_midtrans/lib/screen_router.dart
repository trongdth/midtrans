import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midtrans/blocs/product/product_cubit.dart';
import 'package:flutter_midtrans/repositories/product_repo.dart';
import 'package:flutter_midtrans/root.dart';
import 'package:flutter_midtrans/services/api.dart';
import 'package:flutter_midtrans/widgets/common/button_widget.dart';

class ScreenRouter {
  static const ROOT = '/';

  BaseAPI api;
  var productRepo;

  ScreenRouter() {
    api = API();
    productRepo = ProductRepository(api: api);
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    var route = buildPageRoute(settings);
    Map arguments = settings.arguments;

    switch (settings.name) {
      case ROOT:
        return route(Root());
      default:
        return unknownRoute(settings);
    }
  }

  Function buildPageRoute(RouteSettings settings) {
    var blocProviders = [
      BlocProvider(create: (context) => ProductCubit(productRepo)),
    ];

    return (Widget child, {fullScreen = false}) => MaterialPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => MultiBlocProvider(
            providers: blocProviders,
            child: child,
          ),
          settings: settings,
        );
  }

  Route<dynamic> unknownRoute(RouteSettings settings) {
    var unknownRouteText = "No such screen for ${settings.name}";

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(unknownRouteText),
          Padding(padding: const EdgeInsets.all(10.0)),
          ButtonWidget(
            title: "Back",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
