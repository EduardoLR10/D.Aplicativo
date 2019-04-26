import 'package:flutter/material.dart';
import './assets/images.dart';

class Ajudar extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AjudarState();
  }
}

class AjudarState extends State<Ajudar>{

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold (
      appBar: AppBar(
        title: Text('Ajudar'), //queria que o texto ficasse entre os icones
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.menu,),
            onPressed:(){
              Navigator.pop(context);
            }
          ),
          IconButton(
            icon: new Icon(Icons.search,),
            onPressed: null,
          ),
        ],
      ),


      body: ListView.builder(

        itemCount: 2,
        itemBuilder: (context, index){

          return new Column( // body inteiro
            children: <Widget>[ // animais (ver classe CartaoAnimal)

              new CartaoAnimal("Rex", "dog1.png", "macho", "filhote", "Vai crescer muito", "Na minha casa"),

              new CartaoAnimal("Spike", "dog2.png", "macho", "Adulto", "Maior que tá, não fica", "Na rua debaixo"),

              new CartaoAnimal("Lola", "dog3.png", "fêmea", "jovem", "grande", "No quintal de casa"),

            ],
          );
        }
      ),


    ),
    );
  }
}

class CartaoAnimal extends StatelessWidget{ //cada animal que vai ser mostrado

  final nome;
  final imagem;
  final genero;
  final idade;
  final tamanho;
  final lugar;


  CartaoAnimal(this.nome, this.imagem, this.genero, this.idade, this.tamanho, this.lugar);

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[

        Row( // Nome do animal e icone de favoritar
          children: <Widget>[

            Container( // nome
              child: Text(this.nome),
            ),

            IconButton( // icone  (pode ser mudado)
              icon: new Icon(Icons.favorite_border ),
              onPressed: null,
            ),

          ],
        ),

        new CustomImageWidget(this.imagem, 360.0, 184.0),

        Row( // texto de genero, idade e tamanho
          children: <Widget>[
            Container( // genero
              child: Text(this.genero),
            ),

            Container( // idade
              child: Text(this.idade),
            ),

            Container( // tamanho
              child: Text(this.tamanho),
            ),

          ],
        ),

        Container( // Lugar
          child: Text(this.lugar),
        ),


      ],
    );

  }
}