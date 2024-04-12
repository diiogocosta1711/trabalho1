import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Números - Diogo Silva & Mariana Nogueira',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Conversor de Números - Página Inicial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _inputValue = '';
  String _outputValue = '';
  String _inputBase = 'Decimal';
  String _outputBase = 'Binary';

  void _convert() {
    String inputValue = _inputValue.trim();
    int? parsedValue;

    switch (_inputBase) {
      case 'Decimal':
        parsedValue = int.tryParse(inputValue);
        break;
      case 'Binary':
        parsedValue = int.tryParse(inputValue, radix: 2);
        break;
      case 'Octal':
        parsedValue = int.tryParse(inputValue, radix: 8);
        break;
      case 'Hexadecimal':
        parsedValue = int.tryParse(inputValue, radix: 16);
        break;
    }

    if (parsedValue != null) {
      setState(() {
        switch (_outputBase) {
          case 'Decimal':
            _outputValue = parsedValue.toString();
            break;
          case 'Binary':
            _outputValue =
                parsedValue?.toRadixString(2) ?? ''; // Usando ?. e ??
            break;
          case 'Octal':
            _outputValue =
                parsedValue?.toRadixString(8) ?? ''; // Usando ?. e ??
            break;
          case 'Hexadecimal':
            _outputValue = parsedValue?.toRadixString(16)?.toUpperCase() ??
                ''; // Usando ?. e ??
            break;
        }
      });
    } else {
      setState(() {
        _outputValue = 'Número INVÁLIDO!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField(
              value: _inputBase,
              items: ['Decimal', 'Binario', 'Octal', 'Hexadecimal']
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _inputBase = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: 'Converter De:'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Insira o número'),
              onChanged: (value) {
                _inputValue = value;
              },
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: _outputBase,
              items: ['Decimal', 'Binary', 'Octal', 'Hexadecimal']
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _outputBase = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: 'Para'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 20.0),
            Text('Resultado: $_outputValue',
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
