import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/providers.dart';

import 'cart_page.dart';
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gadget Store"),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart,child) => Badge(
              label: Text(cart.cartItems.length.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const CartPage())
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 10, mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) => Card(
          child: Column(
            children: [
              Expanded(child: Image.asset(products[i].imagePath, fit: BoxFit.cover)),
              Text(products[i].name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${products[i].price}"),
              TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(60),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 12,right: 12),
                        child: Text("Add to cart"),
                      ),
                    ),
                onPressed: () {
                  context.read<CartProvider>().addToCart(products[i]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart!"), duration: Duration(seconds: 1)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}