// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_new, unused_local_variable, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoop_app/app/auth_widgets/have_account_widget.dart';
import 'package:shoop_app/app/auth_widgets/snack_bar_widget.dart';


import '../../auth_widgets/camera_choice_widget.dart';
import '../../constants/colors/app_colors.dart';
import '../../welcome_page/welcome_widgets/google_facebook_guest_widget.dart';

class SuppliersSignUp extends StatefulWidget {
  const SuppliersSignUp({Key? key}) : super(key: key);

  @override
  _SuppliersSignUpState createState() => _SuppliersSignUpState();
}

class _SuppliersSignUpState extends State<SuppliersSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');
  String? _name;
  String? _email;
  String? _password;
  bool isVisible = true;
  bool processing = false;
  late String _profileImage;
  late String _uid;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  void _pickImageFromCamera() async {
    try {
      final _pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );

      setState(() {
        _imageFile = _pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });

      log('image error $_pickedImageError');
    }
  }

  void _pickImageFromGallery() async {
    try {
      final _pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );

      setState(() {
        _imageFile = _pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });

      log('image error $_pickedImageError');
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email!,
            password: _password!,
          );
          firebase_storage.Reference reference = firebase_storage
              .FirebaseStorage.instance
              .ref('suppliers-images/$_email.jpg');
          await reference.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid;
          _profileImage = await reference.getDownloadURL();
          Navigator.pushReplacementNamed(context, '/suppliers_page');
          await suppliers.doc(_uid).set({
            'name': _name,
            'email': _email,
            'phone': '',
            'address': '',
            'profileImage': _profileImage,
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            SnackBarWidget.snackBar(
                'The password provided is too weak.', _scaffoldKey);
            log('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            SnackBarWidget.snackBar(
                'The account already exists for that email.', _scaffoldKey);
            log('The account already exists for that email.');
          }
        } catch (e) {
          setState(() {
            processing = false;
          });
          SnackBarWidget.snackBar('$e', _scaffoldKey);
          log('$e');
        }
      } else {
        setState(() {
          _imageFile = null;
        });
        SnackBarWidget.snackBar('Please pick an image', _scaffoldKey);
      }
    } else {
      setState(() {
        processing = false;
      });
      SnackBarWidget.snackBar('Please fill your blank', _scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/welcome_page');
                        },
                        icon: const Icon(
                          Icons.home_work,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.yellow,
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CameraChoiceWidget(
                              icon: Icons.camera_alt,
                              onTap: () {
                                _pickImageFromCamera();
                              },
                              radiusOnly: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            CameraChoiceWidget(
                              icon: Icons.photo,
                              onTap: () {
                                _pickImageFromGallery();
                              },
                              radiusOnly: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            _name = value;
                            log(_name!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill your full Name';
                            } else {}
                            return null;
                          },
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: AppColors.blue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: AppColors.yellow, width: 2.0),
                            ),
                            hintText: 'Please enter your full name ',
                            label: const Text(
                              'Full name',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueGrey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _email = value;
                            log(_email!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill your email';
                            } else if (value.isValidEmail() == false) {
                              return 'Not Valid';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: AppColors.blue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: AppColors.yellow, width: 2.0),
                            ),
                            hintText: 'Please enter your email  ',
                            label: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.blueGrey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _password = value;
                            log(_password!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill your password';
                            } else {
                              return null;
                            }
                          },
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(isVisible == true
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: AppColors.blue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: AppColors.purple, width: 2.0),
                            ),
                            hintText: 'Please enter your password ',
                            label: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.blueGrey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        HaveAccountWidget(
                          haveAccount: 'already have account?',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/suppliers_login');
                          },
                          registerTitle: 'Sign In',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  processing == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellow,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            signUp();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 150,
                                vertical: 15,
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: AppColors.grey.withOpacity(0.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // GoogleFacebookGuestWidget(title: 'Google', icon: Icons.google, onTap: (){}),
                            GoogleFacebookGuestWidget(
                                title: 'Google',
                                image: Image.asset(
                                  'assets/images/inapp/google.jpg',
                                  width: 35,
                                ),
                                onTap: () {}),
                            GoogleFacebookGuestWidget(
                              image: Image.asset(
                                'assets/images/inapp/facebook.jpg',
                                width: 35,
                              ),
                              onTap: () {},
                              title: "FaceBook",
                            ),

                            GoogleFacebookGuestWidget(
                                title: 'Guest',
                                image: Image.asset(
                                  'assets/images/inapp/guest.jpg',
                                  width: 35,
                                ),
                                onTap: () async {
                                  try {
                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .signInAnonymously();
                                    print("Signed in with temporary account.");
                                  } on FirebaseAuthException catch (e) {
                                    switch (e.code) {
                                      case "operation-not-allowed":
                                        print(
                                            "Anonymous auth hasn't been enabled for this project.");
                                        break;
                                      default:
                                        print("Unknown error.");
                                    }
                                  }
                                }),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^([a-zA-Z0-9]+)([@])([a-zA-Z0-9]+)([\-\_\.])([a-z]{2,3})$')
        .hasMatch(this);
  }
}
// CRUD - 
// Create 
// Read 
// Update
// Delete