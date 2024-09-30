import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import '../../models/slider.dart';
import '../../networkManager/repository.dart'; // Adjust this import path accordingly

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> sliderImages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSliders();
  }

  Future<void> fetchSliders() async {
    try {
      Sliders sliders = await Repository().getSliders(); // Fetching sliders from the repository
      setState(() {
        sliderImages = sliders.data!.map((slider) => slider.photo!).toList();
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_ios_rounded,
                              color: Colors.white, size: 30),
                          Icon(Icons.search_outlined,
                              color: Colors.white, size: 30)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Loading state
                : sliderImages.isEmpty
                ? Center(child: Text("No sliders available")) // Empty state
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                      ),
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
        ],
      ),
    );
  }
}
