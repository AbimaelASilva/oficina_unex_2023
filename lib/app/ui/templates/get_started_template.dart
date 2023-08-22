import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/colors.dart';

class GetStardedTemplate extends StatelessWidget {
  const GetStardedTemplate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                'assets/images/bk_woman_png.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/spotify_logo.svg',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Enjoy Listenning To Music',
                          style: TextStyle(
                            color: ProColors.graySoft,
                            fontSize: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
                            style: TextStyle(
                              color: ProColors.grayDark,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 37),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 92,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/playerTemplate');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ProColors.greenSoft,
                                    ),
                                    child: Text(
                                      'Get Started',
                                      style: TextStyle(
                                        color: ProColors.graySoft,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
