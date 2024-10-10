import 'package:flutter/material.dart';
import 'package:mypills3/widget/app_bar.dart';

class AddMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/calendar2.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20, width: 80),
                Text(
                  "Ajouter vos médicaments pour recevoir des rappels",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          SizedBox(
            width: 250, // Ajuster la largeur du bouton
            child: ElevatedButton(
              onPressed: () {
                // Action pour le bouton
              },
              child: Text("Ajouter un Médicament"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(25, 110, 176, 1), // Couleur de fond
                foregroundColor: Colors.white, // Couleur du texte
                padding: EdgeInsets.symmetric(vertical: 15), // Padding vertical
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Bordures arrondies
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Action pour déconnexion
            },
            child: Text(
              "Déconnexion",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
