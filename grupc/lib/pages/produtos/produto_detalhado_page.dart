import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/bloc/comprar_api.dart';
import 'package:grupc/bloc/disponibilidade_api.dart';
import 'package:grupc/bloc/disponibilidade_bloc.dart';
import 'package:grupc/bloc/movimentacao_api.dart';
import 'package:grupc/bloc/produto_api.dart';

import 'package:grupc/models/produto.dart';
import 'package:grupc/models/quantidadeDisponivel.dart';
import 'package:grupc/pages/home_page.dart';
import 'package:grupc/pages/produtos/produtos.dart';
import 'package:grupc/utils/nav.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/login_bloc.dart';
import '../../bloc/produto_bloc.dart';

class ProdutoDetalhadoPage extends StatefulWidget {
  String codBarras;
  ProdutoDetalhadoPage({required this.codBarras});

  @override
  State<ProdutoDetalhadoPage> createState() => _ProdutoDetalhadoPageState();
}

class _ProdutoDetalhadoPageState extends State<ProdutoDetalhadoPage> {
  final DisponibilidadeBloc _disponibilidadeBloc = DisponibilidadeBloc();
  final LoginBloc _loginBloc = LoginBloc();
  final ProdutoBloc _produtoBloc = ProdutoBloc();
  late SharedPreferences _prefs;
  int? idLogado = 0;
  String? senhaLogada = '';
  String? cargoLogado = '';

  //controllers
  final TextEditingController _textSenha = TextEditingController();
  final TextEditingController _textSenhaRepo = TextEditingController();
  final TextEditingController _textEmailRepo = TextEditingController();
  final TextEditingController _textQuantidade = TextEditingController();

  var quantidades = <Disponivel>[];

  //dropdown
  String valorDropdown = 'Armazém';
  var estoques = [
    'Armazém',
    'Vendas',
    'Trocas',
  ];

