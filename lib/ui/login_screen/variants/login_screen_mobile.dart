import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/repositories/auth_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen_mobile extends HookConsumerWidget{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final  emailController = useTextEditingController();
    final  passwordController = useTextEditingController();

    return Scaffold(
      body:ListView(
        children:[
          Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black
            ),
            Positioned(
                bottom: 0,
                //bottom: (MediaQuery.of(context).size.height*3)/4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150)
                    )
                  ),
                  height: (MediaQuery.of(context).size.height*3)/4,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            width: MediaQuery.of(context).size.width*0.8,
                            height: MediaQuery.of(context).size.height/9,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Email",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) => EmailValidator.validate(emailController.text) ? null : "Please enter a valid email",
                                  controller: emailController,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    suffixIcon: Icon(Icons.email),
                                    suffixIconColor: Colors.black,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //labelText: "Label",
                                    //labelStyle: TextStyle(
                                    //  color:Colors.black
                                    //),
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a search term',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            width: MediaQuery.of(context).size.width*0.8,
                            height: MediaQuery.of(context).size.height/9,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Password",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                  ),
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: passwordController,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    suffixIcon: Icon(Icons.email),
                                    suffixIconColor: Colors.black,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //labelText: "Label",
                                    //labelStyle: TextStyle(
                                    //  color:Colors.black
                                    //),
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a search term',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            width: MediaQuery.of(context).size.width*0.8,
                            height: MediaQuery.of(context).size.height/12,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                 child:Text( "Login"),
                                onPressed: (){
                                   try {
                                     if (_formKey.currentState!.validate()) {
                                       ref.watch(authRepositoryProvider).singInViaEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

                                     }
                                   }on CustomException catch(e){
                                     print(e.toString());
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       const SnackBar(content: Text('Invalid email or password provided')),
                                     );
                                  }
                                   //ref.watch(authRepositoryProvider).singInViaEmailAndPassword(emailController., password)
                                  //ref.watch(authControllerProvider.notifier).signInAnonymously();
                                  //Navigator.pushNamed(context,"/home");
                                },
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            context.go("/register");
                            //Navigator.pushNamed(context,"/register");
                          },
                          child: Text(
                            "Dont have an account? Sign up!",
                            style: TextStyle(color:Colors.blueAccent),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context,"/home");
                          },
                          child: Text(
                            "Mivel én vagyok a fejlesztő megtehetem hogy iderakok egy gombot amivel tovább tudok menni",
                            style: TextStyle(color:Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //color: Colors.white,
                )
            ),

          ],
        ),
                  ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passwordController,
            ),
            TextButton(
                onPressed: (){
                  ref.watch(authControllerProvider.notifier).singInViaEmailAndPassword(emailController.text, passwordController.text);
                  Navigator.pushNamed(context,"/home");
                },
                child: Text("login")
            ),
            TextButton(
                onPressed: (){
                  ref.watch(authControllerProvider.notifier).createUserWithEmailAndPassword(emailController.text, passwordController.text);
                  Navigator.pushNamed(context,"/home");
                },
                child: Text("register")
            ),
            TextButton(
              onPressed: (){
                ref.watch(authControllerProvider.notifier).signInAnonymously();
                Navigator.pushNamed(context,"/home");
              },
              child: Text("continue anonymously"),
            ),
            authControllerState!=null
                ? Text("be vagyok jelentkezve")
                :Text("ki vagyok jelentkezve")
          ]
      ),
    );
  }

}