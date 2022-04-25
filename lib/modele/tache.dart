class Tache{

  int id=7;
  String nom ="";
  String description ="";
  String priorite ="Prioritaire";
  String statut ="En cour";
  String debut ="";
  String fin ="";

  Tache(){this.id;this.nom;this.description;this.priorite;this.statut;this.debut;this.fin;}


  Tache updateUser(Tache tache) {
    this.nom = tache.getNom();
    this.description = tache.description;
    this.priorite = tache.priorite;
    this.statut = tache.statut;
    this.debut = tache.debut;
    this.fin = tache.fin;

    return this;
  }

  Tache.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nom = json['nom'],
        description = json['description'],
        priorite = json['priorite'],
        statut = json['statut'],
        debut = json['debut'],
        fin = json['fin'];

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'description': description,
    'priorite': priorite,
    'statut': statut,
    'debut': debut,
    'fin': fin,
  };

  void setId(int id){
    this.id=id;
  }
  int getId(){
    return this.id;
  }

  void setNom(String nom){
    this.nom=nom;
  }
  String getNom(){
    return this.nom;
  }

  void setDescription(String description){
    this.description=description;
  }
  String getDescription(){
    return this.description;
  }

  void setPriorite(String priorite){
    this.priorite=priorite;
  }
  String getPriorite(){
    return this.priorite;
  }

  void setStatut(String statut){
    this.statut=statut;
  }
  String getStatut(){
    return this.statut;
  }

  void setDebut(String debut){
    this.debut=debut;
  }
  String getDebut(){
    return this.debut;
  }

  void setFin(String fin){
    this.fin=fin;
  }
  String getFin(){
    return this.fin;
  }


}