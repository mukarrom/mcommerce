import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  static const String name = '/products/create-review';

  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
                controller: _firstNameController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
                controller: _lastNameController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Review',
                ),
                controller: _reviewController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter your review";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
