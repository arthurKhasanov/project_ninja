import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppTaskPage extends StatefulWidget {
  const AppTaskPage({super.key});

  @override
  State<AppTaskPage> createState() => _AppTaskPageState();
}

class _AppTaskPageState extends State<AppTaskPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add task')),
      body: Column(children: [
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderDateTimePicker(name: 'date_start'),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              print('${_formKey.currentState?.fields}');
            },
            child: const Text('Print'))
      ]),
    );
  }
}
