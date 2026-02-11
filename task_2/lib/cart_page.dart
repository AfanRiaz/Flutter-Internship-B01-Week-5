import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/providers.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Shopping Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, i) => ListTile(
                leading: Image.asset(cart.cartItems[i].imagePath),
                title: Text(cart.cartItems[i].name),
                subtitle: Text("\$${cart.cartItems[i].price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => cart.removeFromCart(cart.cartItems[i]),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("\$${cart.calculateTotal}", style: const TextStyle(fontSize: 20, color: Colors.green)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {},
              child: const Text("CHECKOUT"),
            ),
          )
        ],
      ),
    );
  }
}