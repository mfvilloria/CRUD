import '../mod/notas.dart';
import 'package:flutter/material.dart';

import '../db/op.dart';

class SavePage extends StatefulWidget {
  static const String ROUTE = "/save";

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _FKey = GlobalKey<FormState>();
  final NControler = TextEditingController();
  final AControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Nota? nota = ModalRoute.of(context)!.settings.arguments as Nota?;
    _init(nota!);
    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Container(
        child: _buildForm(nota),
      ),
    );
  }

  void showMyDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Registro modificado con exitó.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
                NControler.text = "";
                AControler.text = "";
              },
            ),
          ],
        );
      },
    );
  }

  _init(Nota nota) {
    NControler.text = nota.Nombre;
    AControler.text = nota.Apellido;
  }

  Widget _buildForm(Nota nota) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
          key: _FKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: NControler,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese la informacion solicitada";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: AControler,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese la informacion solicitada";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Apellido",
                  border: OutlineInputBorder(),
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    elevation: 3,
                  ),
                  onPressed: () {
                    if (_FKey.currentState!.validate()) {
                      if (nota.id != null) {
                        //actualizar
                        nota.Nombre = NControler.text;
                        nota.Apellido = AControler.text;
                        print("Estoy editando " + (nota.id).toString());
                        Op.update(nota);
                        showMyDialog();
                      } else {
                        //insertar
                        Op.insert(Nota(
                            Nombre: NControler.text,
                            Apellido: AControler.text));
                        print("Ya inserte");
                        NControler.text = "";
                        AControler.text = "";
                      }
                      //print("valor Nombre: " +NControler.text+ " y apellido: " +AControler.text);

                    }
                  },
                  child: Text("Guardar"))
            ],
          )),
    );
  }
}
