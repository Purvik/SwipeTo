# swipe_to

SwipeTo is a wrapper for a chat view widget which can be used initiate callback when user horizontally swipe on it.

## Getting Started
To use this packages, you just simply need to wrap your child component in `SwipeTo` widget and pass a `VoidCallback` that you can carry forward with your task.

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  swipe_to: 1.0.4
```

In your library add the following import:

```dart
import 'package:swipe_to/swipe_to.dart';
```
## Parameter Info
* **``child``** : (@required) `StateLess` or `StateFull` flutter widget.
* **``onRightSwipe``** : callback which will be initiated at the end of right swipe animation. If not passed right swipe will be disabled
* **``onLeftSwipe``** : callback which will be initiated at the end of left swipe animation. If not passed left swipe will be disabled
* **``iconOnRightSwipe``** : IconData that will be displayed on left beneath child widget when swiped right. If not specified default is `Icons.reply`
* **``rightSwipeWidget``** : Widget that will be displayed beneath child widget when swipe right. If `iconOnRightSwipe` is defined this will have no effect.
* **``iconOnLeftSwipe``** : IconData that will be displayed on right beneath child widget when swiped left. If not specified default is `Icons.reply`
* **``leftSwipeWidget``** : Widget that will be displayed beneath child widget when swipe left. If `iconOnLeftSwipe` is defined this will have no effect.
* **``iconSize``** : Double value defining size of displayed icon beneath child widget. If not specified default it will take **26** 
* **``iconColor``** : Color value defining color of displayed icon beneath child widget. If not specified `primaryColor` from theme will be taken
* **``offsetDx``** : Double dx value used in ``Offset()`` till which position of child widget will get animated. If not specified **0.3** default will be taken. onRightSwipe +dx value will be used and for onLeftSwipe -dx value will be used
* **``animationDuration``** : Duration value to define animation duration. If not specified default is **150 milliseconds**
* **``swipeSensitivity``** : Swipe sensitivity integer value which will be in range of default min 20 to max 35. Crossing mentioned value of this parameter (+ve in right and -ve in left direction) will trigger swipe animation.
 
## Major changes onwards [ver 0.0.1+5]
* For a single child widget, we can now enable swipe for both left and right direction
* ``swipeDirection`` parameter is removed. Now ``onLeftSwipe`` and `onRightSwipe` callback will enable swiping for a particular direction if passed
* ``iconData`` is now split into two parameter, ``iconOnRightSwipe`` & ``iconOnLeftSwipe`` for future use
* ``endOffset`` is now change to accept a double value only
* ``callBack`` is now split into two parameter, ``onLeftSwipe`` & ``onRightSwipe``

## Deprecated/Removed Parameters
* **swipeDirection** : Enum value from [``swipeToLeft``, ``swipeToRight``] only. Make sure to pass relative Offset value according to passed ``swipeDirection`` value. If not specified ``swipeToRight`` will be taken as default.
* **iconData** : IconData that will be displayed beneath child widget. if not specified default is `Icons.reply`
* **endOffset** : Offset value till which position of child widget will get animated. if not specified **Offset(0.3, 0.0)** default will be taken
* **callBack** : (@required) callback which will be initiated at the end of swipe animation


**Example** : **SwipeToRight**
Wrap your desired widget with `SwipeTo` & pass a call to `onRightSwipe` parameter.
```dart
SwipeTo(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text('Hey You! Swipe me right 👉🏿'),
    ),
    onRightSwipe: () {
        print('Callback from Swipe To Right');
    },
),
```
**Example** : **SwipeToLeft**
Wrap your desired widget with `SwipeTo` & pass a call to `onLeftSwipe` parameter.
```dart
SwipeTo(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text('👈🏿 Hey You! Swipe me Left'),
    ),
    onLeftSwipe: () {
        print('Callback from Swipe To Left');
    },
),
```

**Example** : **SwipeToLeft & SwipeToRight** 
Wrap your desired widget with `SwipeTo` & pass a call to `onLeftSwipe` & `onRightSwipe` parameters.
```dart
SwipeTo(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text('👈🏿 Swipe me Left | YOU |Swipe me right 👉🏿'),
    ),
    onLeftSwipe: () {
        print('Callback from Swipe To Left');
    },
    onRightSwipe: () {
        print('Callback from Swipe To Right');
    },
),
```
## Sample Outputs
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/ios.gif" width="256" height="512" title="Swipe To iOS Output">
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/android.gif" width="256" height="512" title="Swipe To Android Output">
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/ios_widget_in_back.gif" width="256" height="512" title="Swipe To iOS Output with Widget in back">
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/android_widget_in_back.gif" width="256" height="512" title="Swipe To Android Output with Widget in back">

## References to learn
https://medium.com/@purvik1239/enable-swiping-right-left-for-your-flutter-application-widgets-a7b556674f9c