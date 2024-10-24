import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kurakani/services/navigation_service.dart';
import 'package:kurakani/widgets/rounded_image.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/storage_service.dart';

import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late double deviceHeight;
  late double deviceWidth;

  String? name;
  String? email;
  String? password;

  PlatformFile? _profileImage;

  late AuthProvider _authProvider;
  late NavigationService _navigationService;
  late DatabaseService _databaseService;
  late StorageService _storageService;


  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _databaseService = GetIt.instance.get<DatabaseService>();
    _storageService = GetIt.instance.get<StorageService>();
    _navigationService = GetIt.instance.get<NavigationService>();
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: deviceHeight * 0.98,
        width: deviceWidth * 0.97,
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageWidget(),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageWidget() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImage().then(
          (file) {
            setState(
              () {
                _profileImage = file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
              image: _profileImage!, size: deviceHeight * 0.15);
        } else {
          return NetworkImageRounded(
              key: UniqueKey(),
              imagePath:
                  'https://img.freepik.com/premium-photo/stylish-man-flat-vector-profile-picture-ai-generated_606187-310.jpg?semt=ais_hybrid',
              size: deviceHeight * 0.15);
        }
      }(),
    );
  }

  Widget _registerForm() {
    return Container(
      height: deviceHeight * 0.35,
      child: Form(
        key: _registerFormKey,
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInputField(
              onSaved: (_value) {
                setState(() {
                  name = _value;
                });
              },
              regEx: r'.{6,}',
              hintText: 'Name',
              obscureText: false),
          CustomInputField(
              onSaved: (_value) {
                setState(() {
                  email = _value;
                });
              },
              regEx: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              hintText: 'Email',
              obscureText: false),
          CustomInputField(
              onSaved: (_value) {
                setState(() {
                  password = _value;
                });
              },
              regEx: r'.{6,}',
              hintText: 'Password',
              obscureText: true),
        ],
      )),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: deviceHeight * 0.065,
      width: deviceWidth * 0.65,
      onPressed: () async {
          if(_registerFormKey.currentState!.validate() && _profileImage != null){
            _registerFormKey.currentState!.save();
            String? uid = await _authProvider.registerUserUsingEmailAndPassword(email, password);
            String? imageUrl = await _storageService.saveUserImage(uid!, _profileImage!);
            await _databaseService.createUser(uid, name!, email!, imageUrl!);
            _navigationService.removeAndNavigateToRoute('/home');
          }
      },
    );
  }
}
