import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Picture Crousel",
      debugShowCheckedModeBanner: false,
      home: Crousel(),
    );
  }
}

class Crousel extends StatefulWidget {
  const Crousel({Key? key}) : super(key: key);

  @override
  State<Crousel> createState() => _CrouselState();
}

class _CrouselState extends State<Crousel> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation Crousel;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 15));
    Crousel = IntTween(begin: 0, end: PicName.length - 1).animate(controller);
    controller.repeat();
    controller.addListener(() {
      setState(() {
        PicNmbr = Crousel.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int PicNmbr = 0;
  List<String> PicName = [
    "Assets/Burger1.jpg",
    "Assets/Burger2.jpg",
    "Assets/Burger3.jpg",
    "Assets/Burger4.jpg",
    "Assets/Burger5.jpg",
  ];

  nextImage() {
    setState(() {
      print("next got pressed");
      PicNmbr < PicName.length - 1 ? PicNmbr++ : PicNmbr;
    });
  }

  previous() {
    setState(() {
      print("previous got pressed");
      PicNmbr > 0 ? PicNmbr-- : PicNmbr;
    });
  }

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  PicName[PicNmbr],
                  fit: BoxFit.cover,
                ),
              ),
              // Container(
              //   height: 300,
              //   width: devwidth,
              //   child: GestureDetector(
              //     onTap: nextImage,
              //   ),
              // ),
              // Container(
              //   height: 300,
              //   width: devwidth / 2,
              //   child: GestureDetector(
              //     onTap: previous,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 35,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 265,
                  left: 60,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "4.7",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      BuildDots(
                        length: PicName.length,
                        photoindex: PicNmbr,
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Open now till 7 PM",
                  style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "The Cinnamon Snail",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 37,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "7th st & Union Sq East 400ft away ",
                  style: TextStyle(
                      fontSize: 26,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.wifi,
                      color: Colors.green.shade300,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text(
                      "Location confirmed by 3 users today",
                      style:
                          TextStyle(fontSize: 19, color: Colors.green.shade300),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}

class BuildDots extends StatelessWidget {
  int? photoindex;
  int? length;
  BuildDots({this.length, this.photoindex});
  ActiveDots() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(width: 2, color: Colors.white)),
      ),
    );
  }

  InActiveDots() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 17,
        width: 17,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.grey)),
      ),
    );
  }

  List<Widget> buildD() {
    List<Widget> Dots = [];
    for (int i = 0; i < length!.toInt(); i++) {
      Dots.add(i == photoindex ? ActiveDots() : InActiveDots());
    }
    return Dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: buildD(),
      ),
    );
  }
}
