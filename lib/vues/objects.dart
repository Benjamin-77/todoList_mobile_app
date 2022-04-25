import 'package:flutter/material.dart';
import 'package:todolist_app/modele/tache.dart';
import 'taches.dart';
import 'package:date_time_picker/date_time_picker.dart';

Widget buildTextField(String labelText, String placeholder,
    bool isPasswordTextField, var controller, var keyboardType,
    {int minLines = 1, int maxLines = 1, var textAlign = TextAlign.start}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: TextFormField(
      keyboardType: keyboardType,
      autocorrect: true,
      controller: controller,
      obscureText: isPasswordTextField ? true : false,
      minLines: minLines,
      maxLines: maxLines,
      textAlign: TextAlign.justify,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.grey,
            ))
            : null,
        contentPadding: EdgeInsets.all(15),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      validator: (String? value) {
        return (value == null || value == "")
            ? "Ce champ est obligatoire"
            : null;
      },
    ),
  );
}

Widget buildTextFieldM(String labelText, String placeholder,
    bool isPasswordTextField, var controller, var keyboardType,
    {int minLines = 1, int maxLines = 1, var textAlign = TextAlign.start}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: TextFormField(
      keyboardType: keyboardType,
      autocorrect: true,
      controller: controller,
      obscureText: isPasswordTextField ? true : false,
      minLines: minLines,
      maxLines: maxLines,
      textAlign: TextAlign.justify,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.grey,
            ))
            : null,
        contentPadding: EdgeInsets.all(15),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        disabledBorder: InputBorder.none,
      ),
      validator: (String? value) {
        return (value == null || value == "")
            ? "Ce champ est obligatoire"
            : null;
      },
    ),
  );
}


Widget buildTaskStatistique(BuildContext context,int page,String text, int nombre,IconData myIcon) {
  return Container(
    width: 200,
    child: ElevatedButton(
      onPressed: () async {
        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Taches(id: page,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, textAlign: TextAlign.center,style: TextStyle(color: Colors.black87, fontSize: 16),),
          Icon(myIcon,color: Colors.pink,size: 60,),
          Text("$nombre", style: TextStyle(color: Colors.black),),
        ],
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
          textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87)),
    ),
  );
}



Widget buildDatePicker(String initialDate,TextEditingController _dateController, ) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: DateTimePicker(
      initialValue: '',
      // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
      type: DateTimePickerType.date,
      dateLabelText: 'Select Date',
      firstDate: DateTime(1995),
      lastDate: DateTime.now()
          .add(Duration(days: 365)),
      // This will add one year from current date
      controller: _dateController,
    ),
  );
}