import 'package:flutter/material.dart';

class FormUi extends StatelessWidget {
  const FormUi({
    Key? key,
    required TextEditingController email,
  }) : _email = email, super(key: key);

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (e) {
            if (e!.isEmpty) {
              return 'Please insert email';
            }
          },
          controller: _email,
          decoration: const InputDecoration(
            hintText: 'Email',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}