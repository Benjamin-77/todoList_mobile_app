import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'objects.dart';
import '../main.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();

  var _nomController = TextEditingController();
  var _prenomController = TextEditingController();
  var _telephoneController = TextEditingController();
  var _pseudoController = TextEditingController();
  var _passwordController = TextEditingController();

  void newUser() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("nom", _nomController.text);
    prefs.setString("prenom", _prenomController.text);
    prefs.setString("telephone", _telephoneController.text);
    prefs.setString("pseudo", _pseudoController.text);
    prefs.setString("password", _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Todo List App", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text("Inscription",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.pink),),
                  SizedBox(height: 50,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField("Nom", "", false,
                            _nomController, TextInputType.name),
                        buildTextField("Prénom", "", false,
                            _prenomController, TextInputType.name),
                        buildTextField("Téléphone", "", false,
                            _telephoneController, TextInputType.phone),
                        buildTextField("Pseudo", "", false,
                            _pseudoController, TextInputType.name),
                        buildTextField("Mot de passe", "", false,
                            _passwordController, TextInputType.visiblePassword),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              newUser();
                              Fluttertoast.showToast(
                                  msg: "Enrégistrement Réussi !!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Confirmation()));
                            }

                          },
                          child: Text("S'inscrire",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
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
                            Text("J'ai déjà un compte !  "),
                            TextButton(onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePage(title: "Todo List App")));
                            },
                              child: Text("Se connecter"),
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
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo List App", style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 130,),
                    Text("Vous avez été enrégistrer avec succès !!",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black87),),
                    SizedBox(height: 20,),
                    Image(image: AssetImage("assets/images/confirmation.jpg")),
                    SizedBox(height: 20,),
                    Text("Veillez vous connecter",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black87),),
                    SizedBox(height: 50,),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(title: 'Todo List App')));
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
                              horizontal: 10, vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              )
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

