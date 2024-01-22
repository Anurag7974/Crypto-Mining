import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>{
  late Stream<QuerySnapshot>imageStream;
  int currentSliderIndex = 0;
  CarouselController carouselController = CarouselController();
  @override
  void initState(){
    super.initState();
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("banners").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: imageStream,
              builder: (_, snapshot){
                if(snapshot.hasData && snapshot.data!.docs.length>1){
                  return CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: snapshot.data!.docs.length, itemBuilder: (_,index,___){
                    DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                    return Image.network(sliderImage["imageUrl"], fit: BoxFit.contain,);
                  }, options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}