// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';

// class Application extends StatefulWidget {
//   const Application({super.key});

//   @override
//   State<StatefulWidget> createState() => _Application();
// }

// class _Application extends State<Application> {
//   Future<void> setupInteractedMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }
//     print("initial message is null");
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }

//   void _handleMessage(RemoteMessage message) {
//     print(message.data);
//   }

//   @override
//   void initState() {
//     super.initState();
//     setupInteractedMessage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Text("...");
//   }
// }
