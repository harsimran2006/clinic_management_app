import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('clinic_management.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE clinics (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        phone TEXT NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        phone TEXT NOT NULL,
        email TEXT,
        clinic_id INTEGER,
        FOREIGN KEY (clinic_id) REFERENCES clinics(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER,
        clinic_id INTEGER,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        reason TEXT,
        FOREIGN KEY (patient_id) REFERENCES patients(id),
        FOREIGN KEY (clinic_id) REFERENCES clinics(id)
      )
    ''');
  }

  // ---------------- USERS CRUD ----------------

  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ---------------- CLINICS CRUD ----------------

  Future<int> insertClinic(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('clinics', row);
  }

  Future<List<Map<String, dynamic>>> getClinics() async {
    final db = await instance.database;
    return await db.query('clinics');
  }

  // ---------------- PATIENTS CRUD ----------------

  Future<int> insertPatient(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('patients', row);
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  // ---------------- APPOINTMENTS CRUD ----------------

  Future<int> insertAppointment(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('appointments', row);
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await instance.database;
    return await db.query('appointments');
  }

  // ---------------- CLOSE DB ----------------

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
