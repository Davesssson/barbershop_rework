import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    late TextEditingController emailController = TextEditingController();
    late TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
          children: [
            //if (authControllerState==null)...[
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

          // ]else ...[
          //   Text("beszoptad")
          //   // ItemList(),
          // ]
          ]
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => AddItemDialog.show(context, Item.empty()),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

}