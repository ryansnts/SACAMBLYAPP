import 'package:flutter/material.dart';

class ClassroomScreen extends StatefulWidget {
  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  bool _isChatOpen = false;
  bool _isCameraOn = true;
  bool _isMicOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sala de Aula'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.black87,
                  child: Center(
                    child: Text(
                      'Vídeo ao vivo aqui',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                          _isCameraOn ? Icons.videocam : Icons.videocam_off),
                      onPressed: () {
                        setState(() {
                          _isCameraOn = !_isCameraOn;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(_isMicOn ? Icons.mic : Icons.mic_off),
                      onPressed: () {
                        setState(() {
                          _isMicOn = !_isMicOn;
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text('Sair'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .red, // Substituí `primary` por `backgroundColor`
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          _isChatOpen ? Icons.chat : Icons.chat_bubble_outline),
                      onPressed: () {
                        setState(() {
                          _isChatOpen = !_isChatOpen;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isChatOpen)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text('Tutor'),
                            subtitle: Text('Olá! Como posso ajudar?'),
                          ),
                          ListTile(
                            title: Text('Você'),
                            subtitle: Text('Tenho uma dúvida sobre...'),
                            trailing: Icon(Icons.person),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Digite sua mensagem...',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              // Implementar envio de mensagem
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
