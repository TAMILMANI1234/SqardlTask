import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Auth.dart';
class Create_Account extends StatefulWidget {
  const Create_Account({super.key});

  @override
  State<Create_Account> createState() => _Create_AccountState();
}

class _Create_AccountState extends State<Create_Account> {
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  final TextEditingController _confirm_password=TextEditingController();
  String? err_message ='';

  Future<void>CreateAccount(String email,String password)async{
    try{
      await Auth().Create_credential(email: email, password: password);
      err_message="account created successfully";
      showAlert(context,err_message!);
      Timer(
        Duration(seconds: 1),
          ()=>Navigator.pop(context)
      );

    } on FirebaseAuthException catch(err){
      setState(() {
        err_message=err.message;
      });
      showAlert(context,err_message!);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       title: const Text("Create Account"),
        backgroundColor: Colors.blueAccent,
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email,color: Colors.black,)
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: _password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock,color: Colors.black,)
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: _confirm_password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock_clock_sharp,color: Colors.black,)
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            Center(
              child: Container(
                width: 150.0,
                child: RawMaterialButton(
                  fillColor: Colors.blueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding:const EdgeInsets.symmetric(vertical: 15),
                  onPressed: () async{
                      if(_email.text !='' && _password.text != '' && _confirm_password !=''){
                        if(_password.text == _confirm_password.text){
                          await CreateAccount(_email.text, _password.text);
                        }
                        else{
                          err_message="Password and Confirm password must be same";
                          showAlert(context,err_message!);
                        }
                      }
                      else{
                        err_message="Enter required fields";
                        showAlert(context,err_message!);
                      }
                  },
                  child:const Text("Create",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                ),

              ),
            ),
          ],
        )

      )
    );
  }
}
showAlert(BuildContext context, String S){
  AlertDialog alertDialog=AlertDialog(
    title:const Text('Woops!!'),
    content: Text(S),
    actions: [
      ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child:const Text('Ok'))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      });
}
