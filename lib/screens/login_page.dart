import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurakani/widgets/custom_input_field.dart';
import 'package:kurakani/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceHeight;
  late double deviceWidth;
  late AuthProvider _authProvider;
  late NavigationService _navigationService;

  final loginFormKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _navigationService = GetIt.instance.get<NavigationService>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.03,
          vertical: deviceHeight * 0.02,
        ),
        height: deviceHeight * 0.98,
        width: deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: deviceHeight * 0.10,
              child: const Text(
                "Kura Kani",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
              ),
            ),
            loginForm(),
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            loginButton(),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            registerAccount(),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Container(
      height: deviceHeight * 0.18,
      child: Form(
        key: loginFormKey,
        
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInputField(
                onSaved: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                regEx: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                hintText: 'Email',
                obscureText: false),
            CustomInputField(
                onSaved: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                regEx: r'.{6,}',
                hintText: 'Password',
                obscureText: true)
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return RoundedButton(
        name: 'Login',
        height: deviceHeight * 0.06,
        width: deviceWidth * 0.65,
        onPressed: () {
          if(loginFormKey.currentState!.validate()){
            loginFormKey.currentState!.save();
            _authProvider.loginWithEmailAndPassword(_email!, _password!);
  
          }
        });
  }

  Widget registerAccount() {
    return GestureDetector(
      onTap: ()=> _navigationService.navigateToRoute('/register'),
      child: Container(
        child: const Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
