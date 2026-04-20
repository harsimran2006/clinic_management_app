import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //One database connection for the whole app
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  //Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('clinic_management.db');
    return _database!;
  }

  //Initialise database file
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // USERS TABLE
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        role TEXT
      )
    ''');

    // CLINICS TABLE
    await db.execute('''
      CREATE TABLE clinics (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        phone TEXT NOT NULL UNIQUE,
        description TEXT,
        latitude TEXT,
        longitude TEXT
      )
    ''');

    // PATIENTS TABLE
    await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        phone TEXT NOT NULL UNIQUE,
        email TEXT,
        clinic_id INTEGER,
        FOREIGN KEY (clinic_id) REFERENCES clinics(id)
      )
    ''');

    // APPOINTMENTS TABLE
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

  // USERS
  //Register new user
  Future<int> registerUser(String username, String password) async {
    final db = await instance.database;
    return await db.insert('users', {
      'username': username,
      'password': password,
    });
  }

  //Login user by checking username and password
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // CLINICS
  //Insert a new clinic
  Future<int> insertClinic(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('clinics', row);
  }

  //Get all clinics
  Future<List<Map<String, dynamic>>> getClinics() async {
    final db = await instance.database;
    return await db.query('clinics');
  }

  // PATIENTS
  //Insert a new patient
  Future<int> insertPatient(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('patients', row);
  }

  //get all patients
  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await instance.database;
    return await db.query('patients');
  }

  // APPOINTMENTS
  //Insert a new appointment
  Future<int> insertAppointment(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('appointments', row);
  }

  //Get all appointments
  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await instance.database;
    return await db.query('appointments');
  }

  //Get appointment with patients and clinic namea
  Future<List<Map<String, dynamic>>> getAppointmentsWithNames() async {
    final db = await database;

    final result = await db.rawQuery('''
      SELECT 
        appointments.id,
        appointments.date,
        appointments.time,
        appointments.reason,
        patients.name AS patient_name,
        clinics.name AS clinic_name
      FROM appointments
      INNER JOIN patients ON appointments.patient_id = patients.id
      INNER JOIN clinics ON appointments.clinic_id = clinics.id
      ORDER BY appointments.id DESC
    ''');

    return result;
  }

  // ---------------- CLOSE ----------------

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
