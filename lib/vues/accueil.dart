import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist_app/vues/ajouterTache.dart';
import 'objects.dart';
import '../main.dart';
import 'ajouterTache.dart';
import 'taches.dart';
import 'parametre.dart';
import '../services/dbService.dart';
import '../modele/tache.dart';


class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  int tt=0;
  List<Tache> taches1 = [];

  int te=0;
  List<Tache> taches2 = [];

  int tr=0;
  List<Tache> taches3 = [];

  int tpr=0;
  List<Tache> taches4 = [];

  int tnpr=0;
  List<Tache> taches5 = [];

  void getNumbers() async{
    final data1 = await DB.getTaches(1);
    taches1=data1;
    setState(() {
      tt = taches1.length;
    });

    final data2 = await DB.getTaches(2);
    taches2=data2;
    setState(() {
      te = taches2.length;
    });

    final data3 = await DB.getTaches(3);
    taches3=data3;
    setState(() {
      tr = taches3.length;
    });

    final data4 = await DB.getTaches(4);
    taches4=data4;
    setState(() {
      tpr = taches4.length;
    });

    final data5 = await DB.getTaches(5);
    taches5=data5;
    setState(() {
      tnpr = taches5.length;
    });
  }

  String _nom = "Nom";
  String _prenom= "prenom";
  String _telephone= "Téléphone";
  String _pseudo= "Pseudo";
  String _password= "Password";

  void start() async{
    final prefs = await SharedPreferences.getInstance();
    _nom = prefs.getString("nom") ?? "";
    _prenom= prefs.getString("prenom") ?? "";
    _telephone= prefs.getString("telephone") ?? "";
    _pseudo= prefs.getString("pseudo") ?? "";
    _password=prefs.getString("password") ?? "";

    getNumbers();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AjouterTache()));
        },
        label: const Text(
          'Ajouter une nouvelle tâche',
        ),
        icon: const Icon(
          Icons.add_circle_outline_rounded,
          size: 40,
        ),
        backgroundColor: Colors.pink,
        extendedPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
      ),

      body: SingleChildScrollView(
        child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTaskStatistique(context,1,"Toutes les tâches", tt,Icons.all_inbox),
                    ],
                  ),
                  SizedBox(height: 50,),
                  buildTaskStatistique(context,2,"Tâches effectués", te,Icons.paste_sharp),
                  SizedBox(height: 50,),
                  buildTaskStatistique(context,3,"Tâches restantes", tr,Icons.reset_tv),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTaskStatistique(context,2,"Tâches effectués", te,Icons.paste_sharp),
                      buildTaskStatistique(context,3,"Tâches restantes", tr,Icons.reset_tv),
                    ],
                  ),*/
                  SizedBox(height: 50,),
                  buildTaskStatistique(context,4,"Tâches prioritaires restantes", tpr,Icons.important_devices),
                  SizedBox(height: 50,),
                  buildTaskStatistique(context,5,"Tâches non prioritaires restantes", tnpr,Icons.low_priority),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTaskStatistique(context,4,"Tâches prioritaires restantes", tpr,Icons.important_devices),
                      buildTaskStatistique(context,5,"Tâches non prioritaires restantes", tnpr,Icons.low_priority),
                    ],
                  ),*/
                  SizedBox(height: 100,),
                ],
              ),
            )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
