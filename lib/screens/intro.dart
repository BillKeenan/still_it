import 'dart:math';

import 'package:distillers_calculator/theme/colors/light_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  double _bigFontSize = kIsWeb ? 234 : 178;
  final transitionDuration = Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Future.delayed(Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        .then((value) => Duration(seconds: 1))
        .then(
          (value) => Future.delayed(Duration(seconds: 1)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false),
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: LightColors.kDarkYellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Image(image: AssetImage('still.png'))],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "HOWTIME",
          style: TextStyle(
            color: Color(0xFF4e954e),
            fontSize: 50,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        LottieBuilder.asset(
          'assets/bubbles.json',
          onLoaded: (composition) {
            _lottieAnimation..duration = composition.duration;
          },
          frameRate: FrameRate.max,
          repeat: false,
          animate: false,
          height: 100,
          width: 100,
          controller: _lottieAnimation,
        )
      ],
    );
  }
  //
  // Widget _logoAbbreviated() {
  //   return Container(
  //     // color: Colors.blue,
  //     height: 150,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [],
  //     ),
  //   );
  // }
  //
  // Widget _logoExtended() {
  //   return Container(
  //     height: 150,
  //     child: Row(
  //       // mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Expanded(
  //           child: Text(
  //             "HOWTIME",
  //             // textAlign: TextAlign.center,
  //             maxLines: 1,
  //             style: Theme.of(context).textTheme.headline3!.merge(GoogleFonts.montserrat()),
  //           ),
  //         ),
  //         LottieBuilder.asset(
  //           'assets/food.json',
  //           onLoaded: (composition) {
  //             _lottieAnimation..duration = composition.duration;
  //           },
  //           frameRate: FrameRate.max,
  //           repeat: false,
  //           animate: false,
  //           height: 100,
  //           width: 100,
  //           controller: _lottieAnimation,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
