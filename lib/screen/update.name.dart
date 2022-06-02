import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:ez_flutter/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({Key? key}) : super(key: key);

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  final _name = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Update Name',
                  style: titleTextStyle(),
                ),
              ),
              FormUi(controller: _name, hint: 'Your Name'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        await Provider.of<AppUser>(context, listen: false)
                            .updateName(_name.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saving Changes...')),
                        );
                      }
                    },
                    child: const Text('Save Changes')),
              )
            ],
          ),
        ));
  }
}