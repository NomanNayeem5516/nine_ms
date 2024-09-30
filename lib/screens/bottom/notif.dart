import 'package:flutter/material.dart';

import '../../models/featutedProduct.dart';
import '../../networkManager/repository.dart';
class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  bool isLoading = true;
  FeaturedProducts products = FeaturedProducts();

  @override
  void initState() {
    super.initState();
    fetchFeaturedProducts();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      FeaturedProducts fetchedProducts = await Repository().getFeaturedProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching featured products: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : products.data != null && products.data!.isNotEmpty
          ? ListView.builder(
        itemCount: products.data!.length,
        itemBuilder: (context, index) {
          Data productData = products.data![index];
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
