import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/theme/styles.dart';

enum ButtonType {
  primary,
  icon,
  text,
  plus,
}

class Button extends StatelessWidget {
  final ButtonType type;
  final Function onPressed;
  final Color color;
  final Color iconColor;
  final ShapeBorder shape;
  final Widget child;
  final String text;
  final IconData icon;
  final double iconSize;
  final double minWidth;
  final EdgeInsets padding;
  final bool spinner;

  const Button.primary({
    Key key,
    this.color,
    this.child,
    this.text,
    @required this.onPressed,
    this.padding,
    this.spinner = false,
  })  : this.type = ButtonType.primary,
        this.shape = null,
        this.icon = null,
        this.iconColor = null,
        this.minWidth = null,
        this.iconSize = null,
        super(key: key);

  const Button.text({
    Key key,
    this.color,
    this.child,
    this.text,
    this.padding,
    @required this.onPressed,
    this.spinner = false,
  })  : this.type = ButtonType.text,
        this.shape = null,
        this.icon = null,
        this.iconColor = null,
        this.minWidth = null,
        this.iconSize = null,
        super(key: key);

  const Button.icon({
    Key key,
    this.color,
    this.child,
    this.icon,
    this.iconColor,
    this.minWidth,
    this.padding,
    this.iconSize,
    @required this.onPressed,
    this.spinner = false,
  })  : this.type = ButtonType.icon,
        this.shape = null,
        this.text = null,
        super(key: key);

  const Button.plus({
    Key key,
    this.color,
    this.child,
    this.icon,
    this.iconColor,
    this.minWidth,
    this.padding,
    this.iconSize,
    @required this.onPressed,
    this.spinner = false,
  })  : this.type = ButtonType.icon,
        this.shape = null,
        this.text = null,
        super(key: key);
  Widget get calculatedChild {
    Widget widget;
    switch (type) {
      case ButtonType.primary:
        widget = Text(
          text,
          style: Style.button.copyWith(color: Style.colors.white),
        );
        break;
      case ButtonType.icon:
        widget = Icon(
          icon,
          color: iconColor ?? Style.colors.white,
          size: iconSize,
        );
        break;
      case ButtonType.text:
        widget = Text(
          text,
          style: Style.button.copyWith(color: Style.colors.primary),
        );
        break;
      case ButtonType.plus:
        widget = Icon(
          icon,
          color: iconColor,
          size: iconSize,
        );
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) => MaterialButton(
        elevation: 0,
        highlightElevation: 0,
        minWidth: minWidth,
        disabledColor: Style.colors.grey,
        padding: padding ?? Style.padding12,
        color: color ?? type.color,
        shape: shape ?? type.shape,
        child:
            spinner ? CupertinoActivityIndicator() : child ?? calculatedChild,
        onPressed: onPressed,
      );
}

extension on ButtonType {
  Color get color {
    Color color;
    switch (this) {
      case ButtonType.primary:
        color = Style.colors.primary;
        break;
      case ButtonType.icon:
        color = Style.colors.primary;
        break;
      case ButtonType.text:
        color = Style.colors.transparent;
        break;
      case ButtonType.plus:
        color = Style.colors.white;
        break;
    }
    return color;
  }

  ShapeBorder get shape {
    ShapeBorder shape;
    switch (this) {
      case ButtonType.primary:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
        break;
      case ButtonType.icon:
        shape = const CircleBorder();
        break;
      case ButtonType.text:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
        break;
      case ButtonType.plus:
        shape = const CircleBorder();
        break;
    }
    return shape;
  }
}
