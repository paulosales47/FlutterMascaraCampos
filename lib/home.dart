import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _cpfController = TextEditingController();
  var _cnpjController  = TextEditingController();
  var _cepController = TextEditingController();
  var _telefoneController = TextEditingController();
  var _dataController = TextEditingController();
  var _moedaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _formatarMoeda(){
      String moeda = _moedaController.text.toString();
      if(moeda.isEmpty) return;

      moeda = moeda.replaceAll(".", "");
      moeda = moeda.replaceAll(",", ".");

      double moedaConvertida = double.parse(moeda);
      print(moedaConvertida);
      var formatador = NumberFormat("#,##0.00", "pt_BR");
      var resultado = formatador.format(moedaConvertida);
      print(resultado);
    }

    _listarEstados(){
      for(var estado in Estados.listaEstados){
        print(estado);
      }
      for(var estado in Estados.listaEstadosSigla){
        print(estado);
      }
    }

    _listarRegioes(){
      for(var regiao in Regioes.listaRegioes){
        print(regiao);
      }
    }

    _listarMeses(){
      for(var mes in Meses.listaMeses){
        print(mes);
      }

      print(Meses.mapaMeses);
    }

    _listarDiasSemana(){
      for(var dia in Semana.listaDiasSemana){
        print(dia);
      }

      for(var dia in Semana.listaDiasSemanaAbvr){
        print(dia);
      }

      for(var dia in Semana.listaDiasSemanaOrdenada){
        print(dia);
      }

      for(var dia in Semana.listaDiasUteis){
        print(dia);
      }

      print(Semana.mapaDiasSemanaOrdenadaAbvr);
      print(Semana.mapaDiasUteisAbvr);
      print(Semana.mapaDiasSemanaOrdenada);
      print(Semana.mapaDiasUteis);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mascaras e Validações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //CPF
              TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
                decoration: InputDecoration(
                  hintText: "Informe o CPF"
                ),
              ),
              //CPNJ
              TextField(
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter()
                ],
                decoration: InputDecoration(
                  hintText: "Informe o CNPJ"
                ),
              ),
              //CEP
              TextField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
                decoration: InputDecoration(
                  hintText: "Informe o CEP"
                ),
              ),
              //TELEFONE
              TextField(
                controller: _telefoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                decoration: InputDecoration(
                  hintText: "Informe o Telefone"
                ),
              ),
              //DATA
              TextField(
                controller: _dataController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter()
                ],
                decoration: InputDecoration(
                  hintText: "Informe a data"
                ),
              ),
              //MOEDA
              TextField(
                controller: _moedaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: false)
                ],
                decoration: InputDecoration(
                  hintText: "Infome o valor"
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {});
                  //TESTES
                  _formatarMoeda();
                  _listarEstados();
                  _listarRegioes();
                  _listarMeses();
                  _listarDiasSemana();
                },
                child: Text("Recuperar valores"),
              ),
              Text("CPF: ${_cpfController.text.toString()} \n"
                  "CNPJ: ${_cnpjController.text.toString()} \n"
                  "CEP: ${_cepController.text.toString()} \n"
                  "TELEFONE: ${_telefoneController.text.toString()} \n"
                  "MOEDA: ${_moedaController.text.toString()}",
                  style: TextStyle(fontSize: 25)
              )
            ],
          ),
        )
      ),
    );
  }
}
