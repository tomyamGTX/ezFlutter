import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../animations/evolution.dart';
import '../animations/light.switch.dart';
import '../animations/liquid.download.dart';
import '../animations/little.machine.dart';
import '../animations/simple.animation.dart';
import '../animations/state.machine.dart';
import '../providers/auth.provider.dart';
import '../widgets/drawer.home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = PageController(initialPage: 0);

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                index = 0;
                _controller.animateToPage(index,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
          GestureDetector(
              onTap: () {
                index = 1;
                _controller.animateToPage(index,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
        ],
        title: Text('Welcome ${AppUser.instance.user?.email!.split('@')[0]}'),
      ),
      body: DoubleBackToCloseApp(
        child: PageView(
          controller: _controller,
          children: [
            CustomFloatingActionButton(
              body: const RiveAnimation.asset(
                'asset/rives/person_snowday.riv',
                fit: BoxFit.cover,
              ),
              options: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PlayOneShotAnimation()));
                    },
                    child: const Chip(
                        label: Text(
                      'Bounce Animation',
                    ))),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ExampleStateMachine()));
                    },
                    child: const Chip(
                        label: Text(
                      'Button Effect Animation',
                    ))),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StateMachineSkills()));
                    },
                    child: const Chip(
                        label: Text(
                      'Evolution Animation',
                    ))),
              ],
              type: CustomFloatingActionButtonType.circular,
              openFloatingActionButton: const Icon(Icons.add),
              closeFloatingActionButton: const Icon(Icons.close),
            ),
            CustomFloatingActionButton(
              body: const RiveAnimation.asset(
                'asset/rives/bird.riv',
                fit: BoxFit.contain,
              ),
              options: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LiquidDownload()));
                    },
                    child: const Chip(
                        label: Text(
                      'Liquid Download Animation',
                    ))),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LittleMachine()));
                    },
                    child: const Chip(
                        label: Text(
                      'Little Machine Animation',
                    ))),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StateMachineAction()));
                    },
                    child: const Chip(
                        label: Text(
                      'State Machine Animation',
                    ))),
              ],
              type: CustomFloatingActionButtonType.circular,
              openFloatingActionButton: const Icon(Icons.add),
              closeFloatingActionButton: const Icon(Icons.close),
            ),
          ],
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
    ));
  }
}
