import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suporte'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Contato'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Email: suporte@scambly.com'),
          ),
          _buildSectionTitle('Perguntas Frequentes'),
          _buildFAQItem(
              'Como funciona o Scambly?', 'O Scambly é uma plataforma...'),
          _buildFAQItem(
              'Como agendar uma aula?', 'Para agendar uma aula, vá para...'),
          _buildSectionTitle('Suporte com Tutores'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
                'Se você tiver dúvidas específicas com um tutor, recomendamos entrar em contato diretamente pelo chat.'),
          ),
          ElevatedButton(
            child: Text('Ir para o Chat'),
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
          _buildSectionTitle('Canal de Denúncia'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
                'Se você presenciou comportamento inadequado ou tem uma reclamação séria, por favor, use nosso canal de denúncia.'),
          ),
          ElevatedButton(
            child: Text('Fazer uma Denúncia'),
            onPressed: () {
              _showReportDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.red, // Substituímos `primary` por `backgroundColor`
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(answer),
        ),
      ],
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fazer uma Denúncia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Descreva o problema'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Enviar Denúncia'),
                onPressed: () {
                  // Implementar lógica de envio de denúncia
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Denúncia enviada. Obrigado pelo seu feedback.')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
