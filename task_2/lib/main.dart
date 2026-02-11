import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/product_list.dart';
import 'providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ProductListPage(),
    );
  }
}