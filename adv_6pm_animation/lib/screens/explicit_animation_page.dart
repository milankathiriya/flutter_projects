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
  late AnimationController _staggeredAnimationController;
  late AnimationController _tweenChainingAnimationController;

  late Animation sizeAnimation;
  late Animation colorAnimation;

  @override
  void initState() {
    super.initState();

    _tweenChainingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 100, end: 260), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 260, end: 40), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 300), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 300, end: 100), weight: 1),
    ]).animate(
      CurvedAnimation(
          parent: _tweenChainingAnimationController, curve: Curves.easeInOut),
    );

    // _staggeredAnimationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1600),
    // );
    //
    // sizeAnimation = Tween<double>(begin: 100, end: 260).animate(
    //   CurvedAnimation(
    //     parent: _staggeredAnimationController,
    //     curve: Interval(0, 0.5),
    //   ),
    // );
    // colorAnimation =
    //     ColorTween(begin: Colors.amber, end: Colors.redAccent).animate(
    //   CurvedAnimation(
    //     parent: _staggeredAnimationController,
    //     curve: Interval(0.5, 1),
    //   ),
    // );
    //
    // _rotationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1600),
    //   lowerBound: 0,
    //   upperBound: pi / 6,
    // );
    //
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1600),
    //   lowerBound: 0,
    //   upperBound: pi * 2,
    // );
  }

  @override
  void dispose() {
    _tweenChainingAnimationController.dispose();
    // _staggeredAnimationController.dispose();
    // _rotationController.dispose();
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explicit Animation Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _tweenChainingAnimationController,
              builder: (context, widget) => Container(
                height: sizeAnimation.value,
                width: sizeAnimation.value,
                color: Colors.deepOrange,
              ),
            ),
            // AnimatedBuilder(
            //   animation: _staggeredAnimationController,
            //   builder: (context, widget) => Container(
            //     height: sizeAnimation.value,
            //     width: sizeAnimation.value,
            //     color: colorAnimation.value,
            //   ),
            // ),
            // AnimatedBuilder(
            //   animation: _animationController,
            //   builder: (context, widget) {
            //     return Transform.rotate(
            //       angle: _animationController.value,
            //       child: Image.asset(
            //         "assets/images/mars_logo.png",
            //         height: 350,
            //         width: 350,
            //       ),
            //     );
            //   },
            // ),
            // RotationTransition(
            //   turns: _rotationController,
            //   child: Image.asset(
            //     "assets/images/mars_logo.png",
            //     height: 350,
            //     width: 350,
            //   ),
            // ),
            ElevatedButton(
              child: const Text("Animate"),
              onPressed: () {
                _tweenChainingAnimationController.forward();
                // _staggeredAnimationController.forward();
                // _animationController.forward();
                // _rotationController.forward();
              },
            ),
            ElevatedButton(
              child: const Text("Reverse"),
              onPressed: () {
                _tweenChainingAnimationController.reverse();
                // _staggeredAnimationController.reverse();
                // _animationController.reverse();

                // _rotationController.reverse();
              },
            ),
            ElevatedButton(
              child: const Text("Repeat"),
              onPressed: () {
                _tweenChainingAnimationController.repeat();
                // _staggeredAnimationController.repeat();
                // _animationController.repeat();

                // _rotationController.repeat();
              },
            ),
            ElevatedButton(
              child: const Text("Stop"),
              onPressed: () {
                _tweenChainingAnimationController.stop();
                // _staggeredAnimationController.stop();
                // _animationController.stop();
                // _rotationController.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
