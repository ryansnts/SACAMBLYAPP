import 'package:flutter/material.dart';

class TutorsScreen extends StatefulWidget {
  @override
  _TutorsScreenState createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {
  List<Tutor> tutors = [
    Tutor('João Silva', ['Português', 'Inglês'], 4.5,
        'Especialista em conversação'),
    Tutor('Maria Santos', ['Francês', 'Alemão'], 4.8,
        'Foco em gramática e escrita'),
    Tutor('Carlos Oliveira', ['Espanhol', 'Italiano'], 4.2,
        'Aulas dinâmicas e interativas'),
    Tutor('Ana Rodrigues', ['Inglês', 'Japonês'], 4.7,
        'Preparação para exames internacionais'),
  ];

  List<Tutor> filteredTutors = [];
  Set<String> favoriteTutors = {};

  @override
  void initState() {
    super.initState();
    filteredTutors = tutors;
  }

  void _filterTutors(String query) {
    setState(() {
      filteredTutors = tutors
          .where((tutor) =>
              tutor.name.toLowerCase().contains(query.toLowerCase()) ||
              tutor.languages.any(
                  (lang) => lang.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutores Disponíveis'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterTutors,
              decoration: InputDecoration(
                hintText: 'Buscar por nome ou idioma',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredTutors.length,
              itemBuilder: (context, index) {
                return _buildTutorCard(filteredTutors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(Tutor tutor) {
    bool isFavorite = favoriteTutors.contains(tutor.name);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    tutor.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        favoriteTutors.remove(tutor.name);
                      } else {
                        favoriteTutors.add(tutor.name);
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Idiomas: ${tutor.languages.join(", ")}'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text(tutor.rating.toString()),
              ],
            ),
            SizedBox(height: 8),
            Text(
              tutor.description,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 4),
                Text('Disponível', style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton(
              child: Text('Agendar Aula'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/schedule', // Atualizando para navegar até a tela de agendamento
                  arguments: {'tutor': tutor},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .primaryColor, // Substituindo primary por backgroundColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tutor {
  final String name;
  final List<String> languages;
  final double rating;
  final String description;

  Tutor(this.name, this.languages, this.rating, this.description);
}
