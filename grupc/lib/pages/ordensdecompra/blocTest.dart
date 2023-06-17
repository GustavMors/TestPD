import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/bloc/disponibilidade_api.dart';
import 'package:grupc/bloc/disponibilidade_bloc.dart';
import 'package:grupc/bloc/movimentacao_api.dart';
import 'package:grupc/models/produto.dart';
import 'package:grupc/models/quantidadeDisponivel.dart';

import '../../bloc/produto_bloc.dart';

class BlocTest extends StatefulWidget {
  const BlocTest({super.key});

  @override
  State<BlocTest> createState() => _BlocTestState();
}

class _BlocTestState extends State<BlocTest> {

  final TextEditingController _textNome = TextEditingController();
  var quantidades = <Disponivel>[];

  var ArmazemQ = 0;
  var VendasQ = 0;
  var TrocarQ = 0;

  _getProduto() {
    DisponibilidadeAPI.getQuantidade(_textNome.text).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        quantidades = lista.map((e) => Disponivel.fromJSON(e)).toList();
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar Produto')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textNome,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome do Produto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                await MovimentacaoAPI.postMovimentacao(2, 2, 2, 2, 2);
              },
              child: const Text('PESQUISAR'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 1000,
              child: ListView.builder(
                shrinkWrap: true,
                          itemCount: quantidades.length,
                          itemBuilder: (context, index) {
                            for (var quantidade in quantidades) {
                              if(quantidades.isNotEmpty) {
                                if(quantidades[index].idEstoque == 5) {
                                 return 
                                  Card(
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
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  Text(
                                                    'Mover',
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                                if(quantidades[index].idEstoque == 4){
                                  return 
                                  Card(
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
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  Text(
                                                    'Mover',
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                }
                                if(quantidades[index].idEstoque == 6){
                                  return 
                                  Card(
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
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  Text(
                                                    'Mover',
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                }
                                
                              } else {
                                return Text('Erro!');
                              }
                              
                            }
                            return Card(
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
                                    '${quantidades[index].descricao}'.substring(0, 15),
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
                                    '${quantidades[index].codBarras}',
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
                      );
                      SizedBox(
                        height: 10,
                      );
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
                                'Desconhecida',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      );
                              if(quantidades.isNotEmpty) {
                                if(quantidades[index].idEstoque == 5) {
                                 return 
                                  Card(
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
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  Text(
                                                    'Mover',
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                                if(quantidades[index].idEstoque == 4){
                                  return 
                                  Card(
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
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  Text(
                                                    'Mover',
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                }
                          }
                          }
                        ),
            ),

          )
        ],
      ),
    );
  }
}            // child: StreamBuilder(
            //   stream: _produtoBloc.stream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(child: Text('Erro: ${snapshot.error}'));
            //     }
            //     if (!snapshot.hasData) {
            //       return const Center(child: Text('Pesquisa um Produto.'));
            //     } else {
            //       var response = snapshot.data!;
            //       if (response.loading) {
            //         return const Center(
            //           child: SizedBox(
            //             height: 48,
            //             width: 48,
            //             child: CircularProgressIndicator(),
            //           ),
            //         );
            //       }
            //       var produto = response.response as Produto;
            //       return ListTile(
            //         leading: Chip(label: Text('${produto.id}')),
            //         title: Text('${produto.codBarras}'),
            //         subtitle: Text('${produto.descricao}')
            //       );
            //     }
            //   },
            // ),