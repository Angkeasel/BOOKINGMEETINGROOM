import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import '../../config/router/router.dart';
import '../../util/helper/local_storage/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future<void> tokenHandler(context) async {
    // const token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaWF0IjoxNjk5NDA5OTY0LCJleHAiOjE2OTk0OTYzNjR9.nDriVPu4kKlBCJFDXg2VSo9qzbWfDrwsq2C0smU1Fro';
    final token = await LocalStorage.getStringValue(key: 'access_token');
    // fetches();
    Timer(
      const Duration(seconds: 1),
      () async {
        try {
          debugPrint("=======>token: $token");
          if (token.isEmpty) {
            router.go('/login');
          } else {
            router.go('/rooms');
          }
        } catch (_) {}
      },
    );
  }

  late final AnimationController _animationController;
  final _position =
      Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero);
  final _opacity = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
    tokenHandler(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) => SlideTransition(
                    position: _position.animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.fastEaseInToSlowEaseOut,
                      ),
                    ),
                    child: FadeTransition(
                        opacity: _opacity.animate(_animationController),
                        child:
                            Image.asset("assets/image/png/KOFI LOGO-01 1.png")),
                  ),
                ),
              ),
              CupertinoActivityIndicator(
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
