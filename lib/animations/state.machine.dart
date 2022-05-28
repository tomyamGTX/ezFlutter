import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive two boolean state machine inputs.
class ExampleStateMachine extends StatefulWidget {
  const ExampleStateMachine({Key? key}) : super(key: key);

  @override
  _ExampleStateMachineState createState() => _ExampleStateMachineState();
}

class _ExampleStateMachineState extends State<ExampleStateMachine> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _hoverInput;
  SMIInput<bool>? _pressInput;

  @override
  void initState() {
    super.initState();

    rootBundle.load('asset/rives/rocket.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'Button');
        if (controller != null) {
          artboard.addController(controller);
          _hoverInput = controller.findInput('Hover');
          _pressInput = controller.findInput('Press');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button State Machine'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: _riveArtboard == null
                ? const SizedBox()
                : MouseRegion(
                    onEnter: (_) => _hoverInput?.value = true,
                    onExit: (_) => _hoverInput?.value = false,
                    child: GestureDetector(
                      onTapDown: (_) => _pressInput?.value = true,
                      onTapCancel: () => _pressInput?.value = false,
                      onTapUp: (_) => _pressInput?.value = false,
                      child: Rive(
                        artboard: _riveArtboard!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 152.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Click me',
                  style: titleTextStyle(),
                )),
          ),
        ],
      ),
    );
  }
}
