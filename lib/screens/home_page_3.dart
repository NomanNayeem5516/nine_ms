import 'package:flutter/material.dart';

import '../models/todaysdeal.dart';
import '../networkManager/repository.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  bool isLoading = true;
  Products products = Products();

  @override
  void initState() {
    super.initState();
    fetchTodaysDealProducts();
  }

  Future<void> fetchTodaysDealProducts() async {
    try {
      Products fetchedProducts = await Repository().getTodaysDealProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching today\'s deal products: $error');
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Deal'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : products.data != null && products.data!.isNotEmpty
          ? ListView.builder(
        itemCount: products.data!.length,
        itemBuilder: (context, index) {
          ProductData productData = products.data![index];
          return ListTile(
            leading: productData.thumbnailImage != null
                ? Image.network(
              productData.thumbnailImage!,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Error icon
              },
            )
                : const Icon(Icons.image_not_supported),
            title: Text(productData.name ?? 'Unknown Product'),
            subtitle: productData.id != null
                ? Text('\$${productData.id!.toStringAsFixed(2)}')
                : const Text('Price not available'),
          );
        },
      )
          : const Center(child: Text('No Products Available')),
    );
  }
}
