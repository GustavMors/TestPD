import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/models/fornecedor.dart';

import '../../bloc/fornecedoras_api.dart';

class FornecedorasPage extends StatefulWidget {
  const FornecedorasPage({super.key});

  @override
  State<FornecedorasPage> createState() => _FornecedorasPageState();
}

class _FornecedorasPageState extends State<FornecedorasPage> {

  var fornecedores = <Fornecedor>[];

  _getFornecedores() {
    FornecedoresAPI.getFornecedores().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        fornecedores = lista.map((e) => Fornecedor.fromJSON(e)).toList();
      });
    });
  }

void initState() {
  _getFornecedores();
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
                'Fornecedoras',
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
                itemCount: fornecedores.length,
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
                              'https://thumbs.dreamstime.com/t/supplier-illustrations-distribution-trucks-stacks-boxes-30395986.jpg',
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
                                  '${fornecedores[index].nome}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${fornecedores[index].cnpj}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 45,
                            ),
                          
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
        onPressed: () {},
        backgroundColor: Colors.lightBlueAccent,
        tooltip: 'Adicionar Fornecedoras',
        child: Icon(Icons.add),
      ),
    );
  }
}
