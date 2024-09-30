import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        height: 250,
        child:Stack(
          children: [
            Container(
              height: 100,
              padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  
                )
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 30,),
                      Icon(Icons.search_outlined,color: Colors.white,size: 30,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
