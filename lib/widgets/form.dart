import 'package:flutter/material.dart';

class FormUi extends StatelessWidget {
  const FormUi({
    Key? key,
    required TextEditingController controller,
    required String hint,
  })  : _controller = controller,
        _hintText = hint,
        super(key: key);

  final TextEditingController _controller;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (e) {
            if (e!.isEmpty) {
              return 'Please insert ${_hintText.toLowerCase()}';
            }
          },
          controller: _controller,
          decoration: InputDecoration(
            hintText: _hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
