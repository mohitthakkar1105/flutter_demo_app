import 'dart:io';
import 'package:demo_project_mohit/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../image_picker/ImagePickerService.dart';
import '../services/firebase_Auth/google_auth_service.dart';

class LoginApiTest extends StatefulWidget {
  const LoginApiTest({super.key});

  @override
  State<LoginApiTest> createState() => _LoginApiTestState();
}

class _LoginApiTestState extends State<LoginApiTest> {
  File? aadharImage; // Gallery se
  File? panImage; // Camera se

  // Aadhar — Gallery
  Future<void> pickAadharImage() async {
    final File? image = await ImagePickerService.instance.pickFromGallery();

    if (image == null) {
      return;
    }

    setState(() {
      aadharImage = image;
    });
  }

  // Pan — Camera
  Future<void> pickPanImage() async {
    final File? image = await ImagePickerService.instance.pickFromCamera();

    if (image == null) {
      return;
    }

    setState(() {
      panImage = image;
    });
  }

  // Submit — dono images upload karo
  Future<void> submitKyc() async {
    if (aadharImage == null || panImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dono images select karo")),
      );
      return;
    }

    final documents = {
      'aadhar_image': aadharImage!,
      'pan_image': panImage!,
      'license_image': aadharImage!, // agar pick kiya ho
      'profile_image': panImage!,
    };

    await context.read<LoginProvider>().register(documents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // API Button (existing)
              ElevatedButton(
                onPressed: () {
                  context.read<LoginProvider>().getProfile();
                },
                child: const Text("Call API"),
              ),

              const SizedBox(height: 20),

              // Aadhar — Gallery Button
              ElevatedButton(
                onPressed: pickAadharImage,
                child: const Text("Pick Aadhar (Gallery)"),
              ),

              if (aadharImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    aadharImage!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 20),

              // Pan — Camera Button
              ElevatedButton(
                onPressed: pickPanImage,
                child: const Text("Pick Pan (Camera)"),
              ),

              if (panImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    panImage!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: submitKyc,
                child: const Text("Submit KYC"),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final userCredential = await GoogleAuthService.instance
                      .signInWithGoogle();

                  final String? idToken = await userCredential?.user
                      ?.getIdToken();

                  print(idToken);

                  if (userCredential != null) {
                    print("Login Success");
                    print(userCredential.user?.uid);
                    print(userCredential.user?.displayName);
                    print(
                      userCredential.user?.displayName,
                    );
                    print(
                      userCredential.user?.email,
                    );
                    print(
                      "  id token hai ye backend me dena ke liye :-> $idToken",
                    );
                  }
                },
                child: const Text("Continue with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
