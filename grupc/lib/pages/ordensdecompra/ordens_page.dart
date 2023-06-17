import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter/services.dart';
import 'package:grupc/bloc/comprar_api.dart';
import 'package:grupc/models/produto.dart';
import 'package:grupc/pages/leitor_page.dart';
import 'package:grupc/pages/ordensdecompra/blocTest.dart';
import 'package:grupc/utils/nav.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/produto_bloc.dart';
import '../login_page.dart';

class OdensPage extends StatefulWidget {
  const OdensPage({super.key});

  @override
  State<OdensPage> createState() => _OdensPageState();
}

class _OdensPageState extends State<OdensPage> {
  final url = '10.0.2.2:7220/Compras/CadastrarCompra';




  late SharedPreferences _prefs;
  String? emailLogado = '';
  String? senhaLogada = '';
  int? idLogado = 0;

  String produtoDescricao = '';
  String produtoCodBarras = '';
  int produtoId = 0;


  @override
  initState() {
    _iniciarPreferences();
    super.initState();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      emailLogado = _prefs.getString('emailLogado');
      senhaLogada = _prefs.getString('senhaLogada');
      idLogado = _prefs.getInt('idLogado');
    });
    // if (emailLogado == null) {
    //   push(
    //     context,
    //     LoginPage(),
    //     replace: true,
    //   );
    // }
  }

  int _contador = 1;
  String _resultadoLeitura = '';
  final TextEditingController _textCodBarras = TextEditingController();
  var _textSenha = TextEditingController();
  final ProdutoBloc _produtoBloc = ProdutoBloc();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://cdn.bitrix24.com.br/b22619691/landing/34f/34f561c5b3a49a957806f980872f6319/Untitled-4_1x.png',
          width: 120,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color.fromARGB(255, 30, 137, 224),
                Color.fromRGBO(0, 14, 50, 1),
              ])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Center(
                  child: Text(
                    'Realizar compra',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            var resultadoLeitura =
                                await push(context, LeitorPage());
                            setState(() {
                              if (resultadoLeitura == null) {
                                _resultadoLeitura = '';
                              } else if (resultadoLeitura.toString().length >=
                                  14) {
                                _resultadoLeitura = '';
                                dialogErro();
                              } else {
                                _resultadoLeitura = resultadoLeitura;
                                _produtoBloc.fetchByName(_resultadoLeitura.toString());
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                          ),
                          iconSize: 35,
                        ),
                        SizedBox(
                            width: 190,
                            child: TextField(
                              controller: _textCodBarras,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              maxLength: 13,
                               inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text(
                                    'Código de barras',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  )),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if(_textCodBarras == null || _textCodBarras.toString().length <= 14){
                                dialogErro();
                              } else {
                                _produtoBloc.fetchByName(_textCodBarras.text);
                              }
                            },
                            child: const Text('Buscar'))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: StreamBuilder(
                      stream: _produtoBloc.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),));
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Digite ou scanneie um Código de barras!',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          );
                        }
                        var response = snapshot.data!;
                        if (response.loading) {
                          return Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator()),
                          );

                        }
                        var produto = response.response as Produto;

                        produtoCodBarras = produto.codBarras!;
                        produtoDescricao = produto.descricao!;
                        produtoId = produto.id!;
                        
                        return Card(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  'https://img.freepik.com/fotos-premium/caixa-de-papelao-fechada-isolada-no-fundo-branco-conceito-de-varejo-logistica-entrega-e-armazenamento-vista-lateral-com-perspectiva_92242-911.jpg?w=2000',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${produto.descricao}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${produto.codBarras}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        );
                  
                      }),
                      
                ),
                SizedBox(
                  width: 150,
                  child: Card(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => setState(() {
                                  subtrairContador();
                                }),
                            icon:
                                const Icon(Icons.remove, color: Colors.white)),
                        Text(
                          '$_contador',
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () => setState(() {
                                  somarContador();
                                }),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      dialogCompra();
                    },
                    child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                            child: Text(
                          'Realizar Compra',
                          textAlign: TextAlign.center,
                        )))),

                const SizedBox(
                  height: 159,
                ),
              ],
            ),
          )),
    );
  }

  subtrairContador() {
    if (_contador > 1) {
      _contador--;
    }
  }

  somarContador() {
    _contador++;
  }

  Future<void> dialogErro() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              'Erro!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            content: Text('O código é inválido!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  Future<void> dialogCompra() async {
    if(produtoCodBarras == '') {
      return dialogErro();
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 1, 84, 151),
            title: const Text(
              'Confirmar compra',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Produto: $produtoCodBarras',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('$_resultadoLeitura',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Descrição: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                             Text('${produtoDescricao}'.substring(0,15),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text('Quantidade: ',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              Text('$_contador',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Senha',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                        width: 280,
                        child: TextField(
                          controller: _textSenha,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                              label: Text(
                                'Digite sua senha',
                                style: TextStyle(color: Colors.white),
                              ),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                              )),
                        )),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
      
                    _realizarCompra();
                  },
                  child: const Text(
                    'Confirmar',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  void _realizarCompra() async {
    var senhaDigitada = _textSenha.text;
    await CompraAPI.postCompra(produtoCodBarras.toString(), _contador, produtoId, 2);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra Realizada com sucesso!')),
      );
      Navigator.of(context).pop();
    // if (senhaDigitada == senhaLogada) {

      
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('senha incorreta!')),
    //   );
    // }
  }
}
