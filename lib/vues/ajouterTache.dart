import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist_app/services/dbService.dart';
import 'package:todolist_app/vues/accueil.dart';
import 'objects.dart';
import '../main.dart';
import 'accueil.dart';
import 'parametre.dart';
import 'taches.dart';
import '../modele/tache.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AjouterTache extends StatefulWidget {
  const AjouterTache({Key? key}) : super(key: key);

  @override
  State<AjouterTache> createState() => _AjouterTacheState();
}

class _AjouterTacheState extends State<AjouterTache> {
  String _selectedDate="";

  final _formKey = GlobalKey<FormState>();

  var _nomController = TextEditingController();
  var _descriptionController = TextEditingController();
  String _debutController = "";
  String _finController = "";
  String _prioriteController = "Prioritaire";

  String titre="Nouvelle tâche";
  Tache tache = Tache();

  void ajouterTache() async{
    tache.setNom(_nomController.text);
    tache.setDescription(_descriptionController.text);
    tache.setDebut(_debutController);
    tache.setFin(_finController);
    tache.setPriorite( _prioriteController);

    tache = await DB.createTache(tache);
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
                    SizedBox(height: 50,),
                    Text(titre,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.pink),),
                    SizedBox(height: 50,),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextField("Nom de la tâche", "", false,
                              _nomController, TextInputType.name),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date de début',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                DateTimePicker(
                                  initialValue: '',
                                  // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
                                  type: DateTimePickerType.date,
                                  firstDate: DateTime(1995),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 365)),
                                  // This will add one year from current date
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        _debutController = value;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date de fin',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                DateTimePicker(
                                  initialValue: '',
                                  // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
                                  type: DateTimePickerType.date,
                                  firstDate: DateTime(1995),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 365)),
                                  // This will add one year from current date
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        _finController = value;
                                      });
                                    }
                                  },
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Priorité',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  value: _prioriteController,
                                  hint: Text(
                                    'Sélectionner votre genre',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _prioriteController = newValue!;
                                    });
                                  },
                                  items: <String>['Prioritaire', 'Non Prioritaire']
                                      .map((String values) {
                                    return new DropdownMenuItem<String>(
                                      value: values,
                                      child: new Text(values),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          buildTextField("Description", "", false,
                              _descriptionController, TextInputType.text, maxLines: 10,minLines: 3,textAlign: TextAlign.justify),


                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ajouterTache();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Accueil()));
                              Fluttertoast.showToast(
                                  msg: "Tâche ajouter avec succès",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }},
                            child: Text("Ajouter la tâche",
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
