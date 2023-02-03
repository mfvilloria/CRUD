import 'package:crud/pag/guard.dart';
import 'package:flutter/material.dart';

import '../db/op.dart';
import '../mod/notas.dart';

class ListP extends StatelessWidget {

  static const String ROUTE = "/";

  @override
  Widget build(BuildContext context) {

    return MyList();
  }
}

class MyList extends StatefulWidget {

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<Nota> notas = [];

  @override
  void initState() {
    // TODO: implement initState
    _CargarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: (){
        Navigator.pushNamed(context, SavePage.ROUTE, arguments: Nota.empty(null,"","")).then((value) => setState((){
          _CargarDatos();
        }));;
      },),
      appBar: AppBar(title: Text("Listado de registros"),),
      body: Container (child: ListView.builder(
        itemCount: notas.length,
        itemBuilder: (_,i) => createItem(i),
      ),),
    );

  }

  _CargarDatos() async{
    List<Nota> auxNota = await Op.notas();

    setState(() {
      notas = auxNota;
    });
  }

  createItem(int i) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white,)),
      ),
      onDismissed: (direction){
        print(direction);
        Op.delete(notas[i]);
      },
      child: ListTile(
        title: Text(notas[i].Nombre+" "+notas[i].Apellido),
        trailing: MaterialButton(
            onPressed: (){
              Navigator.pushNamed(context, SavePage.ROUTE, arguments: notas[i]).then((value) => setState((){
                _CargarDatos();
              }));
            },
            child: Icon(Icons.update, color: Colors.blue)),
      ),
    );
  }
}


