import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Contato {
  final String nome;
  final String email;
  final String imageUrl;
  bool isFavorite;

  Contato({
    required this.nome, 
    required this.email, 
    required this.imageUrl, 
    this.isFavorite = false}
  );
}

class ContatoItem extends StatefulWidget {
  final Contato contato;
  final VoidCallback onFavoriteChanged;

  ContatoItem({required this.contato, required this.onFavoriteChanged});

  @override
  _ContatoItemState createState() => _ContatoItemState();
}

class _ContatoItemState extends State<ContatoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: 
          NetworkImage(widget.contato.imageUrl)
      ),
      title: Text(widget.contato.nome),
      subtitle: Text(widget.contato.email),
      trailing: IconButton(
        icon: Icon(
          widget.contato.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            widget.contato.isFavorite = !widget.contato.isFavorite;
            widget.onFavoriteChanged();
          });
        },
      ),
    );
  }
}

class ContatoList extends StatefulWidget {
  @override
  _ContatoListState createState() => _ContatoListState();
}

class _ContatoListState extends State<ContatoList> {
  List<Contato> contatos = [
    Contato(
        nome: 'Kaique Ricardo Almeida',
        email: 'kaiquericardoalmeida@gmail.com',
        imageUrl: 'https://i.pravatar.cc/150?img=3',
        isFavorite: false),
    Contato(
        nome: 'Arthur Samuel Filipe da Cruz',
        email: 'arthur_dacruz@foxtech.com.br',
        imageUrl: 'https://i.pravatar.cc/150?img=4',
        isFavorite: false),
    Contato(
        nome: 'Jaqueline Rita Betina Moreira',
        email: 'jaqueline-moreira84@morada.com.br',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        isFavorite: false),
    Contato(
        nome: 'Isadora Daiane Patrícia Melo',
        email: 'isadora-melo80@attglobal.net',
        imageUrl: 'https://i.pravatar.cc/150?img=9',
        isFavorite: false),
    Contato(
        nome: 'Igor Carlos Breno Peixoto',
        email: 'igorcarlospeixoto@academiahct.com.br',
        imageUrl: 'https://i.pravatar.cc/150?img=8',
        isFavorite: false),
  ];

  int numFavorites = 0;

  void _updateFavorites() {
    int count = 0;
    for (Contato contato in contatos) {
      if (contato.isFavorite) {
        count++;
      }
    }
    setState(() {
      numFavorites = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos Favoritos ($numFavorites)'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (BuildContext context, int index) {
          return ContatoItem(
            contato: contatos[index],
            onFavoriteChanged: _updateFavorites,
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContatoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}