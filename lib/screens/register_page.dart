import 'package:flutter/material.dart';
import 'package:mypills3/models/user.dart';
import 'package:mypills3/repositories/user_repository.dart';
import 'package:mypills3/screens/home_page.dart';
import 'package:mypills3/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmObscured = true;

  String? _username;
  String? _email;
  String? _password;
  String? _confirm;

  void _submit() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    await UserRepository().create(User(username : _username!, email: _email!, password: _password!));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomePage()),
    );
    /* ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mot de passe: ${_username}')),
    ); */
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
              'Bonjour, veuillez vous inscrire pour continuer', 
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
                    decoration: const InputDecoration(
                      labelText: 'Identifiant',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _username = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un identifiant';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10)
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un email';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10)
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordObscured,
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
                      labelText: 'Mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured ? Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured; 
                          });
                        }
                      )
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10)
                  ),
                  TextFormField(
                    obscureText: _isConfirmObscured,
                    onSaved: (value) {
                      _confirm = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une conformation de mot de passe ';
                      }
                      if(value != _passwordController.text) {
                        return 'La confirmation doit etre similaire au mot de passe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirmer mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmObscured ? Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmObscured = !_isConfirmObscured; 
                          });
                        }
                      )
                    ),
                  ),
                ],
              )
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
                  'Inscription', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous avez déja un compte ? ", 
                  style: TextStyle(
                    fontSize: 15.0, 
                    fontFamily: 'Roboto'
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Connexion", 
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