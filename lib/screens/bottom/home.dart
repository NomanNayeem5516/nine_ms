import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../components/details_button.dart';
import '../../models/featured.dart';
import '../../models/slider.dart';
import '../../models/todaysdeal.dart';
import '../../networkManager/repository.dart';
import 'homeProductDetails/home_product_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> sliderImages = [];
  List<CategoryData> categories = [];
  List<ProductData> todaysDealProducts = [];
  bool isLoadingSliders = true;
  bool isLoadingCategories = true;
  bool isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    fetchSliders();
    fetchFeaturedCategories();
    fetchTodaysDealProducts();
  }

  Future<void> fetchSliders() async {
    try {
      Sliders sliders = await Repository().getSliders(); // Fetching sliders
      setState(() {
        sliderImages = sliders.data!.map((slider) => slider.photo!).toList();
        isLoadingSliders = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoadingSliders = false;
      });
    }
  }

  Future<void> fetchFeaturedCategories() async {
    try {
      Categories categoryResponse =
          await Repository().getFeaturedCategories(); // Fetching categories
      setState(() {
        categories = categoryResponse.data!;
        isLoadingCategories = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  Future<void> fetchTodaysDealProducts() async {
    try {
      Products products = await Repository()
          .getTodaysDealProducts(); // Fetching today's deal products
      setState(() {
        todaysDealProducts = products.data!;
        isLoadingProducts = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoadingProducts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sliders Section
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.white, size: 30),
                        Icon(Icons.search_outlined,
                            color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Carousel Slider
            SizedBox(
              height: 100,
              width: double.infinity,
              child: isLoadingSliders
                  ? const Center(child: CircularProgressIndicator())
                  : sliderImages.isEmpty
                      ? const Center(child: Text("No sliders available"))
                      : CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: sliderImages.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.amberAccent),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
            ),
            const SizedBox(height: 20),
            // Featured Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Featured Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 60,
              child: isLoadingCategories
                  ? Center(child: CircularProgressIndicator())
                  : categories.isEmpty
                      ? const Center(child: Text("No categories available"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child:
                                            Text(category.name ?? "Unknown")),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            // Today's Deal Products Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Today\'s Deals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: isLoadingProducts
                  ? const Center(child: CircularProgressIndicator())
                  : todaysDealProducts.isEmpty
                      ? const Center(
                          child: Text("No today's deal products available"))
                      : ListView.builder(
                          //scrollDirection: Axis.horizontal,
                          itemCount: todaysDealProducts.length,
                          itemBuilder: (context, index) {
                            final product = todaysDealProducts[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: product.thumbnailImage != null
                                        ? Image.network(
                                            product.thumbnailImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.image),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.name ?? "Product Name",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.mainPrice ?? "\$0.00",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  product.hasDiscount ?? false
                                      ? Text(
                                          product.strokedPrice ?? "",
                                          style: const TextStyle(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        )
                                      : Container(),
                                  DetailsButton(
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeProductDetails(
                                                  productData: product),
                                        ),
                                      );
                                    },
                                    child: const Text('Details'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
