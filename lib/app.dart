import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/firebase/firebase_auth.dart';
import 'package:karconnect/utils/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: RouteClass.getHomeRoute(),
      getPages: RouteClass.routes,
    );
  }
}

//to navigate another page
//  Get.toNamed('/addPage');  or
// ElevatedButton(
//   onPressed: () {
//     Get.toNamed('/addPage');
//   },
//   child: Text('Go to Add Page'),
// )

// backnavigation
// ElevatedButton(
//   onPressed: () {
//     Get.back();
//   },
//   child: Text('Go back'),
// )

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String massage = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 216, 221, 228),
                label: Text("Enter Email"),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 216, 221, 228),
                label: Text("Enter password"),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                UserCredential? result =
                    await registerWithEmailAndPassword(email, password);
                if (result != null) {
                  // User created successfully
                  setState(() {
                    massage = 'User created: ${result.user!.email}';
                  });
                  print(
                      'User created: ${result.user!.email}'); //to print msg on terminal for debugging
                } else {
                  // Error occurred
                  print('Failed to create user');
                  setState(() {
                    massage =
                        'Failed to create user: ${_emailController.text.trim()}';
                  });
                }
              },
              child: Text('Register User'),
            ),
            SizedBox(
              height: 25,
            ),
            Text(massage)
          ],
        ),
      ),
    );
  }
}
