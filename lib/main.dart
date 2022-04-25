import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'vues/objects.dart';
import 'vues/inscription.dart';
import 'vues/accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Todo List App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  bool connecte = false;
  bool error = false;

  var _pseudoController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<bool> authentification() async {
    final prefs = await SharedPreferences.getInstance();
    if(_pseudoController.text==prefs.getString("pseudo")! && _passwordController.text==prefs.getString("password")!){
      return true;
    }else{
      return false;
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool error = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),

      body: SingleChildScrollView(
        child: Center(

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text("Connexion",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.pink),),
                  SizedBox(height: 50,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField("Pseudo", "", false,
                            _pseudoController, TextInputType.name),
                        buildTextField("Mot de passe", "", true,
                            _passwordController, TextInputType.visiblePassword),
                        SizedBox(
                          height: 40,
                        ),
                        error ? Text("Identifiants incorrectes !!", style: TextStyle(color: Colors.red),):SizedBox(),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              if(await authentification()){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Accueil()));
                              }else{
                                setState(() {
                                  error=true;
                                });
                              }
                            }


                            /*Fluttertoast.showToast(
                            msg: "Enrégistrement Réussi",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM);*/
                          },
                          child: Text("Se connecter",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pas encore de compte ?"),
                            TextButton(onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Inscription()));
                            },
                              child: Text("S'inscrire"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
