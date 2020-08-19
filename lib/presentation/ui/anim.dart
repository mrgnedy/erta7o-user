import 'dart:math';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:hover_effect/hover_effect.dart';

class PopoutCards extends StatefulWidget {
  @override
  _PopoutCardsState createState() => _PopoutCardsState();
}

class _PopoutCardsState extends State<PopoutCards>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Animation> alignAnimations;
  Animation rotAnimations;
  int cardCount = 8;
  num duration = 2;
  double angle = 0;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: duration));
    alignAnimations = List.generate(
      cardCount,
      (index) {
        final beginDur = (index / cardCount);
        final endDur = ((index + 1) / cardCount);
        print(endDur);
        angle += (pi / (cardCount - 1)) * 2;
        return Tween(
          begin: Alignment(0, 0),
          end: index == cardCount - 1
              ? Alignment(0, 0)
              : Alignment(
                  sin(angle),
                  cos(angle),
                ),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              beginDur,
              endDur,
              curve: Curves.easeInCubic,
            ),
            reverseCurve:
                Interval(beginDur, endDur, curve: Curves.easeOutCubic),
          ),
        );
      },
    );
    rotAnimations = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInCubic,
          reverseCurve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
 bool get animStatus => _controller.isAnimating? true: _controller.isCompleted?false : null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff031721),
      body: Center(
        child:
            Container(
              child: AnimatedBuilder(
                builder: (context, child) => Column(
          mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
              height: size.height / 2,
              width: size.width,
                      child: Stack(
                        children: List.generate(
                          cardCount,
                          (index) => Transform.rotate(
                            angle: index == cardCount - 1 ? 0 : rotAnimations.value,
                            child: Align(
                              alignment: alignAnimations[index].value,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:100),
                    _controlBtn()
                  ],
                ),
                animation: _controller,
                child: CircleAvatar(
                  maxRadius: 50,
                  minRadius: 10,
                  backgroundColor: Colors.transparent,
                  child: HoverCard(
                    shadow: BoxShadow(
                        color: Colors.purple[200],
                        blurRadius: 20,
                        spreadRadius: -20,
                        offset: Offset(0, 20)),
                    depthColor: Colors.grey[900],
                    depth: 10,
                    builder: (context, snapshot) => Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey[800], shape: BoxShape.circle),
                      child: Align(
                        child: FlutterLogo(size: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
         
      ),
    );
  }

  Widget _controlBtn(){
    return RaisedButton(
              child: Txt('${animStatus==true? "Stop" : animStatus == false? "Reverse" : "Start"}'),
                onPressed: () => _controller.isAnimating
                    ? _controller.stop()
                    : _controller.isCompleted
                        ? _controller.reverse()
                        : _controller.forward());
  }
}
