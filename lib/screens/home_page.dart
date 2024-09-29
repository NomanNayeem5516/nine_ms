import 'package:flutter/material.dart';
import '../models/slider.dart';
import '../networkManager/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  Sliders sliders = Sliders();

  @override
  void initState() {
    super.initState();
    fetchSliders();
  }

  Future<void> fetchSliders() async {
    try {
      Sliders fetchedSliders = await Repository().getSliders();
      setState(() {
        sliders = fetchedSliders;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching sliders: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Images'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading spinner
          : sliders.data != null && sliders.data!.isNotEmpty
          ? ListView.builder(
        itemCount: sliders.data!.length,
        itemBuilder: (context, index) {
          Data sliderData = sliders.data![index];
          return ListTile(
            leading: sliderData.photo != null
                ? Image.network(
              sliderData.photo!,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Error icon
              },
            )
                : const Icon(Icons.image_not_supported),
            title: Text('Slider ${index + 1}'),
          );
        },
      )
          : const Center(child: Text('No Sliders Available')),
    );
  }
}
