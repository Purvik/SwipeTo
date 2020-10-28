import 'package:flutter/material.dart';

/// SwipeTo is a wrapper widget to other Widget that we can swipe horizontally
/// to initiate a callback when animation gets end.
/// It is useful to develop and What's App kind of replay animation for a
/// component of ongoing chat.
class SwipeTo extends StatefulWidget {
  /// Child widget for which you want to have horizontal swipe action
  /// @required parameter
  final Widget child;

  /// Duration value to define animation duration
  /// if not passed default Duration(milliseconds: 150) will be taken
  final Duration animationDuration;

  /// Icon that will be displayed beneath child widget when swipe right
  final IconData iconOnRightSwipe;

  /// Widget that will be displayed beneath child widget when swipe right
  final Widget rightSwipeWidget;

  /// Icon that will be displayed beneath child widget when swipe left
  final IconData iconOnLeftSwipe;

  /// Widget that will be displayed beneath child widget when swipe right
  final Widget leftSwipeWidget;

  /// double value defining size of displayed icon beneath child widget
  /// if not specified default size 26 will be taken
  final double iconSize;

  /// color value defining color of displayed icon beneath child widget
  ///if not specified primaryColor from theme will be taken
  final Color iconColor;

  /// Double value till which position child widget will get animate when swipe left
  /// or swipe right
  /// if not specified 0.3 default will be taken for Right Swipe &
  /// it's negative -0.3 will bve taken for Left Swipe
  final double offsetDx;

  /// callback which will be initiated at the end of child widget animation
  /// when swiped right
  /// if not passed swipe to right will be not available
  final VoidCallback onRightSwipe;

  /// callback which will be initiated at the end of child widget animation
  /// when swiped left
  /// if not passed swipe to left will be not available
  final VoidCallback onLeftSwipe;

  SwipeTo({
    @required this.child,
    this.onRightSwipe,
    this.onLeftSwipe,
    this.iconOnRightSwipe = Icons.reply,
    this.rightSwipeWidget,
    this.iconOnLeftSwipe = Icons.reply,
    this.leftSwipeWidget,
    this.iconSize = 26.0,
    this.iconColor,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetDx = 0.3,
  }) : assert(child != null, "You must pass a child widget.");

  @override
  _SwipeToState createState() => _SwipeToState();
}

class _SwipeToState extends State<SwipeTo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _leftIconAnimation;
  Animation<double> _rightIconAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    _leftIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _rightIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///Run animation for child widget
  ///[onRight] value defines animation Offset direction
  void _runAnimation({bool onRight}) {
    //set child animation
    _animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(onRight ? widget.offsetDx : -widget.offsetDx, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    //set back left/right icon animation
    if (onRight) {
      _leftIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    } else {
      _rightIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    }
    //Forward animation
    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (onRight) {
          //keep left icon visibility to 0.0 until onRightSwipe triggers again
          _leftIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          widget.onRightSwipe();
        } else {
          //keep right icon visibility to 0.0 until onLeftSwipe triggers again
          _rightIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          widget.onLeftSwipe();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (widget.onRightSwipe != null && details.delta.dx > 1) {
          _runAnimation(onRight: true);
        }
        if (widget.onLeftSwipe != null && details.delta.dx < -1) {
          _runAnimation(onRight: false);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                visible: widget.onRightSwipe != null,
                child: AnimatedOpacity(
                  opacity: _leftIconAnimation.value,
                  duration: widget.animationDuration,
                  curve: Curves.decelerate,
                  child: widget.rightSwipeWidget != null
                      ? widget.rightSwipeWidget
                      : Icon(
                          widget.iconOnRightSwipe,
                          size: widget.iconSize,
                          color: widget.iconColor ??
                              Theme.of(context).iconTheme.color,
                        ),
                ),
              ),
              Visibility(
                visible: widget.onLeftSwipe != null,
                child: AnimatedOpacity(
                  opacity: _rightIconAnimation.value,
                  duration: widget.animationDuration,
                  curve: Curves.decelerate,
                  child: widget.leftSwipeWidget != null
                      ? widget.leftSwipeWidget
                      : Icon(
                          widget.iconOnLeftSwipe,
                          size: widget.iconSize,
                          color: widget.iconColor ??
                              Theme.of(context).iconTheme.color,
                        ),
                ),
              ),
            ],
          ),
          SlideTransition(
            position: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
