import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Conversor de Números - Diogo Silva & Mariana Nogueira', // Define o título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define a cor primária do tema
      ),
      home: const MyHomePage(
          title:
              'Conversor de Números - Página Inicial'), // Define a página inicial
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title; // Título da página

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _inputValue = ''; // Valor de entrada
  String _outputValue = ''; // Valor de saída
  String _inputBase = 'Decimal'; // Base de entrada padrão
  String _outputBase = 'Binary'; // Base de saída padrão

  // Função para converter o número de entrada para a base de saída selecionada
  void _convert() {
    String inputValue =
        _inputValue.trim(); // Remove espaços em branco do valor de entrada
    int? parsedValue; // Valor inteiro parseado

    // Converte o valor de entrada para um inteiro baseado na base de entrada selecionada
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

    // Se o valor foi parseado com sucesso
    if (parsedValue != null) {
      setState(() {
        // Converte o valor parseado para a base de saída selecionada
        switch (_outputBase) {
          case 'Decimal':
            _outputValue = parsedValue.toString();
            break;
          case 'Binary':
            _outputValue =
                parsedValue?.toRadixString(2) ?? ''; // Converte para binário
            break;
          case 'Octal':
            _outputValue =
                parsedValue?.toRadixString(8) ?? ''; // Converte para octal
            break;
          case 'Hexadecimal':
            _outputValue = parsedValue?.toRadixString(16)?.toUpperCase() ??
                ''; // Converte para hexadecimal
            break;
        }
      });
    } else {
      // Se o valor não puder ser parseado, define a saída como "Número INVÁLIDO!"
      setState(() {
        _outputValue = 'Número INVÁLIDO!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Título da barra de aplicações
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField(
              value: _inputBase,
              items: [
                'Decimal',
                'Binary',
                'Octal',
                'Hexadecimal'
              ] // Opções para a base de entrada
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _inputBase = value.toString();
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Converter De:'), // Rótulo para a base de entrada
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(
                  labelText:
                      'Insira o número'), // Rótulo para a entrada do número
              onChanged: (value) {
                _inputValue =
                    value; // Atualiza o valor de entrada conforme o utilizador digita
              },
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: _outputBase,
              items: [
                'Decimal',
                'Binary',
                'Octal',
                'Hexadecimal'
              ] // Opções para a base de saída
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _outputBase = value.toString();
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Para'), // Rótulo para a base de saída
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Converter'), // Botão para iniciar a conversão
            ),
            const SizedBox(height: 20.0),
            Text('Resultado: $_outputValue', // Exibe o resultado da conversão
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
