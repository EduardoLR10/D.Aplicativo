import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'cadastro_pessoal_elementos.dart';
import 'package:flutter_test/flutter_test.dart';
import '../common.dart';
import '../use_camera.dart';


class CadastroPage extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xff88c9bf),
    ));
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfffafafa),
      drawer: MyDrawer(name: 'Giordano Monteiro', image: 'assets/cat1.png',),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ContBar(text: 'Cadastro Pessoal', scaffoldKey: scaffoldKey,),
          CadPForm(),
        ],
      ),
    );
  }
}

class CadPForm extends StatefulWidget {
  
  @override
  CadPFormState createState(){
    return CadPFormState();
  }
}

class CadPFormState extends State<CadPForm> {
  final _formKey = GlobalKey<FormState>();
  String cidade;
  String confsenha;
  String email;
  String endereco;
  String estado;
  String idade;
  String nomecompleto;
  String nomeuser;
  String senha;
  String telefone;
  
  String strings;

  callback(newString) {
    setState(() {
      strings = newString;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    nomecompleto = strings;
    return Form(
      key: _formKey,
      child:  Expanded (child: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              CadInfoText(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              SectionTitle(title: 'INFORMAÇÕES PESSOAIS',),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              CadPTextField(text: 'Nome completo', strings: strings, callback: callback, obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Idade', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
                CadPTextField(text: 'E-mail', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Estado', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Cidade', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Endereço', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Telefone', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              SectionTitle(title: 'INFORMAÇÕES DE PERFIL',),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              CadPTextField(text: 'Nome de Usuário', obscure: false,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Senha', obscure: true),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              CadPTextField(text: 'Confirmação de Senha', obscure: true),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              SectionTitle(title: 'FOTO DE PERFIL',),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              ImageBox(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              FlatButton(
                child: CadPButtonCont(text: TextButCad("FAZER CADASTRO")),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ],
          );
        }
      ),)
    );
  }
}

class ImageBox extends StatefulWidget {
  @override
  ImageBoxState createState(){
    return ImageBoxState();
  }
}
class ImageBoxState extends State<ImageBox>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {Navigator.push(context,
            new MaterialPageRoute(
                builder: (context) => new TakePicture(camera: cameras[0])));},
        child: Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.center,
            constraints: BoxConstraints(),
            height: 128,
            width: 128,
            decoration:
            BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Color(0xffe6e7e7),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.control_point, size: 24, color: Color(0xff757575),),
                Text('adicionar foto',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff757575),
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
        ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  SectionTitle({this.title:'Main'});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: 312, maxHeight: 30),
      child: Text(title ,textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xff88c9bf),
        fontSize: 14.0,
        ),
      ),
    );
  }
}

class CadInfoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      alignment: Alignment.center,
      constraints: BoxConstraints(),
      width: 328,
      height: 80,
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xffcfe9e5),
      ),
      child: Text('As informações preenchidas serão divulgadas\n'
          'apenas para a pessoa com a qual você realizar\n'
          'o processo de adoção e/ou apadrinhamento,\n'
          'após a formalização do processo.' ,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xff434343),
          fontSize: 14.0,
        ),
      ),
    );
  }
}
