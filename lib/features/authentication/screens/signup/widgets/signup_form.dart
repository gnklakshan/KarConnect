import 'package:karconnect/backend/firebase/firebase_auth.dart';
import 'package:karconnect/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:karconnect/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({
    super.key,
  });

  @override
  _TSignupFormState createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  // Create the controllers for the form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Boolean variable to track password visibility
  bool _isObscure = true;

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Username
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Email
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Phone Number
          TextFormField(
            controller: phoneNoController,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Password with visibility toggle
          TextFormField(
            controller: passwordController,
            obscureText: _isObscure, // Control password visibility
            decoration: InputDecoration(
              labelText: TTexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: Icon(
                  // Change icon based on _isObscure
                  _isObscure ? Iconsax.eye_slash : Iconsax.eye,
                ),
                onPressed: () {
                  // Toggle password visibility
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Terms and conditions checkbox
          const TTermsAndConditionsCheckbox(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final firstName = firstNameController.text;
                final lastName = lastNameController.text;
                final username = usernameController.text;
                final email = emailController.text;
                final phoneNo = phoneNoController.text;
                final password = passwordController.text;

                if (firstName.isEmpty ||
                    lastName.isEmpty ||
                    username.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty ||
                    phoneNo.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Fill Required Data Fields Correctly',
                    backgroundColor: const Color.fromARGB(92, 240, 240, 240),
                    icon: const Icon(
                      Icons.warning,
                      color: Color.fromARGB(225, 251, 3, 3),
                    ),
                  );
                } else {
                  final newUser =
                      await registerWithEmailAndPassword(email, password);

                  if (newUser != null) {
                    addNewUser(firstName, lastName, username, email, phoneNo);
                    Get.to(() => const VerifyEmailScreen());
                  } else {
                    Get.snackbar(
                      'Error',
                      'User creation failed',
                      backgroundColor: const Color.fromARGB(112, 255, 255, 255),
                      icon: const Icon(Icons.warning),
                    );
                  }
                }
              },
              child: const Text('Create Account'),
            ),
          ),
        ],
      ),
    );
  }
}
