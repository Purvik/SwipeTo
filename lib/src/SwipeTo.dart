import 'package:flutter/material.dart';

class SwipeTo extends StatefulWidget {
  final Widget child;
  final Duration animationDuration;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Offset endOffset;
  final VoidCallback callBack;

  SwipeTo({
    @required this.child,
    @required this.callBack,
    this.iconData = Icons.reply,
    this.iconSize = 30.0,
    this.iconColor,
    this.animationDuration = const Duration(milliseconds: 150),
    this.endOffset = const Offset(0.3, 0.0),
  });

  @override
  _SwipeToState createState() => _SwipeToState();
}

class _SwipeToState extends State<SwipeTo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> animation;
  Animation<double> iconFadeAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        curve: Curves.decelerate,
        parent: _controller,
      ),
    );
    iconFadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.decelerate,
        parent: _controller,
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        print('${details.delta.dx}');
        if (details.delta.dx > 1) {
          _controller.forward().whenComplete(() {
            _controller.reverse();
            widget.callBack();
          });
        }
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          FadeTransition(
            opacity: iconFadeAnimation,
            child: Icon(
              widget.iconData,
              size: widget.iconSize,
              color: widget.iconColor ?? Theme.of(context).iconTheme.color,
            ),
          ),
          SlideTransition(
            position: animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
