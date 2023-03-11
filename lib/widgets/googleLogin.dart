import 'package:flutter/material.dart';

class googleLogin extends StatelessWidget {
  const googleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          width: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 0,
                blurRadius: 5.0,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Image.asset(
                  "assets/images/googleLogo.png",
                  scale: 20,
                ),
              ),
              const Text(
                "Sign in with Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
