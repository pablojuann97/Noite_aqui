// Arquivo main.dart do app Noite Aqui
// Versão com login, abas, mapa, locais e recomendações

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(NoiteAquiApp());

class NoiteAquiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noite Aqui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        primaryColor: Colors.purpleAccent,
        colorScheme: ColorScheme.dark(
          secondary: Colors.pinkAccent,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (email.isNotEmpty && senha.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeTabs(usuario: email)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Noite Aqui', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(labelText: 'E-mail', labelStyle: TextStyle(color: Colors.grey), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _senhaController,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha', labelStyle: TextStyle(color: Colors.grey), border: OutlineInputBorder()),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(primary: Colors.purpleAccent, padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabs extends StatefulWidget {
  final String usuario;
  HomeTabs({required this.usuario});

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int _indiceAba = 0;

  final _abas = [MapaNoiteAqui(), ListaLocais(), Recomendados()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo, ${widget.usuario}')),
      body: _abas[_indiceAba],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAba,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _indiceAba = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Locais'),
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: 'Recomendado'),
        ],
      ),
    );
  }
}

class MapaNoiteAqui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mapa aqui futuramente'));
  }
}

class ListaLocais extends StatelessWidget {
  final List<String> locais = [
    'Motel Delírio',
    'Bar 24h Augusta',
    'After Beats',
    'Balada Intensa',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locais.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.nightlife, color: Colors.purpleAccent),
          title: Text(locais[index]),
        );
      },
    );
  }
}

class Recomendados extends StatelessWidget {
  final List<Map<String, dynamic>> _locaisPersonalizados = [
    {
      'nome': 'Balada Neon',
      'categoria': 'Balada',
      'descricao': 'Você curtiu esse estilo antes. DJ ao vivo e drinks neon.',
    },
    {
      'nome': 'After da Augusta',
      'categoria': 'After',
      'descricao': 'Com base no seu histórico, locais com funcionamento até tarde.',
    },
    {
      'nome': 'Privê Secrets',
      'categoria': 'Privê',
      'descricao': 'Você buscou ambientes discretos. Este pode te interessar.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _locaisPersonalizados.length,
      itemBuilder: (context, index) {
        final local = _locaisPersonalizados[index];
        return Card(
          color: Colors.grey[850],
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            title: Text(local['nome'], style: TextStyle(color: Colors.white)),
            subtitle: Text(local['descricao'], style: TextStyle(color: Colors.grey[300])),
            trailing: Chip(
              label: Text(local['categoria']),
              backgroundColor: Colors.purpleAccent,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text(local['nome']),
                  content: Text(local['descricao']),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Fechar', style: TextStyle(color: Colors.purpleAccent)),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
