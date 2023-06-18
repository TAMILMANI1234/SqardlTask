import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './Screens/Home.dart';
import './Auth.dart';
import '../Screens/Create_Account.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universities',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
        return LoginScreen();

  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? err_message ='';


  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  Future<void>Login(String email,String password)async{
    try{
      await Auth().Login_function(email: email, password: password);
      Navigator.push( context,MaterialPageRoute(builder: (context) => const Home()));
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg1.jpg"),
              fit: BoxFit.cover),
        ),
        child:  Padding(
          padding:EdgeInsets.all(16.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Indian Universities",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily:'Merriweather_regular'

                  ),
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              Container(
                width: 450,
                height: 350,
                child: Card(
                  child: Column(
                    children: [
                      const  Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 44.0,
                              fontWeight:FontWeight.bold,
                              fontFamily:'Merriweather_regular'
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.text,
                        decoration:const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email,color: Colors.black,)
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      TextField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:const  InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock,color: Colors.black,)
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
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
                              await Login(_email.text, _password.text);
                            },
                            child:const Text("Login",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => Create_Account() ));
                              },
                              child: Text("Don't have account Click here")
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
            ],
          ),

        ),
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
