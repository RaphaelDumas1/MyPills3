import 'package:flutter/material.dart';
import 'package:mypills3/screens/add_treatment_form_page.dart';
import 'package:table_calendar/table_calendar.dart'; // Import du package calendrier
import 'package:intl/intl.dart'; // Pour formater les heures et dates

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week; // Format d'affichage du calendrier
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bug_report_outlined, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendrier
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // Mettre à jour le jour sélectionné et le jour focalisé
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Text(
                    'Médicament pris',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.medication_rounded, size: 60, color: Colors.orange),
                        SizedBox(height: 8),
                        Text('0/1', style: TextStyle(fontSize: 36, color: Colors.blue)),
                        SizedBox(height: 8),
                        Text(
                          _selectedDay != null ? DateFormat.EEEE().format(_selectedDay!) : 'Sélectionner un jour',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            _buildMedicineItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddTreatmentPage()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMedicineItem() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.yellow.withOpacity(0.2),
              child: Icon(Icons.medication_rounded, color: Colors.orange),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vitamine D', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('1 Comprimé, 1000mg', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '09:41',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
