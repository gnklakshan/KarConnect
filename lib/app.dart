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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = "aaaa@gmail.com";
                String password = "12345678";
                UserCredential? result =
                    await registerWithEmailAndPassword(email, password);
                if (result != null) {
                  // User created successfully
                  print(
                      'User created: ${result.user!.email}'); //to print msg on terminal for debugging
                } else {
                  // Error occurred
                  print('Failed to create user');
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
