import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final user = await DatabaseHelper.instance.login(email, password);

      setState(() {
        isLoading = false;
      });

      if (user != null) {
        // Login success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? "Enter email"
                        : null,
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? "Enter password"
                        : null,
              ),

              SizedBox(height: 25),

              isLoading
                  ? CircularProgressIndicator(color: Colors.teal)
                  : ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: Text("Login", style: TextStyle(fontSize: 16)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
