/*
*  gradients.dart
*  Doctian_UI
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/rendering.dart';


class Gradients {
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment(0.5, 0),
    end: Alignment(0.5, 1),
    stops: [
      0,
      0.46,
      1,
    ],
    colors: [
      Color.fromARGB(0, 255, 255, 255),
      Color.fromARGB(227, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
  );
  static const Gradient secondaryGradient = LinearGradient(
    begin: Alignment(0.5, 0),
    end: Alignment(0.5, 1),
    stops: [
      0,
      1,
    ],
    colors: [
      Color.fromARGB(0, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
  );
}