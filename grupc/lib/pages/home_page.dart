import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grupc/pages/estoques/armazen_page.dart';
import 'package:grupc/pages/estoques/trocas_page.dart';
import 'package:grupc/pages/estoques/vendas_page.dart';
import 'package:grupc/pages/fornecedoras/fornecedoras_page.dart';
import 'package:grupc/pages/ordensdecompra/blocTest.dart';
import 'package:grupc/pages/ordensdecompra/ordens_page.dart';
import 'package:grupc/pages/produtos/produto_detalhado_page.dart';
import 'package:grupc/pages/produtos/produtos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/produto_bloc.dart';
import '../utils/nav.dart';
import 'leitor_page.dart';
import 'login_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ProdutoBloc _produtoBloc = ProdutoBloc();
  late SharedPreferences _prefs;
  String? emailLogado = '';
  String? nomeLogado = '';
  String? cargoLogado = '';

  @override
  initState() {
    _iniciarPreferences();
    super.initState();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      emailLogado = _prefs.getString('emailLogado');
      nomeLogado = _prefs.getString('nomeLogado');
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

  
  int _menuSelecionado = 0;
  String _resultadoLeitura = '';
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
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            Color.fromARGB(255, 30, 137, 224),
            Color.fromRGBO(0, 14, 50, 1),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (_menuSelecionado == 0)
                Text(
                  'Selecione uma opção',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              if (_menuSelecionado == 1)
                Text(
                  'Selecione um estoque',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              SizedBox(
                height: 10,
              ),
              if (_menuSelecionado == 0)
                Column(
                  children: [
                    Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.white),
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.orange),
                        child: InkWell(
                          onTap: () {
                            push(context, FornecedorasPage());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.local_shipping,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text('Fornecedoras',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              if (_menuSelecionado == 0)
                Column(
                  children: [
                    Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.white),
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.orange),
                        child: InkWell(
                          onTap: () {
                            push(context, ProdutosPage());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.padding,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Produtos',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_menuSelecionado == 0)
                    Column(
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: Ink(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.deepPurple),
                            child: InkWell(
                              onTap: () {
                                if(cargoLogado == 'Repositor') {
                                  dialogPermissao();
                                } else{
                                push(context, const OdensPage());
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.local_shipping,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text('Ordens de',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Text('Compra',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                ],
              ),
              if (_menuSelecionado == 1)
                (Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: Ink(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange),
                              child: InkWell(
                                onTap: () {
                                  push(context, ArmazemPage());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.padding,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Armazém',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: Ink(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange),
                              child: InkWell(
                                onTap: () {
                                  push(context, VendasPage());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Vendas',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: Ink(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange),
                              child: InkWell(
                                onTap: () {
                                  push(context, TrocasPage());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Trocas',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
            ],
          ),
        ),
      ),
      drawer: SizedBox(
        width: 300.0,
        child: Drawer(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromARGB(255, 30, 137, 224),
                  Color.fromRGBO(0, 14, 50, 1),
                ])),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 110.0,
                  child: DrawerHeader(
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(0.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Color.fromARGB(255, 30, 137, 224),
                            Color.fromRGBO(0, 14, 50, 1),
                          ])),
                      child: Center(
                        child: InkWell(
                          child: ListTile(
                            leading: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/2922/2922524.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              '$nomeLogado',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            subtitle: Text('$cargoLogado',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)),
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: const ListTile(
                    leading:
                        Icon(Icons.history_toggle_off, color: Colors.white),
                    title: Text(
                      'Histórico de Compras',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: const ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    title: Text('Histórico de Movimentações',
                        style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    push(context, BlocTest());
                  },
                ),
                const Divider(
                  color: Colors.white,
                ),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('Funcionários',
                        style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.white,
                ),
                InkWell(
                  child: const ListTile(
                    title: Text('Sair', style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () async{
                    await _prefs.remove('emailLogado');
                    await _prefs.remove('senhaLogada');
                    await _prefs.remove('nomeLogado');
                    await _prefs.remove('cargoLogado');
                    await _prefs.remove('idLogado');
                    push(context, LoginPage(), replace: true);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
              icon: Icon(Icons.compress),
              label: 'Estoques',
            ),
          ],
          currentIndex: _menuSelecionado,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (opcaoSelecionada) {
            setState(() {
              _menuSelecionado = opcaoSelecionada;
            });
          }),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          child: Icon(
            Icons.qr_code,
            size: 30,
          ),
          tooltip: 'Scannear',
          onPressed: () async {
            var resultadoLeitura = await push(context, LeitorPage());
            setState(() {
              if (resultadoLeitura == null) {
                _resultadoLeitura = 'Erro no código de barras!';
              } else if (resultadoLeitura.toString().length >= 14) {
                _resultadoLeitura = '';
                dialogErro();
              } else {
                _resultadoLeitura = resultadoLeitura;
                push(context, ProdutoDetalhadoPage(codBarras: _resultadoLeitura));
              }
            });
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
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
 
 
  Future<void> dialogPermissao() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder : (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text('Erro!', style: TextStyle(color: Colors.white),),
            content: Text('Você não tem o direito!', style: TextStyle(color: Colors.white, fontSize: 25),),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text('Ok', style: TextStyle(color: Colors.white),))
            ],
          );
        }
      ); }

  // Future<void> dialogProduto(String produtoSelecionado) async {
  //    var produto = await _produtoBloc.buscar(produtoSelecionado);
  //    if(produto == null){
  //           ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Produto não encontrado!')));
  //    } else {
  //    return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.blue,
            
  //           content: Column(
  //         children: [
  //           Card(
  //             color: Colors.transparent,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                         Image.network('https://img.freepik.com/fotos-premium/caixa-de-papelao-fechada-isolada-no-fundo-branco-conceito-de-varejo-logistica-entrega-e-armazenamento-vista-lateral-com-perspectiva_92242-911.jpg?w=2000',
  //                         width: 100,
  //                         height: 100,
  //                         fit: BoxFit.cover,)
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text('${produto.descricao}'.substring(0,10), style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text('${produto.codBarras}', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),)
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         Card(
  //           color: Colors.transparent,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [Text('Quantidade disponível', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
  //               Text('42', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),)],
  //             ),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Card(
  //               color: Colors.transparent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: SizedBox(
  //                   width: 105,
  //                   height: 84,
  //                   child: Column(
  //                     children: [
  //                       Text('Armazém', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
  //                       Text('42', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
  //                       ElevatedButton(onPressed: () {}, child: Column(
  //                           children: [
  //                             Icon(Icons.arrow_upward),
  //                             Text('Mover',)
  //                           ],
  //                         ))
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Card(
  //               color: Colors.transparent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: SizedBox(
  //                   width: 105,
  //                   height: 84,
  //                   child: Column(
  //                     children: [
  //                       Text('Vendas', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
  //                         Text('42', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
  //                         ElevatedButton(onPressed: () {}, child: Column(
  //                           children: [
  //                             Icon(Icons.arrow_upward),
  //                             Text('Mover',)
  //                           ],
  //                         ))
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
              
  //           ],
  //         ),
  //         Card(
  //               color: Colors.transparent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: SizedBox(
  //                   width: 105,
  //                   height: 84,
  //                   child: Column(
  //                     children: [
  //                       Text('Trocas', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
  //                         Text('42', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
  //                         ElevatedButton(onPressed: () {}, child: Column(
  //                           children: [
  //                             Icon(Icons.arrow_upward),
  //                             Text('Mover',)
  //                           ],
  //                         ))
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             )
  //         ],
  //       ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   'Ok',
  //                   style: TextStyle(color: Colors.white),
  //                 ))
  //           ],
  //         );
  //       });
  // }}
}
