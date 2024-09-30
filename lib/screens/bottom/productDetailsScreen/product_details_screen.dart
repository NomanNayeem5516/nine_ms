import 'package:flutter/material.dart';

import '../../../models/featutedProduct.dart';
class ProductDetailsScreen extends StatelessWidget {
  final Data productData;

  const ProductDetailsScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[100],
      appBar: AppBar(
      backgroundColor: Colors.grey[100],
        title: Text(productData.name ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productData.thumbnailImage != null
                ? Image.network(productData.thumbnailImage!)
                : const Icon(Icons.image_not_supported),
            const SizedBox(height: 16),
            Text(
              productData.name ?? 'Unknown Product',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ${productData.mainPrice ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            productData.hasDiscount == true
                ? Text(
              'Discounted Price: ${productData.strokedPrice ?? 'N/A'}',
              style: const TextStyle(fontSize: 18, color: Colors.red),
            )
                : const Text('No Discount Available'),
            const SizedBox(height: 16),
            productData.rating != null
                ? Text('Rating: ${productData.rating}')
                : const Text('No Rating Available'),
            const SizedBox(height: 16),
            productData.sales != null
                ? Text('Sales: ${productData.sales}')
                : const Text('No Sales Data Available'),
          ],
        ),
      ),
    );
  }
}