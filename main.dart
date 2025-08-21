import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Example layout"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExampleLayout()));
            },
          ),
          ElevatedButton(
            child: const Text("Example counter"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExampleCounter()));
            },
          ),
          ElevatedButton(
            child: const Text("List dynamic"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExampleList()));
            },
          ),
        ],
      ),
    );
  }
}

class ExampleLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Example layout")),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(width: 80, height: 80, color: Colors.red),
              Container(width: 80, height: 80, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(10),
            child: const Text("Texto superpuesto",
                style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Element 1"),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Element 2"),
          ),
        ],
      ),
    );
  }
}


class ExampleCounter extends StatefulWidget {
  @override
  State<ExampleCounter> createState() => _ExampleCounterState();
}

class _ExampleCounterState extends State<ExampleCounter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Example Counter")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Contador: $counter",
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("Aumentar"),
                onPressed: () {
                  setState(() => counter++);
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                child: const Text("Disminuir"),
                onPressed: () {
                  setState(() => counter--);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ExampleList extends StatefulWidget {
  @override
  State<ExampleList> createState() => _ExampleListState();
}

class _ExampleListState extends State<ExampleList> {
  List<String> items = List.generate(12, (index) => "Elemento ${index + 1}");

  void addItem() {
    setState(() {
      items.add("Elemento ${items.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Example List")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.list),
            title: Text(items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
    );
  }

}
