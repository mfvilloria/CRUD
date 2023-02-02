import '../mod/notas.dart';
import 'package:flutter/material.dart';

import '../db/op.dart';

class SavePage extends StatelessWidget {
  static const String ROUTE = "/save";

  final _FKey = GlobalKey<FormState>();
  final NControler = TextEditingController();
  final AControler = TextEditingController();
  final IControler = TextEditingController();

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

  _init(Nota nota) {
    NControler.text = nota.Nombre;
    AControler.text = nota.Apellido;
    IControler.text = (nota.id).toString();
  }

  Widget _buildForm(Nota nota) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
          key: _FKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: IControler,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == 0) {
                      return "Ingrese informacion diferente a 0.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Identificacion",
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 20,
              ),
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
                      if (nota.id != 0) {
                        //actualizar
                        nota.Nombre = NControler.text;
                        nota.Apellido = AControler.text;
                        print("Estoy editando " + (nota.id).toString());
                        Op.update(nota);
                        IControler.text = "";
                        NControler.text = "";
                        AControler.text = "";

                      } else {
                        //insertar
                          Op.insert(Nota(
                              id: int.parse(IControler.text),
                              Nombre: NControler.text,
                              Apellido: AControler.text));
                          print("Ya inserte");
                          IControler.text = "";
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
