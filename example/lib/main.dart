import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  String _replyForRight;
  String _replyForLeft;

  @override
  void initState() {
    super.initState();
    _replyForRight = '';
    _replyForLeft = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe To Example'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
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
                  swipeDirection: SwipeDirection.swipeToRight,
                  endOffset: Offset(0.3, 0.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    child: Text('Hey You! Swipe me right 👉🏿'),
                  ),
                  callBack: () {
                    print('Handling callback after animation end');
                    _displayInputBottomSheet(SwipeDirection.swipeToRight);
                  },
                ),
                Visibility(
                  visible: _replyForRight.isNotEmpty,
                  replacement: SizedBox(),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: Text(
                        _replyForRight,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            ///SwipeToLeft Example
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SwipeTo(
                  swipeDirection: SwipeDirection.swipeToLeft,
                  endOffset: Offset(-0.3, 0.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    child: Text('👈🏿 Hey You! Swipe me Left'),
                  ),
                  callBack: () {
                    print('Handling callback after animation end');
                    _displayInputBottomSheet(SwipeDirection.swipeToLeft);
                  },
                ),
                Visibility(
                  visible: _replyForLeft.isNotEmpty,
                  replacement: SizedBox(),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: Text(
                        _replyForLeft,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleReply(String reply, SwipeDirection swipeDirection) {
    Navigator.pop(context);
    setState(() {
      if (swipeDirection == SwipeDirection.swipeToRight) {
        _replyForRight = reply;
      } else {
        _replyForLeft = reply;
      }
    });
  }

  void _displayInputBottomSheet(SwipeDirection swipeDirection) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 16.0,
            ),
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => _handleReply(value, swipeDirection),
              decoration: InputDecoration(
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
