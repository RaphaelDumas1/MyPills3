import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypills3/widgets/input_time.dart';


class AddTreatmentPage extends StatefulWidget {
  const AddTreatmentPage({Key? key}) : super(key: key); // Ajout du const ici

  @override
  _AddTreatmentPageState createState() => _AddTreatmentPageState();
}

class _AddTreatmentPageState extends State<AddTreatmentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  DateTime? _selectedDate;
  String? _formattedDate;

  // Controllers pour surveiller les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();

  bool _isButtonEnabled = false;
  bool _isNotificationEnabled =
      false; // Variable d'état pour le bouton notification

  @override
  void initState() {
    super.initState();

    // Ajouter des écouteurs sur les controllers pour chaque champ
    _nomController.addListener(_checkIfFormIsFilled);
    _doseController.addListener(_checkIfFormIsFilled);
    _nombreController.addListener(_checkIfFormIsFilled);
  }

  void _checkIfFormIsFilled() {
    // Activer ou désactiver le bouton selon si les champs sont remplis
    setState(() {
      _isButtonEnabled = _nomController.text.isNotEmpty &&
          _doseController.text.isNotEmpty &&
          _nombreController.text.isNotEmpty;
    });
  }

  void _toggleNotification(bool value) {
    // Activer ou désactiver graphiquement le bouton de notification
    setState(() {
      _isNotificationEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un \n médicament',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 22,
                fontWeight: FontWeight.bold)), // Marqué const ici
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Marqué const ici
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                // Const ici
                'Remplir les champs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20), // Const ici
              // Nom du médicament
              TextFormField(
                controller: _nomController, // Ajout du controller
                decoration: const InputDecoration(
                  // Const ici
                  labelText: 'Nom',
                  hintText: 'Nom (ex. Ibuprofen)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du médicament';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Const ici
              // Type de médicament
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  // Const ici
                  labelText: 'Sélectionner',
                  hintText: 'Sélectionner une option',
                  border: OutlineInputBorder(),
                ),
                value: _selectedType,
                items: ['gellule', 'comprimé']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                    _checkIfFormIsFilled(); // Vérifier après chaque changement
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Const ici
              // Dose
              TextFormField(
                controller: _doseController, // Ajout du controller
                decoration: const InputDecoration(
                  // Const ici
                  labelText: 'Dose',
                  hintText: 'Dose (ex. 100mg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la dose';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Const ici
              // Nombre
              TextFormField(
                controller: _nombreController, // Ajout du controller
                decoration: const InputDecoration(
                  // Const ici
                  labelText: 'Nombres',
                  hintText: 'Nombres (ex. 3)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Const ici
              // Rappels - Date
              TextFormField(
                decoration: InputDecoration(
                  // Retrait de const ici pour supporter _formattedDate
                  labelText: 'Date de fin',
                  hintText: _formattedDate ??
                      'JJ/MM/AAAA, 00:00', // Utilise _formattedDate
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                      _formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 20), // Const ici
              // Rappels - Notification
              SwitchListTile(
                title: const Text('Notification'), // Const ici
                value: _isNotificationEnabled,
                onChanged:
                    _toggleNotification, // Appelle la méthode pour activer/désactiver le switch
              ),
              const SizedBox(height: 20), // Const ici
              // Bouton Sauvegarder
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ReminderWidget(), // Navigue vers la page de rappels
                    ),
                  );
                },
                child: Text('Ajouter un rappel'),
              ),

              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          // Sauvegarder les informations
                        }
                      }
                    : null, // Bouton désactivé si _isButtonEnabled est false

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Sauvegarder'), // Const ici
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Nettoyer les controllers pour éviter les fuites de mémoire
    _nomController.dispose();
    _doseController.dispose();
    _nombreController.dispose();
    super.dispose();
  }
}
