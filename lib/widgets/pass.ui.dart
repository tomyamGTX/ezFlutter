import 'package:flutter/material.dart';

class PassUI extends StatelessWidget {
  const PassUI({
    Key? key,
    required TextEditingController pass,
  }) : _pass = pass, super(key: key);

  final TextEditingController _pass;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.key),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Please insert password';
                      }
                    },
                    controller: _pass,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}