import 'package:flutter/material.dart';

enum SwipeDirection { swipeToLeft, swipeToRight }

/// SwipeTo is a wrapper widget to other Widget that we can swipe horizontally
/// to initiate a callback when animation gets end.
/// It is useful to develop and What's App kind of replay animation for a
/// component of ongoing chat.
class SwipeTo extends StatefulWidget {
  /// Child widget for which you want to have horizontal swipe action
  /// @required parameter
  final Widget child;

  /// Duration value to define animation duration
  final Duration animationDuration;

  /// Enum value from [swipeToLeft, swipeToRight] only
  /// Make sure to pass relative Offset value according to passed Offset value
  /// If not specified swipeToRight will be taken as default
  final SwipeDirection swipeDirection;

  /// Icon that will be displayed beneath child widget
  final IconData iconData;

  /// double value defining size of displayed icon beneath child widget
  /// if not specified default it will take 26
  final double iconSize;

  /// color value defining color of displayed icon beneath child widget
  ///if not specified primaryColor from theme will be taken
  final Color iconColor;

  /// Offset value till which position child widget will get animate
  /// Make sure to pass relative value align to passed SwipeDirection enum value
  /// if not specified Offset(0.3, 0.0) default will be taken
  final Offset endOffset;

  /// callback which will be initiated at then end of child widget animation
  /// @required parameter
  final VoidCallback callBack;

  SwipeTo({
    @required this.child,
    @required this.callBack,
    this.swipeDirection = SwipeDirection.swipeToRight,
    this.iconData = Icons.reply,
    this.iconSize = 26.0,
    this.iconColor,
    this.animationDuration = const Duration(milliseconds: 150),
    this.endOffset = const Offset(0.3, 0.0),
  })  : assert(child != null, "You must pass a child widget."),
        assert(callBack != null, "You must pass a callback."),
        assert(
            ((swipeDirection == SwipeDirection.swipeToLeft &&
                    endOffset.dx <= -0.3 &&
                    endOffset.dy == 0.0) ||
                (swipeDirection == SwipeDirection.swipeToRight &&
                    endOffset.dx >= 0.3 &&
                    endOffset.dy == 0.0)),
            "For value swipeToLeft Offset(dx,..) value must be <=-0.3 & for value swipeToRight Offset(dx,..) value must be >=0.3");

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
        if (widget.swipeDirection == SwipeDirection.swipeToRight &&
            details.delta.dx > 1) {
          _controller.forward().whenComplete(() {
            _controller.reverse().whenComplete(() => widget.callBack());
          });
        }
        if (widget.swipeDirection == SwipeDirection.swipeToLeft &&
            details.delta.dx < -1) {
          _controller.forward().whenComplete(() {
            _controller.reverse().whenComplete(() => widget.callBack());
          });
        }
      },
      child: Stack(
        alignment: widget.swipeDirection == SwipeDirection.swipeToRight
            ? Alignment.centerLeft
            : Alignment.centerRight,
        fit: StackFit.loose,
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
