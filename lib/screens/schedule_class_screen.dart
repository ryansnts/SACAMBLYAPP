import 'package:flutter/material.dart';

class ScheduleClassScreen extends StatefulWidget {
  @override
  _ScheduleClassScreenState createState() => _ScheduleClassScreenState();
}

class _ScheduleClassScreenState extends State<ScheduleClassScreen> {
  final List<Tutor> tutors = [
    Tutor('João Silva', ['Inglês', 'Espanhol'], 4.5),
    Tutor('Maria Santos', ['Francês', 'Alemão'], 4.8),
    Tutor('Carlos Oliveira', ['Italiano', 'Português'], 4.2),
  ];

  Tutor? selectedTutor;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Aula'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecione um Tutor:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButton<Tutor>(
                isExpanded: true,
                value: selectedTutor,
                hint: Text('Escolha um tutor'),
                items: tutors.map((Tutor tutor) {
                  return DropdownMenuItem(
                    value: tutor,
                    child:
                        Text('${tutor.name} (${tutor.languages.join(", ")})'),
                  );
                }).toList(),
                onChanged: (Tutor? newValue) {
                  setState(() {
                    selectedTutor = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Selecione uma Data:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(selectedDate == null
                    ? 'Escolher Data'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                'Selecione um Horário:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(selectedTime == null
                    ? 'Escolher Horário'
                    : '${selectedTime!.format(context)}'),
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null && picked != selectedTime) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Confirmar Agendamento'),
                onPressed: () {
                  if (selectedTutor != null &&
                      selectedDate != null &&
                      selectedTime != null) {
                    _showConfirmationDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Por favor, preencha todas as informações'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Agendamento'),
          content: Text(
              'Você deseja agendar uma aula com ${selectedTutor!.name} no dia ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} às ${selectedTime!.format(context)}?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Aula agendada com sucesso!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class Tutor {
  final String name;
  final List<String> languages;
  final double rating;

  Tutor(this.name, this.languages, this.rating);
}
