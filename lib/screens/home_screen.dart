import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao Scambly'),
        elevation: 0,
        actions: [
          IconButton(
            icon: CircleAvatar(
              child: Icon(Icons.person, color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(24),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildGridItem(context, 'Chat', '/chat', Icons.chat_bubble_outline),
          _buildGridItem(
              context, 'Sala de Aula', '/classroom', Icons.school_outlined),
          _buildGridItem(context, 'Tutores', '/tutors', Icons.people_outline),
          _buildGridItem(
              context, 'Loja', '/shop', Icons.shopping_cart_outlined),
          _buildGridItem(context, 'Suporte', '/support', Icons.help_outline),
          _buildGridItem(
              context, 'Agendar', '/schedule', Icons.calendar_today_outlined),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String title, String route, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // Atualizado para titleMedium
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
