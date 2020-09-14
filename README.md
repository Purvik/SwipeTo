# swipe_to

SwipeTo is a wrapper for a chat view widget which can be used initiate callback when user horizontally swipe on it.

## Getting Started
To use this packages, you just simply need to wrap your child component in `SwipeTo` widget and pass a `VoidCallback` that you can carry forward with your task.

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  swipe_to: 0.0.1+3
```

In your library add the following import:

```dart
import 'package:swipe_to/swipe_to.dart';
```
# Parameter Info
* **child** : (@required) `StateLess` or `StateFull` flutter widget.
* **callBack** : (@required) callback which will be initiated at the end of swipe animation
* **swipeDirection** : Enum value from [``swipeToLeft``, ``swipeToRight``] only. Make sure to pass relative Offset value according to passed ``swipeDirection`` value. If not specified ``swipeToRight`` will be taken as default
* **animationDuration** : Duration value to define animation duration. if not specidifed default is **150 milliseconds**
* **iconData** : IconData that will be displayed beneath child widget. if not specified default is `Icons.reply`
* **iconSize** : double value defining size of displayed icon beneath child widget. if not specified default it will take **26** 
* **iconColor** : color value defining color of displayed icon beneath child widget. if not specified `primaryColor` from theme will be taken
* **endOffset** : Offset value till which position of child widget will get animated. if not specified **Offset(0.3, 0.0)** default will be taken

Wrap your desired widget with `SwipeTo`.
**Example** : **SwipeToRight**
```dart
SwipeTo(
    swipeDirection: SwipeDirection.swipeToRight,
    endOffset: Offset(0.3, 0.0),
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text('Hey You! Swipe me right 👉🏿'),
    ),
    callBack: () {
        print('Callback from Swipe To Right');
    },
),
```
**Example** : **SwipeToLeft**
```dart
SwipeTo(
    swipeDirection: SwipeDirection.swipeToLeft,
    endOffset: Offset(-0.3, 0.0),
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text('👈🏿 Hey You! Swipe me Left'),
    ),
    callBack: () {
        print('Callback from Swipe To Left');
    },
),
```
## Sample Outputs
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/swipe_right_left.gif" width="256" height="512" title="Swipe Right Left Output">
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/android.gif" width="256" height="512" title="Swipe To Android Output">
<img src="https://github.com/Purvik/SwipeTo/raw/master/example/output/ios.gif" width="256" height="512" title="Swipe To iOS Output">

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
