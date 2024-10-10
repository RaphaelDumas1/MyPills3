import 'package:flutter/material.dart';
import 'package:mypills3/repositories/user_repository.dart';
import 'package:mypills3/screens/home_page.dart';
import 'package:mypills3/screens/register_page.dart';
import 'package:mypills3/services/database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  String? _username;
  String? _password;

  void _submit() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    var user = await UserRepository().findByUsername(_username!);

    if(user?.salt != null && user?.password == DatabaseHelper().hashPassword(_password!, user!.salt!)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const HomePage()),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mot de passe ou identifiant incorrect'))
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40)
            ),
            const Text(
              'Bonjour, heureux de vous revoir', 
              style: TextStyle(
                fontSize: 30.0, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40)
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      _username = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un identifiant';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Entrez votre email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10)
                  ),
                  TextFormField(
                    obscureText: _isObscured,
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Entrez votre mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured; 
                          });
                        }
                      )
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Mot de passe oublié ?',
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40)
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submit,
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
                ]
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous n'avez pas de compte ? ", 
                  style: TextStyle(
                    fontSize: 15.0, 
                    fontFamily: 'Roboto'
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const RegisterPage()),
                  );
                  },
                  child: const Text(
                    "Inscription", 
                    style: TextStyle(
                      fontSize: 15.0, 
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}