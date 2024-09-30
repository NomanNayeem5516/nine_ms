import 'package:flutter/material.dart';
import 'package:nine_ms/components/details_button.dart';
import 'package:nine_ms/screens/bottom/productDetailsScreen/product_details_screen.dart';

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
      FeaturedProducts fetchedProducts =
          await Repository().getFeaturedProducts();
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Featured Products'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.data != null && products.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: products.data!.length,
                  itemBuilder: (context, index) {
                    Data productData = products.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        color: Colors.grey[100],
                        child: ListTile(
                          leading: productData.thumbnailImage != null
                              ? Image.network(
                                  productData.thumbnailImage!,
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                        Icons.error); // Error icon
                                  },
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(productData.name ?? 'Unknown Product'),
                          subtitle: productData.strokedPrice != null
                              ? Text('\$${productData.strokedPrice}')
                              : const Text('Price not available'),
                          trailing: DetailsButton(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      productData: productData),
                                ),
                              );
                            },
                            child: const Text('Details'),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No Products Available')),
    );
  }
}
