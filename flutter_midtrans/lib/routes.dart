import 'package:flutter/material.dart';
import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_midtrans/helpers/theme/theme_provider.dart';
import 'package:flutter_midtrans/helpers/theme/themes.dart';
import 'package:flutter_midtrans/screen_router.dart';
import 'package:provider/provider.dart';

class Routes extends StatelessWidget {
  const Routes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenRouter = ScreenRouter();
    final Themes theme = Provider.of<ThemeProvider>(context).getTheme(context);
    App.theme = theme;

    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            platform: TargetPlatform.iOS,
            backgroundColor: theme.colors.background,
            primaryColor: theme.colors.primary,
            accentColor: theme.colors.primary,
            buttonColor: theme.colors.primary,
            bottomAppBarColor: theme.colors.primary,
            fontFamily: 'Georgia',
            scaffoldBackgroundColor: theme.colors.background,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: theme.colors.bottomBar,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            appBarTheme: AppBarTheme(
              color: theme.colors.appBar,
              iconTheme: IconThemeData(color: theme.colors.primary),
              elevation: 0,
            ),
            unselectedWidgetColor: theme.colors.button3,
            // for checkbox
            dividerTheme: DividerThemeData(thickness: 1, color: theme.colors.divider)),
        onGenerateRoute: screenRouter.generateRoute,
        onUnknownRoute: screenRouter.unknownRoute,
        initialRoute: '/',
      ),
    );
  }
}
