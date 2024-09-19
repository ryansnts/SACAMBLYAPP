import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Lista de idiomas disponíveis
  List<String> languages = [
    'Inglês',
    'Espanhol',
    'Francês',
    'Alemão',
    'Italiano',
    'Português',
    'Mandarim',
    'Japonês'
  ];

  // Idiomas selecionados
  Map<String, String> selectedLanguages = {};

  // Língua nativa e idioma que deseja aprender
  String? nativeLanguage;
  String? languageToLearn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecione os Idiomas')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qual é a sua língua nativa?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: nativeLanguage,
              hint: Text('Selecione sua língua nativa'),
              items: languages.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  nativeLanguage = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Quais idiomas você domina?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: languages.map((language) {
                return FilterChip(
                  label: Text(language),
                  selected: selectedLanguages.containsKey(language),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedLanguages[language] =
                            'Intermediário'; // Define o nível padrão
                      } else {
                        selectedLanguages.remove(language);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (selectedLanguages.isNotEmpty)
              Text(
                'Selecione o nível para cada idioma:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            // Listando os idiomas selecionados para escolher o nível
            ...selectedLanguages.keys.map((language) {
              return ListTile(
                title: Text(language),
                trailing: DropdownButton<String>(
                  value: selectedLanguages[language],
                  items: ['Básico', 'Intermediário', 'Avançado', 'Fluente']
                      .map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguages[language] = newValue!;
                    });
                  },
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Qual idioma você quer aprender?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: languageToLearn,
              hint: Text('Selecione o idioma que quer aprender'),
              items: languages
                  .where((lang) =>
                      lang != nativeLanguage &&
                      !selectedLanguages.containsKey(lang))
                  .map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  languageToLearn = newValue;
                });
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                child: Text('Continuar'),
                onPressed: () {
                  if (nativeLanguage != null &&
                      selectedLanguages.isNotEmpty &&
                      languageToLearn != null) {
                    // Navega para a próxima tela e passa os dados selecionados
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: {
                        'nativeLanguage': nativeLanguage,
                        'knownLanguages': selectedLanguages,
                        'languageToLearn': languageToLearn,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Por favor, preencha todas as informações')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
