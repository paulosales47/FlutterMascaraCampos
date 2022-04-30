import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart' as validacao;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  var _nomeController  = TextEditingController();
  var _idadeController = TextEditingController();
  var _cpfController  = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _mensagem = "";
  String? _nome;
  String? _idade;
  String? _cpf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //NOME
                TextFormField(
                  controller: _nomeController,
                  onSaved: (nome) => _nome = nome,
                  decoration: InputDecoration(
                    hintText: "Informe seu nome"
                  ),
                  validator: (nome){
                    if(nome == null || nome.isEmpty) return "O campo é obrigatório";
                    if(nome.length < 3) return "Digite ao menos 3 caracteres";
                    return null;
                  },
                ),
                //IDADE
                TextFormField(
                  controller: _idadeController,
                  onSaved: (idade) => _idade = idade,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                  decoration: InputDecoration(
                    hintText: "Informe sua idade"
                  ),
                  validator: (idade){
                    if(idade == null || idade.isEmpty) return "O campo é obrigatório";
                    return null;
                  },
                ),
                //CPF
                TextFormField(
                  controller: _cpfController,
                  onSaved: (cpf) => _cpf = cpf,
                  decoration: InputDecoration(
                    hintText: "Informe seu CPF"
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  validator: (cpf){
                    if(cpf == null || cpf.isEmpty) return "O campo é obrigatório";
                    if(!validacao.CPFValidator.isValid(cpf)) return "O CPF informado é inválido";
                    return null;
                  },
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState?.validate() == true){
                    _formKey.currentState?.save();
                    print("${_nome}, ${_idade}, ${_cpf}");
                    _mensagem = "Formulário válido";
                  }
                  else _mensagem = "Formulário inválido";
                  setState(() {});
                }, child: Text("Salvar")),
                Text(
                    _mensagem,
                    style: TextStyle(fontSize: 25)
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
