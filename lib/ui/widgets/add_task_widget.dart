import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddTaskBotomSheet extends StatefulWidget {
  const AddTaskBotomSheet({super.key});

  @override
  State<AddTaskBotomSheet> createState() => _AddTaskBotomSheetState();
}

class _AddTaskBotomSheetState extends State<AddTaskBotomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Create a task'),
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
      ],
    );
  }
}
