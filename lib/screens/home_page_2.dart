import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/featured.dart';

import '../networkManager/repository.dart';



class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool isLoading = true;
  Categories categories = Categories();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      Categories fetchedCategories = await Repository().getFeaturedCategories();
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Categories'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : categories.data != null && categories.data!.isNotEmpty
          ? ListView.builder(
        itemCount: categories.data!.length,
        itemBuilder: (context, index) {
          CategoryData categoryData = categories.data![index];
          return ListTile(
            leading: categoryData.icon != null
                ? Image.network(
              categoryData.icon!,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Error icon
              },
            )
                : const Icon(Icons.image_not_supported),
            title: Text(categoryData.name ?? 'Unknown Category'),
          );
        },
      )
          : const Center(child: Text('No Categories Available')),
    );
  }
}
