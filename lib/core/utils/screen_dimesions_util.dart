import 'package:flutter/cupertino.dart';

class ScreenDimensionsUtil {
  //! Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  //! Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
