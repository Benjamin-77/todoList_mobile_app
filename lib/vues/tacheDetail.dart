import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist_app/modele/tache.dart';
import 'package:todolist_app/services/dbService.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'objects.dart';
import '../main.dart';
import 'accueil.dart';
import 'parametre.dart';
import 'taches.dart';



class TacheDetail extends StatefulWidget {
  const TacheDetail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<TacheDetail> createState() => _TacheDetailState();
}

class _TacheDetailState extends State<TacheDetail> {
  String dy1='';
  String dm1='';
  String dd1='';
  String dy2='';
  String dm2='';
  String dd2='';

  final _formKey = GlobalKey<FormState>();

  var _nomController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _date1 = TextEditingController();
  var _date2 = TextEditingController();
  String _debutController = "";
  String _finController = "";
  String _prioriteController = "Prioritaire";
  String _statutController = "En cour";

  Tache tache = Tache();

  void updateTache() async{
    tache.setNom(_nomController.text);
    tache.setDescription(_descriptionController.text);
    tache.setDebut(_debutController);
    tache.setFin(_finController);
    tache.setPriorite( _prioriteController);
    tache.setStatut( _statutController);


    tache = await DB.updateTache(tache);
  }

  void deleteTache(Tache tache) async{
    final data = DB.deleteTache(tache);
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

    tache.setId(widget.id);
    tache = await DB.getTache(tache);

    setState(() {
      _nomController.text = tache.getNom();
      _descriptionController.text = tache.getDescription();
      _debutController = tache.getDebut();
      _date1.text = tache.getDebut();
      _finController = tache.getFin();
      _prioriteController = tache.getPriorite();
      _statutController = tache.getStatut();

      dy1 = tache.getDebut().substring(1,4);
      dm1 = tache.getDebut().substring(6,7);
      dd1 = tache.getDebut().substring(9,10);
      dy2 = tache.getFin().substring(1,4);
      dm2 = tache.getFin().substring(6,7);
      dd2 = tache.getFin().substring(9,10);
    });
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          updateTache();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TacheDetail(id: widget.id)));
        },
        label: const Text(
          'Modifier',
        ),
        icon: const Icon(
          Icons.update_outlined,
          size: 40,
        ),
        backgroundColor: Colors.pink,
        extendedPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 70,),
                  Icon(Icons.android, size: 100, color: Colors.pink,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){
                          deleteTache(tache);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Accueil()));
                          Fluttertoast.showToast(
                              msg: "Tâche supprimé avec succès",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM);
                        },
                        icon: Icon(Icons.delete_forever_rounded),
                        iconSize: 40,
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFieldM("Nom de la tâche", "", false,
                            _nomController, TextInputType.name),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date de bébut",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              DateTimePicker(
                                dateHintText: tache.getDebut(),
                                //initialDate: DateTime(int.parse(dy1),int.parse(dm1),int.parse(dd1)),
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
                                  "Date de fin",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                DateTimePicker(
                                  dateHintText: tache.getFin(),
                                  //initialDate: DateTime(int.parse(dy2),int.parse(dm2),int.parse(dd2)),
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
                                  'Prioirité de la tache',
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
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Statut',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _statutController,
                                hint: Text(
                                  'Statut de la tache',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _statutController = newValue!;
                                  });
                                },
                                items: <String>['En cour', 'Terminé']
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
                        buildTextFieldM("Description", "", false,
                            _descriptionController, TextInputType.text, maxLines: 100,minLines: 5,textAlign: TextAlign.justify),

                        SizedBox(
                          height: 40,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
