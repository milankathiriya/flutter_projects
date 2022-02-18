import 'package:flutter/material.dart';

class ExplicitAnimationPage extends StatefulWidget {
  const ExplicitAnimationPage({Key? key}) : super(key: key);

  @override
  _ExplicitAnimationPageState createState() => _ExplicitAnimationPageState();
}

class _ExplicitAnimationPageState extends State<ExplicitAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _animationController;
  late AnimationController _staggerdController;

  late Animation _sizeAnimation;
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _staggerdController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
      lowerBound: -250,
      upperBound: 250,
    );

    // _sizeAnimation = Tween<double>(begin: 80, end: 250).animate(
    //     CurvedAnimation(curve: Interval(0, 0.5), parent: _staggerdController));

    _sizeAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween<double>(begin: 80, end: 120), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 120, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 250), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 250, end: 80), weight: 1),
    ]).animate(_staggerdController);

    _colorAnimation = ColorTween(begin: Colors.redAccent, end: Colors.indigo)
        .animate(CurvedAnimation(
            parent: _staggerdController, curve: Interval(0.5, 1)));

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _animationController.dispose();
    _staggerdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explicit Animation Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _staggerdController,
                builder: (context, widget) {
                  return Container(
                    color: _colorAnimation.value,
                    height: _sizeAnimation.value,
                    width: _sizeAnimation.value,
                  );
                }),
            // AnimatedBuilder(
            //   animation: _animationController,
            //   builder: (context, widget) {
            //     print(_animationController.value);
            //
            //     return Transform.translate(
            //       offset: Offset(_animationController.value, 0),
            //       child: Image.asset(
            //         "assets/images/mars.png",
            //         width: 220,
            //       ),
            //     );
            //   },
            // ),
            // RotationTransition(
            //   turns: _rotationController,
            //   alignment: Alignment.center,
            //   child: Image.asset("assets/images/mars.png"),
            // ),
            ElevatedButton(
              onPressed: () {
                // _rotationController.forward();
                // _animationController.forward();
                _staggerdController.forward();
              },
              child: Text("Animate in Forward"),
            ),
            ElevatedButton(
              onPressed: () {
                // _rotationController.reverse();
                // _animationController.reverse();
                _staggerdController.reverse();
              },
              child: Text("Animate in Reverse"),
            ),
            ElevatedButton(
              onPressed: () {
                // _rotationController.repeat();
                // _animationController.repeat();
                _staggerdController.repeat();
              },
              child: Text("Repeat"),
            ),
            ElevatedButton(
              onPressed: () {
                // _rotationController.stop();
                // _animationController.stop();
                _staggerdController.stop();
              },
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
