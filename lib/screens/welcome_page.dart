import 'package:flutter/material.dart';
import 'package:mypills3/screens/login_page.dart';
import 'package:mypills3/screens/register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50)
            ),
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
              fit:  BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30)
            ),
            const Text(
              'MyPills3', 
              style: TextStyle(
                fontSize: 50.0, 
                color: Color(0xFF196EB0),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'
                ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10)
            ),
            const Text(
              'Votre assistant personnel de gestion de prise de médicaments.', 
              style: TextStyle(
                fontSize: 17.0, 
                color: Color.fromARGB(255, 40, 40, 40),
                fontFamily: 'Roboto'
                ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50)
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor : const Color(0xFF196EB0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                child: const Text(
                  'Connexion', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15)
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor : const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 33, 33, 33), // Couleur de la bordure
                    width: 1, // Épaisseur de la bordure
                  ),
                ),
                child: const Text(
                  'Inscription', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 33, 33, 33),
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}