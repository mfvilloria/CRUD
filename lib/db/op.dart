import 'package:crud/mod/notas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class Op {
  static Future<Database> _OpenDB() async {
    sqfliteFfiInit();
    var databasesPath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasesPath, 'info.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    //await databaseFactory.deleteDatabase(path);

    return databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
          onCreate: (db, version) {
            return db.execute(
                "CREATE TABLE info (id INTEGER PRIMARY KEY, nombre TEXT, apellido TEXT)");
          },
          version: 1,
        ));

    /*var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'info.db');

    await deleteDatabase(path);

    return openDatabase(
        join(await getDatabasesPath(), 'info.db'), onCreate: (db,version){
      return db.execute("CREATE TABLE info (id INTEGER, nombre TEXT, apellido TEXT)");
    }, version: 1);*/
  }

  static Future<void> insert(Nota nota) async {
    Database database = await _OpenDB();

    await database.insert("info", nota.toMap());
  }

  static Future<void> delete(Nota nota) async {
    Database database = await _OpenDB();

    await database.delete("info", where: 'id = ?', whereArgs: [nota.id]);
  }

  static Future<void> update(Nota nota) async {
    Database database = await _OpenDB();

    await database
        .update("info", nota.toMap(), where: 'id = ?', whereArgs: [nota.id]);
  }

  static Future<List<Nota>> notas() async {
    final database = await _OpenDB();

    final List<Map<String, dynamic>> Imaps = await database.query('info');

    for (var n in Imaps) {
      print((n['id']).toString() + ": " + n['nombre'] + " " + n['apellido']);
    }

    return List.generate(
        Imaps.length,
        (i) => Nota(
            id: Imaps[i]['id'],
            Nombre: Imaps[i]['nombre'],
            Apellido: Imaps[i]['apellido']));
  }
}
