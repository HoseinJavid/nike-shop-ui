import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          context.pushReplacement('/');
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
          child: Lottie.asset('assets/animation/splash/nike.json',
              controller: _animationController, onLoaded: (lottieComposition) {
        _animationController.duration = lottieComposition.duration;
        _animationController.forward();
      }, width: 500, height: 500, fit: BoxFit.contain)),
    );
  }
}
