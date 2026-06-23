// import 'dart:developer';
// import 'package:flutter/material.dart';

// final class Loading extends StatefulWidget {
//   const Loading({super.key});

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadInitialData();
//   }

//   Future<void> loadInitialData() async {
//     var accessToken = appData.read(kKeyAccessToken);
//     var kLoggedIn = appData.read(kKeyIsLogin);

//     log("----token--$accessToken");
//     log("----kLoggedIn--$kLoggedIn");

//     // Show splash for a while
//     await Future.delayed(Durations.extralong2);

//     // ✅ only update if token is not null
//     if (accessToken != null) {
//       DioSingleton.instance.update(accessToken);
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     log("============ Loading screen build method called ================");
//     log("============ my phone: ${appData.read(kPhone)} ================");

//     if (_isLoading) {
//       return const SplashScreen();
//     } else {
//       // ✅ Check login state
//       if (appData.read(kKeyIsLogin) == true) {
//         final isCreator = appData.read('is_creator') ?? false;
//         if (isCreator) {
//           return const NavigationCreatorBar();
//         } else {
//           return NavigationBarScreen();
//         }
//       } else {
//         return const LanguageSectionScreen();
//       }
//     }
//   }
// }
