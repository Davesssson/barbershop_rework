import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class adminLoginScreen extends HookConsumerWidget {
  const adminLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(8),
                        suffixIcon: Icon(Icons.email),
                        suffixIconColor: Colors.black,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(8),
                        suffixIcon: Icon(Icons.email),
                        suffixIconColor: Colors.black,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
