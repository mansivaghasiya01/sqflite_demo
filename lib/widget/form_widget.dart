import 'package:flutter/material.dart';

class ListsFormWidget extends StatelessWidget {
  const ListsFormWidget({
    Key? key,
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.description = '',
    required this.onChangedName,
    required this.onChangedEmail,
    required this.onChangedmobileNumber,
    required this.onChangedDescription,
  }) : super(key: key);

  //final String? title;
  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? description;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedEmail;
  final ValueChanged<String> onChangedmobileNumber;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(height: 8),
            buildEmail(),
            const SizedBox(height: 8),
            buildMobileNumber(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your name',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'The name cannot be empty' : null,
        onChanged: onChangedName,
      );
  Widget buildEmail() => TextFormField(
        maxLines: 1,
        initialValue: email,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (email) =>
            email != null && email.isEmpty ? 'The email cannot be empty' : null,
        onChanged: onChangedEmail,
      );
  Widget buildMobileNumber() => TextFormField(
        maxLines: 1,
        initialValue: mobileNumber,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your Mobile number',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (mobileNumber) =>
            mobileNumber != null && mobileNumber.isEmpty
                ? 'The mobileNumber cannot be empty'
                : null,
        onChanged: onChangedmobileNumber,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 50,
        initialValue: description,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'what are you planning...',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
