import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';
import 'package:knowledge_one/routers.dart';
import 'package:loading_indicator/loading_indicator.dart';

/// modified from
///
/// https://github.com/chouhan-rahul/splash_view/blob/main/lib/source/presentation/widgets/done.dart
class Done extends PageRouteBuilder {
  /// Redirect to the next page when the loading is finished.
  final Widget done;

  /// The duration the transition going forwards.
  final Duration? animationDuration;

  /// [Curves], a collection of common animation easing curves.
  final Curve? curve;
  Done(
    this.done, {
    this.animationDuration = const Duration(seconds: 1),
    this.curve = Curves.easeOut,
  }) : super(
          transitionDuration: animationDuration!,
          transitionsBuilder: (context, animation, secondAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: curve!,
            );
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.center,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return done;
          },
        );
}

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key, this.done, this.routerName, this.duration = 3000})
      : assert(routerName != null || done != null),
        super(key: key);
  final String? routerName;
  final Done? done;
  final int duration;

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(
              milliseconds: widget.duration - AppStyle.fadeTransitionDuration))
          .then((value) {
        if (widget.routerName != null) {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: const Duration(
                  milliseconds: AppStyle.fadeTransitionDuration), //动画时间为500毫秒
              //页面的构造器
              pageBuilder: (
                BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
              ) {
                return Routers.routers[widget.routerName]!.call(context);
              },
              //过度效果
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation1,
                  Animation<double> animation2,
                  Widget child) {
                // 过度的动画的值
                return FadeTransition(
                  // 过度的透明的效果
                  opacity: Tween(begin: 0.0, end: 1.0)
                      // 给他个透明度的动画   CurvedAnimation：设置动画曲线
                      .animate(CurvedAnimation(
                          //父级动画
                          parent: animation1,
                          //动画曲线
                          curve: Curves.ease)),
                  child: child,
                );
              }));
        } else {
          Navigator.of(context).pushReplacement(widget.done!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          // image: backgroundImageDecoration,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Knowledge One",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              width: 75,
              height: 75,
              child: LoadingIndicator(
                indicatorType: Indicator.pacman,
                colors: [AppStyle.appBlue],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashBody(
      routerName: Routers.mainScreen,
    );
  }
}
