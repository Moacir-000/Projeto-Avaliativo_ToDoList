import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do List",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaToDoList(),
    );
  }
}


class TelaToDoList extends StatefulWidget {
  const TelaToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaToDoListState createState() => _TelaToDoListState();
}


class _TelaToDoListState extends State<TelaToDoList> {
  List<String> toDoList = [];
  List<String> fazendoLista = [];
  List<String> feitoLista = [];
  List<String> arquivadosLista = [];


  TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO LIST", style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 158, 193),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: "Qual a sua tarefa?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 158, 193),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Nova", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildSection(
                "A Fazer:", toDoList, Icons.arrow_forward, _moverParaFazendo),

            _buildSection("Fazendo:", fazendoLista, Icons.check_circle_outline,
                _moverFazendoParaFeito),

            _buildSection(
                "Feito:", feitoLista, Icons.archive, _moverFeitoParaArquivado),

            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAtividadesArquivadas,
        child: const Icon(Icons.access_time),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


  Widget _buildSection(String title, List<String> items, IconData icon,
      Function(int) onPressed) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          Expanded(
            child: items.isNotEmpty
                ? _buildList(items, icon, onPressed)
                : const SizedBox(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _buildList(
      List<String> items, IconData icon, Function(int) onPressed) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(items[index]),
              ),
              IconButton(
                icon: Icon(icon),
                onPressed: () {
                  onPressed(index);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removerTarefa(index, items);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _moverParaFazendo(int index) {
    setState(() {
      String tarefa = toDoList.removeAt(index);
      fazendoLista.add(tarefa);
    });
  }


  void _moverFazendoParaFeito(int index) {
    setState(() {
      String tarefa = fazendoLista.removeAt(index);
      feitoLista.add(tarefa);
    });
  }


  void _moverFeitoParaArquivado(int index) {
    setState(() {
      String tarefa = feitoLista.removeAt(index);
      arquivadosLista.add(tarefa);
    });
  }


  void _removerTarefa(int index, List<String> sourceList) {
    setState(() {
      sourceList.removeAt(index);
    });
  }


  void _adicionarTarefa() {
    setState(() {
      String novaTarefa = _textEditingController.text;
      if (novaTarefa.isNotEmpty) {
        toDoList.add(novaTarefa);
        _textEditingController.clear();
      }
    });
  }


  void _mostrarAtividadesArquivadas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atividades Arquivadas'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (arquivadosLista.isEmpty) const Text('Nenhuma atividade arquivada.'),
                for (var activity in arquivadosLista)
                  ListTile(
                    title: Text(activity),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}


/*import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaToDoList(),
    );
  }
}


class TelaToDoList extends StatefulWidget {
  const TelaToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaToDoListState createState() => _TelaToDoListState();
}


class _TelaToDoListState extends State<TelaToDoList> {
  List<String> toDoList = [];
  List<String> fazendoLista = [];
  List<String> feitoLista = [];
  List<String> arquivadosLista = [];


  TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO LIST', style: TextStyle(
          color: Color.fromARGB(255, 1, 106, 129),
          fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 158, 193),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius:
                          BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Qual a sua tarefa?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 158, 193),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Nova',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildSection(
                'A Fazer:', toDoList, Icons.arrow_forward, _moverParaFazendo),

            _buildSection('Fazendo:', fazendoLista, Icons.check_circle_outline,
                _moverFazendoParaFeito),

            _buildSection(
                'Feito:', feitoLista, Icons.archive, _moverFeitoParaArquivado),

            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAtividadesArquivadas,
        child: const Icon(Icons.access_time),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


  Widget _buildSection(String title, List<String> items, IconData icon,
      Function(int) onPressed) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          Expanded(
            child: items.isNotEmpty
                ? _buildList(items, icon, onPressed)
                : const SizedBox(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _buildList(
      List<String> items, IconData icon, Function(int) onPressed) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(items[index]),
              ),
              IconButton(
                icon: Icon(icon),
                onPressed: () {
                  onPressed(index);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removerTarefa(index, items);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _moverParaFazendo(int index) {
    setState(() {
      String tarefa = toDoList.removeAt(index);
      fazendoLista.add(tarefa);
    });
  }


  void _moverFazendoParaFeito(int index) {
    setState(() {
      String tarefa = fazendoLista.removeAt(index);
      feitoLista.add(tarefa);
    });
  }


  void _moverFeitoParaArquivado(int index) {
    setState(() {
      String tarefa = feitoLista.removeAt(index);
      arquivadosLista.add(tarefa);
    });
  }


  void _removerTarefa(int index, List<String> sourceList) {
    setState(() {
      sourceList.removeAt(index);
    });
  }


  void _adicionarTarefa() {
    setState(() {
      String novaTarefa = _textEditingController.text;
      if (novaTarefa.isNotEmpty) {
        toDoList.add(novaTarefa);
        _textEditingController.clear();
      }
    });
  }


  void _mostrarAtividadesArquivadas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atividades Arquivadas'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (arquivadosLista.isEmpty) const Text('Nenhuma atividade arquivada.'),
                for (var activity in arquivadosLista)
                  ListTile(
                    title: Text(activity),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
*/