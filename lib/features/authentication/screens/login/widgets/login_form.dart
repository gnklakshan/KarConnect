import 'package:firebase_auth/firebase_auth.dart';
import 'package:karconnect/backend/firebase/firebase_auth.dart';
import 'package:karconnect/features/authentication/screens/signup/signup.dart';
import 'package:karconnect/features/dashboard/dashbord.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  // Create the controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              obscureText: true, // Add this to hide the password
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                // Forgot password
                TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.forgotPassword),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    print("username $email $password");
                    UserCredential? result =
                        await signInWithEmailAndPassword(email, password);
                    print("username $email $password");
                    if (result != null) {
                      // User created successfully
                      print("Successfully login");
                      Get.to(() => dashboard());
                    } else {
                      // Error occurred
                      // Get.to(() => dashboard());
                      Get.snackbar('Error', 'User creation failed',
                          backgroundColor: Color.fromARGB(67, 255, 255, 255),
                          icon: Icon(Icons.warning));
                    }
                    // final uid = FirebaseAuth.instance.currentUser!.uid;
                    // print(uid.toString());
                  },
                  child: Text(TTexts.signIn)),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
