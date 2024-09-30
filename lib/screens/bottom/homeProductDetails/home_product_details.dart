import 'package:flutter/material.dart';
import '../../../models/todaysdeal.dart';

class HomeProductDetails extends StatelessWidget {
  final ProductData productData;

  const HomeProductDetails({super.key, required this.productData});

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              productData.thumbnailImage != null
                  ? Center(
                      child: Image.network(
                        productData.thumbnailImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported, size: 100)),

              const SizedBox(height: 20),

              Text(
                productData.name ?? "Product Name",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Text(
                'Price: ${productData.mainPrice ?? '\$0.00'}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 10),

              productData.hasDiscount == true
                  ? Text(
                      'Discounted Price: ${productData.strokedPrice ?? ''}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),

              productData.rating != null
                  ? Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 5),
                        Text(
                          'Rating: ${productData.rating}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  : const Text('No Rating Available',
                      style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              productData.sales != null
                  ? Text('Sales: ${productData.sales}',
                      style: const TextStyle(fontSize: 18))
                  : const Text('No Sales Data Available',
                      style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
