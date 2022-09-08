// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sqflite_todo_app/database/listDatabase.dart';
import 'package:sqflite_todo_app/model/listData_model.dart';
import 'package:sqflite_todo_app/widget/form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final ListData? listData;

  const AddEditNotePage({
    Key? key,
    this.listData,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String email;
  late String mobileNumber;
  late String description;

  @override
  void initState() {
    super.initState();

    name = widget.listData?.name ?? "";
    email = widget.listData?.email ?? "";
    mobileNumber = widget.listData?.mobileNumber ?? "";
    description = widget.listData?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: ListsFormWidget(
            name: name,
            email: email,
            mobileNumber: mobileNumber,
            description: description,
            onChangedName: (name) => setState(
              () => this.name = name,
            ),
            onChangedEmail: (email) => setState(
              () => this.email = email,
            ),
            onChangedmobileNumber: (mobileNumber) => setState(
              () => this.mobileNumber = mobileNumber,
            ),
            onChangedDescription: (description) => setState(
              () => this.description = description,
            ),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty &&
        email.isNotEmpty &&
        mobileNumber.isNotEmpty &&
        description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.listData != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.listData!.copy(
      name: name,
      email: email,
      mobileNumber: mobileNumber,
      description: description,
    );

    await ListDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = ListData(
      name: name,
      email: email,
      mobileNumber: mobileNumber,
      description: description,
      createdTime: DateTime.now(),
    );

    await ListDatabase.instance.create(note);
  }
}