  _getProduto() {
    DisponibilidadeAPI.getQuantidade(widget.codBarras).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        quantidades = lista.map((e) => Disponivel.fromJSON(e)).toList();
      });
    });
  }

  void initState() {
    _iniciarPreferences();
    super.initState();

    _produtoBloc.fetchByName(widget.codBarras.toString());

    _getProduto();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      senhaLogada = _prefs.getString('senhaLogada');
      idLogado = _prefs.getInt('idLogado');
      cargoLogado = _prefs.getString('cargoLogado');
    });
    // if (emailLogado == null || cargoLogado == null) {
    //   push(
    //     context,
    //     LoginPage(),
    //     replace: true,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do produto '),
        actions: [
          IconButton(
            onPressed: () {
              _getProduto();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Página atualizada!')));
            },
            icon: Icon(Icons.refresh),
            iconSize: 30,
            tooltip: 'Atualizar página',
          )
        ],
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
        child: Column(
          children: [
            StreamBuilder(
              stream: _produtoBloc.stream,
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Erro!');
                }
                if (!snapshot.hasData) {
                  return Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Color.fromARGB(255, 30, 137, 224),
                            Color.fromRGBO(0, 14, 50, 1),
                          ])),
                      child: Center(
                          child: Text(
                        'Carregando . . .',
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      )));
                } else {
                  var response = snapshot.data!;
                  if (response.loading) {
                    return Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                              Color.fromARGB(255, 30, 137, 224),
                              Color.fromRGBO(0, 14, 50, 1),
                            ])),
                        child: Center(
                            child: Text(
                          'Carregando . . .',
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        )));
                  }
                  var produto = response.response as Produto;
                  return SingleChildScrollView(
                      child: Column(children: [
                    Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://img.freepik.com/fotos-premium/caixa-de-papelao-fechada-isolada-no-fundo-branco-conceito-de-varejo-logistica-entrega-e-armazenamento-vista-lateral-com-perspectiva_92242-911.jpg?w=2000',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${produto.descricao}'.substring(0, 15),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${produto.codBarras}',
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Quantidade disponível',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Faça a conta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]));
                }
              }),
            ),
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: quantidades.length,
                    itemBuilder: (context, index) {
                      for (var quantidade in quantidades) {
                        if (quantidades.isNotEmpty) {
                          if (quantidades[index].idEstoque == null) {
                            return Text('N');
                          }
                          if (quantidades[index].idEstoque == 5) {
                            return Card(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 110,
                                  child: Column(
                                    children: [
                                      Text('Armazém',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        '${quantidades[index].quantidade}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (cargoLogado == "Repositor") {
                                                dialogErro();
                                              } else
                                                dialogMovimentacao(
                                                    quantidades[index]
                                                        .idEstoque!,
                                                    quantidades[index]
                                                        .idProduto!);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.arrow_upward),
                                                Text(
                                                  'Mover',
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          if (quantidades[index].idEstoque == 4) {
                            return Card(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 110,
                                  child: Column(
                                    children: [
                                      Text('Vendas',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        '${quantidades[index].quantidade}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (cargoLogado == "Repositor") {
                                                dialogErro();
                                              } else
                                                dialogMovimentacao(
                                                    quantidades[index]
                                                        .idEstoque!,
                                                    quantidades[index]
                                                        .idProduto!);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.arrow_upward),
                                                Text(
                                                  'Mover',
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          if (quantidades[index].idEstoque == 6) {
                            return Card(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 110,
                                  child: Column(
                                    children: [
                                      Text('Trocas',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        '${quantidades[index].quantidade}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (cargoLogado == "Repositor") {
                                                dialogErro();
                                              } else
                                                dialogMovimentacao(
                                                    quantidades[index]
                                                        .idEstoque!,
                                                    quantidades[index]
                                                        .idProduto!);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.arrow_upward),
                                                Text(
                                                  'Mover',
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {}
                      }
                      return Text('');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dialogErro() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              'Erro',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Você não tem o direito!',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
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

  Future<void> dialogMovimentacao(int idEstoqueSaida, int IdProduto) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text(
                'Realizar movimentação',
                style: TextStyle(color: Colors.white),
              ),
              content: Builder(builder: (context) {
                return Container(
                  height: 480,
                  width: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            width: 280,
                            child: TextField(
                              controller: _textSenha,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  label: Text(
                                    'Digite sua senha',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  )),
                            )),
                        Divider(
                          color: Colors.white,
                          height: 50,
                        ),
                        Text(
                          'Repositor responsável',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: 280,
                            child: TextField(
                              controller: _textEmailRepo,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              decoration: InputDecoration(
                                  label: Text(
                                    'Email do repositor',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  )),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 280,
                            child: TextField(
                              controller: _textSenhaRepo,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  label: Text(
                                    'Senha do repositor',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  )),
                            )),
                        SizedBox(
                          width: 280,
                        ),
                        Divider(
                          color: Colors.white,
                          height: 20,
                        ),
                        Text(
                          'Estoque destino',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                            dropdownColor: Colors.blue,
                            value: valorDropdown,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            items: estoques.map((String estoques) {
                              return DropdownMenuItem(
                                value: estoques,
                                child: Text(
                                  estoques,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? novoValor) {
                              setState(() {
                                valorDropdown = novoValor!;
                              });
                            }),
                        Divider(
                          color: Colors.white,
                          height: 20,
                        ),
                        Text('Quantidade',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _textQuantidade,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              keyboardType: TextInputType.number,
                              minLines: 1,
                              decoration: InputDecoration(
                                  label: Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  )),
                            )),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      _validarCompra(idEstoqueSaida, IdProduto);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            );
          });
        });
  }

  _validarCompra(int idEstoqueSaida, int idProduto) async {
    var senhaRepoDigitada = _textSenhaRepo.text;
    var emailRepoDigitado = _textEmailRepo.text;
    var quantidadeDigitada = int.parse(_textQuantidade.text);

    var funcionario =
        await _loginBloc.logar(_textEmailRepo.text, _textSenhaRepo.text);

    if (funcionario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha do repositor incorretos!')),
      );
    } else {
      var senhaRepositor = funcionario.senha;
      var emailRepositor = funcionario.email;

      if (_textSenha.text == senhaLogada &&
          senhaRepositor == senhaRepoDigitada &&
          emailRepositor == emailRepoDigitado) {
        int estoqueDestino = 0;
        int tipoMovimentacao = 0;
        if (valorDropdown == 'Armazém') {
          estoqueDestino = 5;
          tipoMovimentacao = 4;
        }
        if (valorDropdown == 'Vendas') {
          estoqueDestino = 4;
          tipoMovimentacao = 5;
        }
        if (valorDropdown == 'Trocas') {
          estoqueDestino = 6;
          tipoMovimentacao = 6;
        }
        await MovimentacaoAPI.postMovimentacao(estoqueDestino, idEstoqueSaida,
            idLogado!, idProduto, quantidadeDigitada);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Movimentação realizada! Atualize a página para ver!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sua senha está incorreta!')),
        );
      }
    }
  }
}
