import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class adminRegisterScreen extends HookConsumerWidget {
  const adminRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final shopNameController = useTextEditingController();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        child: ListView(
            children: [
              Container(height: 300, width:MediaQuery.of(context).size.width, child:Image.asset("business-people-shaking-hands-together_53876-20488.jpg",fit: BoxFit.fitWidth,)),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Form(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Email"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                        ),
                      ),
                      Text("Password"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                        ),
                      ),
                      Text("Shop Name"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: shopNameController,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8),
                            suffixIcon: Icon(Icons.email),
                            suffixIconColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            final shopName = shopNameController.text.trim();
                            final String id = await ref
                                .read(barbershopRepositoryProvider)
                                .createBarbershop(
                                    shopName: shopName,
                                    email: email,
                                    password: password);
                            GoRouter.of(context).go("/admin/${id}");
                          },
                          child: Container(
                            height: 40,
                            color: Theme.of(context).primaryColor,
                            child: Text("Regisztráld be az üzleted!"),
                          ))
                    ],)
                  ),
                ),
            ),
          ]
        ),
      ),
    );
  }
}
