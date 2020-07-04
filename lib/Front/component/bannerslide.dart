import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Bannerslide extends StatefulWidget {
  @override
  _BannerslideState createState() => _BannerslideState();
}

class _BannerslideState extends State<Bannerslide> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        height: 200.0,
        child: CarouselSlider(
          // height: 400.0,
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            // autoPlayAnimationDuration: Duration(milliseconds: 800),
            // autoPlayCurve: Curves.fastOutSlowIn,
            // enlargeCenterPage: true,
            // scrollDirection: Axis.horizontal,
          ),
          items: [
            "https://pix10.agoda.net/geo/city/390119/1_390119_02.jpg?s=1920x822",
            "https://asset.kompas.com/crops/kRe0jJVkxUZfV0H8lEnKBntYp6o=/0x0:1000x667/750x500/data/photo/2019/10/23/5db002d6ea913.jpg",
            "https://asset.kompas.com/crops/DtmiwFmdXAZF4Jm5s_2fMI4GMT0=/0x0:1000x667/750x500/data/photo/2019/10/23/5db0032b34181.jpg",
            "https://asset.kompas.com/crops/u1w66BFmLCIP9bvr05kJUphnp8w=/0x0:1000x667/750x500/data/photo/2019/10/23/5db003778dde4.jpg"
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {
                          Navigator.push<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(i),
                            ),
                          );
                        }));
              },
            );
          }).toList(),
        ));

    return Container(
      child: new Column(
        children: <Widget>[
          image_carousel,
        ],
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  final String url;
  ImageScreen(this.url);

  @override
  _MyImageScreen createState() => _MyImageScreen(url);
}

class _MyImageScreen extends State<ImageScreen> {
  final String url;
  _MyImageScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ImageScreen'),
        ),
        body: Image.network(url, width: double.infinity));
  }
}
