import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour formater l'heure


class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rappels de Médicaments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),  // Flèche de retour
          onPressed: () {
            Navigator.pop(context);  // Retourner à la page précédente
          },
        ),
      ),
      body: ReminderWidget(),
    );
  }
}

class ReminderWidget extends StatefulWidget {
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  // Liste pour stocker les heures de rappel
  List<TimeOfDay> reminders = [];

  // Fonction pour afficher le TimePicker et ajouter l'heure sélectionnée
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && !reminders.contains(picked)) {
      setState(() {
        reminders.add(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Liste des rappels existants
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                // Format de l'heure pour un affichage lisible
                final formattedTime = reminders[index].format(context);
                return ListTile(
                  title: Text('Rappel : $formattedTime'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        reminders.removeAt(index); // Supprimer le rappel
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Bouton pour ajouter un nouveau rappel
          ElevatedButton.icon(
            onPressed: () => _selectTime(context), // Appeler la sélection d'heure
            icon: Icon(Icons.add_alarm),
            label: Text('Ajouter un rappel'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Couleur du bouton
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
