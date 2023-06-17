// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/pages/produtos/produtos.dart';
import 'package:grupc/utils/nav.dart';

import '../../bloc/disponibilidade_api.dart';
import '../../models/quantidadeDisponivel.dart';
import '../produtos/produto_detalhado_page.dart';

class ArmazemPage extends StatefulWidget {
  const ArmazemPage({super.key});

  @override
  State<ArmazemPage> createState() => _ArmazemPageState();
}

class _ArmazemPageState extends State<ArmazemPage> {
  var quantidades = <Disponivel>[];

  _getProduto() {
    DisponibilidadeAPI.getQuantidadeEstoque().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        quantidades = lista.map((e) => Disponivel.fromJSON(e)).toList();
      });
    });
  }

  void initState() {
    _getProduto();
  }

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
                'Produtos em Armazém',
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
                itemCount: quantidades.length,
                itemBuilder: ((context, index) {
                  for(var quantidade in quantidades){
                    if(quantidades[index].idEstoque == 5){
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
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(
                                  '${quantidades[index].descricao}'.substring(0, 10),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 90,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${quantidades[index].codBarras}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 23,
                            ),
                            Text(
                              '${quantidades[index].quantidade}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 87,
                              child: ElevatedButton(
                                  onPressed: () async{
                                    await push(
                                        context,
                                        ProdutoDetalhadoPage(
                                            codBarras: '${quantidades[index].codBarras}'));
                                            _getProduto();
                                  },
                                  child: Text('Detalhes')),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                    } 
                  }
                  return Text('');
                }),
              ))
            ],
          )),
    );
  }
}
