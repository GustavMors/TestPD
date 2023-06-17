
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/login_bloc.dart';
import '../utils/nav.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _textEmail = TextEditingController();
  var _textSenha = TextEditingController();
  late SharedPreferences _prefs;
  final LoginBloc _loginBloc = LoginBloc();

  @override
  initState() {
    _iniciarPreferences();
    super.initState();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('funcionarioLogado') != null) {
      push(
        context,
        MenuPage(),
        replace: true,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
        //color: Colors.blueGrey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 180,
                  child: Image.network(
                      'https://cdn.bitrix24.com.br/b22619691/landing/34f/34f561c5b3a49a957806f980872f6319/Untitled-4_1x.png'),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text('Acesse o gerenciamento do estoque realizando o login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 25,
                ),
                 SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: _textEmail,

                      decoration: InputDecoration(
                          labelText: 'User',
                          
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1)
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    )),
                SizedBox(
                    width: 300,
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      controller: _textSenha,
                      
                      decoration: InputDecoration(
                        
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1)
                        ),
                        fillColor: Colors.white,
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.password,
                            color: Colors.white,
                          )),
                    )),
                  const SizedBox(
                      height: 25,
                    ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () async {
                        // push(context, MenuPage(), replace: true);
                        _logar();
                      },
                      child: Text('Acessar', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logar() async{

    var funcionario = await _loginBloc.logar(_textEmail.text, _textSenha.text);

    if(funcionario == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha incorretos!')),
      );
    } else {
    //get funcionarios
    var email = funcionario.email;
    var senha = funcionario.senha;
    var nome = funcionario.nome!;
    var cargo = funcionario.setor!;
    var id = funcionario.id!;

     var emailDigitado = _textEmail.text;
    var senhaDigitada = _textSenha.text;

    if(emailDigitado == email && senhaDigitada == senha){   // puxar do block "emailFuncionario e senhaFuncionario"        // puxar do bloc "cargoFuncionario"
      await _prefs.setString('emailLogado', emailDigitado);
      await _prefs.setString('senhaLogada', senhaDigitada);
      await _prefs.setString('cargoLogado', cargo);
      await _prefs.setString('nomeLogado', nome);
      await _prefs.setInt('idLogado', id);
      push(context, MenuPage(), replace: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha incorretos!')),
      );
    }
    }


   
  }
}
