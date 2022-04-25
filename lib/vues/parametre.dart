import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'objects.dart';
import '../main.dart';
import 'taches.dart';
import 'accueil.dart';

class Parametre extends StatefulWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {

  final _formKey = GlobalKey<FormState>();

  var _nomController = TextEditingController();
  var _prenomController = TextEditingController();
  var _telephoneController = TextEditingController();
  var _pseudoController = TextEditingController();
  var _passwordController = TextEditingController();

  String _nom = "Nom";
  String _prenom= "prenom";
  String _telephone= "Téléphone";
  String _pseudo= "Pseudo";
  String _password= "Password";

  void modifierUser() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("nom", _nomController.text);
    prefs.setString("prenom", _prenomController.text);
    prefs.setString("telephone", _telephoneController.text);
    prefs.setString("pseudo", _pseudoController.text);
    prefs.setString("password", _passwordController.text);
  }

  void start() async{
    final prefs = await SharedPreferences.getInstance();
    _nom = prefs.getString("nom") ?? "";
    _prenom= prefs.getString("prenom") ?? "";
    _telephone= prefs.getString("telephone") ?? "";
    _pseudo= prefs.getString("pseudo") ?? "";
    _password=prefs.getString("password") ?? "";

    _nomController.text=_nom;
    _prenomController.text=_prenom;
    _telephoneController.text=_telephone;
    _pseudoController.text=_pseudo;
    _passwordController.text=_password;
  }

  void deconnecte() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("nom", "");
    prefs.setString("prenom", "");
    prefs.setString("telephone", "");
    prefs.setString("pseudo", "");
    prefs.setString("password", "");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Todo List App", style: TextStyle(color: Colors.white),),
      ),

      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 350,
            height: 682,
            child: Drawer(
              child: ListView(
                children: [
                  Container(
                    height: 150,
                    child: DrawerHeader(
                        decoration: BoxDecoration(color: Colors.pink),
                        child: Column(
                          children: [
                            Icon(Icons.person_pin, color: Colors.white,size: 80,),
                            SizedBox(height: 5,),
                            Text(
                              _pseudo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.black12,
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 17, color: Colors.black87),
                              children:<TextSpan>[
                                TextSpan(text: 'Nom : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text:"$_nom"),
                                TextSpan(text: '\n\n'),

                                TextSpan(text: 'Prénom : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text:"$_prenom"),
                                TextSpan(text: '\n\n'),

                                TextSpan(text: 'Téléphone : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text:"$_telephone"),
                                TextSpan(text: '\n\n'),

                                TextSpan(text: 'Mot de passe: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text:"$_password"),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text('Accueil'),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Accueil()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Tâches'),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Taches(id: 1,)));
                    },
                  ),
                  ListTile(
                    title: Text('Paramètres'),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Parametre()));
                    },
                  ),
                  ListTile(
                    title: Text('Déconnexion'),
                    leading: Icon(Icons.logout),
                    onTap: (){
                      deconnecte();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: "Todo List App")));
                    },
                  ),
                  SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stream, color: Colors.pink,size: 15,),
                      SizedBox(width: 10,),
                      Icon(Icons.stream,color: Colors.pink,size: 15,),
                      SizedBox(width: 10,),
                      Icon(Icons.stream,color: Colors.pink,size: 15,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child:Column(
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Icon(Icons.account_circle, size: 60, color: Colors.pink,),
                    SizedBox(height: 40,),
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
                                modifierUser();
                                Fluttertoast.showToast(
                                    msg: "Enrégistrement Réussi !!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Parametre()));
                              }

                            },
                            child: Text("Modifier",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pink,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90, vertical: 12),
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            )
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



