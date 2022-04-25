import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist_app/modele/tache.dart';
import 'package:todolist_app/services/dbService.dart';
import 'package:todolist_app/vues/tacheDetail.dart';
import '../main.dart';
import 'accueil.dart';
import 'parametre.dart';



class Taches extends StatefulWidget {
  const Taches({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<Taches> createState() => _TachesState();
}

class _TachesState extends State<Taches> {

  List<Tache> taches = [];

  String _nom = "Nom";
  String _prenom= "prenom";
  String _telephone= "Téléphone";
  String _pseudo= "Pseudo";
  String _password= "Password";

  void initTachesList() async{
    final data = await DB.getTaches(widget.id);
    taches=data;
  }
  void start() async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nom = prefs.getString("nom") ?? "";
      _prenom= prefs.getString("prenom") ?? "";
      _telephone= prefs.getString("telephone") ?? "";
      _pseudo= prefs.getString("pseudo") ?? "";
      _password=prefs.getString("password") ?? "";

      initTachesList();
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

  void deleteTache(Tache tache) async{
    final data = DB.deleteTache(tache);
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

      body: taches.isNotEmpty
          ? ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: taches.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shadowColor:
                    MaterialStateProperty.all<Color>(Colors.white24),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TacheDetail(
                              id: taches[index].getId(),
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.task,
                            size: 40,
                            color: Colors.pink,
                          )
                        ),
                        title: Text(
                          taches[index].getNom(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text("deadline : "+taches[index].getFin()),
                        trailing: IconButton(
                          onPressed: (){
                            deleteTache(taches[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taches(id: 1,)));
                            Fluttertoast.showToast(
                                msg: "Tâche supprimé avec succès",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          },
                          icon: Icon(Icons.delete_forever_rounded),
                          iconSize: 40,
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }):Center(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/aucun.jpg")),
            SizedBox(height: 20,),
            Text("Aucune tâche trouvé",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 23),),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
