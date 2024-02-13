import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class ListHome extends StatefulWidget {
  const ListHome({Key? key}) : super(key: key);

  @override
  State<ListHome> createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  Stream<List<String>> loadNames() async* {
    late final StreamController<List<String>> controller;
    controller = StreamController<List<String>>();
    int counter = 0;
    List<String> _names = List<String>.empty(growable: true);
    void tick(Timer timer) {
      counter++;
      // _names.add("name $counter");
      _names.insert(0, "Name $counter");
      controller.add(_names); // Ask stream to send counter values as event.
      if (counter >= 15) {
        timer.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    Timer.periodic(const Duration(seconds: 3), tick);
    yield* controller.stream; // In this line, add the * after yield
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Example Home'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: StreamBuilder<List<String>>(
            stream: loadNames(),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading..."));
              }
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.map((name) {
                    return SwipeTo(
                      key: UniqueKey(),
                      iconOnLeftSwipe: Icons.arrow_forward,
                      iconOnRightSwipe: Icons.arrow_back,
                      onRightSwipe: (details) {
                        log("\n Left Swipe Data --> $name");
                      },
                      swipeSensitivity: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          tileColor: Colors.cyan.shade200,
                          title: Text(name),
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                // ignore: avoid_unnecessary_containers
                return Container(
                  child: const Center(
                    child: Text("No Data in Stream"),
                  ),
                );
              }
            },
          )),
    );
  }
}
