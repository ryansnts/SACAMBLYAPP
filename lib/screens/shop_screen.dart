import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  final List items = [
    ShopItem(hours: 1, points: 100),
    ShopItem(hours: 2, points: 200),
    ShopItem(hours: 3, points: 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja de S-Coins'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.access_time,
                  color: Theme.of(context).primaryColor),
              title: Text(
                  '${items[index].hours} ${items[index].hours == 1 ? 'hora' : 'horas'}'),
              subtitle: Text('${items[index].points} S-Coins'),
              trailing: ElevatedButton(
                child: Text('Comprar'),
                onPressed: () {
                  _showPurchaseDialog(context, items[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, ShopItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Compra'),
          content: Text(
              'Deseja comprar ${item.hours} ${item.hours == 1 ? 'hora' : 'horas'} por ${item.points} S-Coins?'),
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
                // Implement purchase logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Compra realizada com sucesso!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class ShopItem {
  final int hours;
  final int points;

  ShopItem({required this.hours, required this.points});
}
