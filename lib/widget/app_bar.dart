import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.calendar_today, color: Colors.red),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.emoji_emotions, color: Colors.yellow),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0), // Hauteur de la bordure
        child: Container(
          color: Colors.grey, // Couleur de la bordure
          height: 1.0, // Épaisseur de la bordure
        ),
      ),
    );
  }

  // Définir la taille préférée de l'AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1); 
}
