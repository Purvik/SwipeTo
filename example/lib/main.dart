import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe To Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.blue.shade200,
        ),
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Swipe To Example'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ///SwipeToRight Example
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SwipeTo(
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: MessageViewWidget(
                      label: 'Hey You! Swipe me right 👉🏿',
                    ),
                  ),
                  onRightSwipe: () {
                    _displayInputBottomSheet(true);
                  },
                ),
              ],
            ),

            ///SwipeToLeft Example
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SwipeTo(
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: MessageViewWidget(
                      label: '👈🏿 Hey You! Swipe me Left',
                    ),
                  ),
                  onLeftSwipe: () {
                    _displayInputBottomSheet(false);
                  },
                ),
              ],
            ),

            ///SwipeToRight & SwipeToLeft Example
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SwipeTo(
                  child: const MessageViewWidget(
                    label: '👈🏿 Swipe me Left OR Swipe me right 👉🏿 ',
                  ),
                  iconOnLeftSwipe: Icons.arrow_forward,
                  leftSwipeWidget: const FlutterLogo(
                    size: 30.0,
                  ),
                  iconOnRightSwipe: Icons.arrow_back,
                  rightSwipeWidget: const FlutterLogo(
                    size: 30.0,
                  ),
                  onRightSwipe: () {
                    _displayInputBottomSheet(true);
                  },
                  onLeftSwipe: () {
                    _displayInputBottomSheet(false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSwipeReply({required bool isRightSwipe, required String reply}) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          reply,
          textAlign: TextAlign.center,
        ),
        backgroundColor:
            isRightSwipe ? Colors.red.shade600 : Colors.green.shade600,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void _displayInputBottomSheet(bool isRightSwipe) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 16.0,
            ),
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              onSubmitted: (value) => _handleSwipeReply(
                  isRightSwipe: isRightSwipe ? true : false, reply: value),
              decoration: const InputDecoration(
                labelText: 'Reply',
                hintText: 'enter reply here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MessageViewWidget extends StatelessWidget {
  const MessageViewWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Text(label));
  }
}
