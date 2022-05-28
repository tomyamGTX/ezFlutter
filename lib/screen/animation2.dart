// import 'package:custom_floating_action_button/custom_floating_action_button.dart';
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import '../animations/evolution.dart';
// import '../animations/light.switch.dart';
// import '../animations/liquid.download.dart';
// import '../animations/little.machine.dart';
// import '../animations/simple.animation.dart';
// import '../animations/state.machine.dart';
// import '../providers/auth.provider.dart';
// import '../widgets/drawer.home.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final _controller = PageController(initialPage: 0);
//
//   var index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     var _options1 = [
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PlayOneShotAnimation()));
//           },
//           child: const Chip(
//               label: Text(
//                 'Bounce Animation',
//               ))),
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const ExampleStateMachine()));
//           },
//           child: const Chip(
//               label: Text(
//                 'Button Effect Animation',
//               ))),
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const StateMachineSkills()));
//           },
//           child: const Chip(
//               label: Text(
//                 'Evolution Animation',
//               ))),
//     ];
//     var _options2 = [
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const LiquidDownload()));
//           },
//           child: const Chip(
//               label: Text(
//                 'Liquid Download Animation',
//               ))),
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => const LittleMachine()));
//           },
//           child: const Chip(
//               label: Text(
//                 'Little Machine Animation',
//               ))),
//       GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const StateMachineAction()));
//           },
//           child: const Chip(
//               label: Text(
//                 'State Machine Animation',
//               ))),
//     ];
//     return SafeArea(child: StatefulBuilder(builder: (context, setState) {
//       return CustomFloatingActionButton(
//         body: Scaffold(
//           resizeToAvoidBottomInset: false,
//           drawer: buildDrawer(context),
//           appBar: AppBar(
//             actions: [
//               InkWell(
//                   onTap: () {
//                     index = 0;
//                     print(index);
//
//                     _controller.animateToPage(index,
//                         duration: const Duration(seconds: 2),
//                         curve: Curves.fastLinearToSlowEaseIn);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       child: Text(
//                         '1',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   )),
//               InkWell(
//                   onTap: () {
//                     index = 1;
//                     print(index);
//                     _controller.animateToPage(index,
//                         duration: const Duration(seconds: 2),
//                         curve: Curves.fastLinearToSlowEaseIn);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       child: Text(
//                         '2',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ))
//             ],
//             title:
//             Text('Welcome ${AppUser.instance.user?.email!.split('@')[0]}'),
//           ),
//           body: PageView(
//             controller: _controller,
//             children: const [
//               RiveAnimation.asset(
//                 'asset/rives/person_snowday.riv',
//                 fit: BoxFit.cover,
//               ),
//               RiveAnimation.asset(
//                 'asset/rives/person_snowday.riv',
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ),
//         ),
//         options: index == 0 ? _options1 : _options2,
//         type: CustomFloatingActionButtonType.circular,
//         openFloatingActionButton: const Icon(Icons.add),
//         closeFloatingActionButton: const Icon(Icons.close),
//       );
//     }));
//   }
// }
