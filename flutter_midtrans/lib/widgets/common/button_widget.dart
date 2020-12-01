import 'package:flutter/material.dart';
import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_midtrans/helpers/theme/themes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const DEFAULT_HEIGHT = 40.0;
const DEFAULT_BORDER_WIDTH = 1.0;
const DEFAULT_MARGIN = const EdgeInsets.symmetric(horizontal: 0);
const DEFAULT_PADDING = 35.0;

enum ButtonType { blue_filled, red_filled, blue_border, white_border, transparent, transparent_danger, small_link }

class ButtonWidget extends StatefulWidget {
  final Function onPressed;
  final String title;
  final ButtonType buttonType;
  final TextStyle textStyle;
  final EdgeInsetsGeometry margin;
  final bool loading;
  final bool enabled;
  final bool upperCase;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;
  final bool fullWidth;
  final double padding;
  final Alignment alignment;

  const ButtonWidget(
      {Key key,
      @required this.onPressed,
      @required this.title,
      this.fullWidth = true,
      this.loading = false,
      this.enabled = true,
      this.buttonType = ButtonType.blue_filled,
      this.upperCase = true,
      this.height = DEFAULT_HEIGHT,
      this.borderRadius = const BorderRadius.all(Radius.circular(8)),
      this.textStyle,
      this.alignment = Alignment.center,
      this.margin = DEFAULT_MARGIN,
      this.padding,
      this.borderWidth = DEFAULT_BORDER_WIDTH})
      : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.fullWidth) return button();

    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Container()),
        button(),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget button() {
    Themes theme = App.theme;
    Color borderColor, backgroundColor, textColor;
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: widget.padding ?? DEFAULT_PADDING);

    switch (widget.buttonType) {
      case ButtonType.blue_filled:
        borderColor = theme.colors.primary;
        backgroundColor = theme.colors.primary;
        textColor = Colors.white;
        break;
      case ButtonType.blue_border:
        borderColor = theme.colors.primary;
        backgroundColor = Colors.transparent;
        textColor = theme.colors.primary;
        break;
      case ButtonType.white_border:
        borderColor = Colors.white;
        backgroundColor = Colors.transparent;
        textColor = Colors.white;
        break;
      case ButtonType.red_filled:
        borderColor = theme.colors.error;
        backgroundColor = theme.colors.error;
        textColor = Colors.white;
        break;
      case ButtonType.transparent:
        borderColor = Colors.transparent;
        backgroundColor = Colors.transparent;
        textColor = theme.colors.primary;
        break;
      case ButtonType.transparent_danger:
        borderColor = Colors.transparent;
        backgroundColor = Colors.transparent;
        textColor = theme.colors.error;
        break;
      case ButtonType.small_link:
        borderColor = Colors.transparent;
        backgroundColor = Colors.transparent;
        textColor = theme.colors.primary;
        padding = widget.padding == null ? EdgeInsets.all(0) : padding;
        break;
    }

    if (!canPress()) {
      if (widget.buttonType == ButtonType.transparent) {
        textColor = textColor.withOpacity(0.5);
      } else {
        textColor = theme.colors.text6.withOpacity(0.9);
        backgroundColor = theme.colors.disabled;
        borderColor = borderColor.withOpacity(0);
      }
    }

    TextStyle textStyle = widget.textStyle ?? theme.styles.button1.copyWith(color: textColor);

    return Container(
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: widget.borderWidth),
          borderRadius: widget.borderRadius,
          color: backgroundColor),
      child: FlatButton(
        padding: padding,
        onPressed: canPress() ? widget.onPressed : null,
        child: Align(
          alignment: widget.alignment,
          child: widget.loading
              ? SpinKitDoubleBounce(color: theme.colors.primary, size: 25)
              : Text(
                  widget.title,
                  style: textStyle,
                ),
        ),
      ),
    );
  }

  canPress() {
    return widget.enabled && !widget.loading && widget.onPressed != null;
  }
}
