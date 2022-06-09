import 'package:flutter/material.dart';

class PassUI extends StatefulWidget {
  const PassUI({
    Key? key,
    required TextEditingController pass,
  })  : _pass = pass,
        super(key: key);

  final TextEditingController _pass;

  @override
  State<PassUI> createState() => _PassUIState();
}

class _PassUIState extends State<PassUI> {
  var visible = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.key),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: TextFormField(
                    obscureText: !visible,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Please insert password';
                      }
                    },
                    controller: widget._pass,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () => setState(() {
                                visible = !visible;
                              }),
                          icon: Icon(
                            visible ? Icons.visibility : Icons.visibility_off,
                          )),
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
