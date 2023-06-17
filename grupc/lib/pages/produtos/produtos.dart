import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/bloc/produto_api.dart';
import 'package:grupc/bloc/produto_bloc.dart';
import 'package:grupc/models/produto.dart';
import 'package:grupc/pages/produtos/produto_detalhado_page.dart';
import 'package:grupc/utils/nav.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  var produtos = <Produto>[];

  _getProdutos() {
    ProdutoAPI.getProdutos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        produtos = lista.map((e) => Produto.fromJSON(e)).toList();
      });
    });
  }

void initState() {
  _getProdutos();
  }

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
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'Produtos',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: produtos.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.network(
                              'https://img.freepik.com/fotos-premium/caixa-de-papelao-fechada-isolada-no-fundo-branco-conceito-de-varejo-logistica-entrega-e-armazenamento-vista-lateral-com-perspectiva_92242-911.jpg?w=2000',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${produtos[index].descricao}'
                                      .substring(0, 12), //Limitar 10 Charactrs
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${produtos[index].codBarras}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            SizedBox(
                              width: 90,
                              child: ElevatedButton(
                                  onPressed: () {
                                    var produtoSelecionado =
                                        '${produtos[index].codBarras}'; //mudar para o da API
                                    push(
                                        context,
                                        ProdutoDetalhadoPage(
                                            codBarras: produtoSelecionado));
                                  },
                                  child: Text('Detalhes')),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.lightBlueAccent,
        tooltip: 'Adicionar produtos',
        child: Icon(Icons.add),
      ),
    );
  }
}
