import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State {
  final List _messages = [];
  final TextEditingController _textController = TextEditingController();
  String _currentChatTitle = 'Chat Geral';
  bool _showTeacherMessages = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addMessage(Message('Olá! Como você está?', false));
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.add(message);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _addMessage(Message(text, true));
    // Simular resposta do sistema após 1 segundo
    Future.delayed(Duration(seconds: 1), () {
      _addMessage(
          Message('Isso é muito interessante! Pode me contar mais?', false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentChatTitle),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_showTeacherMessages ? Icons.close : Icons.message),
            onPressed: () {
              setState(() {
                _showTeacherMessages = !_showTeacherMessages;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showTeacherMessages)
            Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mensagens dos Professores',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildTeacherMessageTile(
                            'Prof. João', 'Nova lição disponível!'),
                        _buildTeacherMessageTile(
                            'Prof. Maria', 'Correção do exercício'),
                        _buildTeacherMessageTile(
                            'Prof. Carlos', 'Lembrete: aula amanhã'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherMessageTile(String teacherName, String message) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(teacherName[0]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      title: Text(teacherName),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () {
        setState(() {
          _currentChatTitle = 'Chat com $teacherName';
          _messages.clear();
          _addMessage(Message(
              'Olá! Eu sou o(a) $teacherName. Como posso ajudar?', false));
          _showTeacherMessages = false;
        });
      },
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar uma mensagem',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  Message(this.text, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Text(
              text,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
