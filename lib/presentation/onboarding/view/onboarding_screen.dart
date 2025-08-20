import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assesment/constants/app_assets.dart';
import 'package:flutter_assesment/presentation/home/view/landing_page.dart';

import 'package:http/http.dart' as http;

import '../../../constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: height * 0.3,
            width: double.infinity,
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "At your servers",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            AppAssets.onboardingImage1,
            height: height * 0.4,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "We are here to make your trip memorable",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': 'mor_2314', 'password': '83r5^_'}),
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Jwt Token: $token')));
      // Handle successful login, e.g., navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    } else {
      // Handle error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.reasonPhrase}')),
      );
    }
  }
}
