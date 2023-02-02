import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_ui/coffee/coffee_home.dart';
import 'package:practice_ui/credit_card/dashboard.dart';
import 'package:practice_ui/daily_exercise/daily_home.dart';
import 'package:practice_ui/effort/effort_home.dart';
import 'package:practice_ui/furniture/home/product_screen.dart';
import 'package:practice_ui/pet/pet_main.dart';
import 'package:practice_ui/plant/home/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff392850),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 110,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hieu's UI",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  GridDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Items item1 = Items(
        title: "Credit Card",
        subtitle: "UI for banking",
        page: "2 pages",
        img: "assets/icons/credit_card.png",
        onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DashboardPage()))
    );
    Items item2 = Items(
      title: "Daily Exercise",
      subtitle: "UI for daily exercise",
      page: "4 pages",
      img: "assets/icons/yoga.png",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DailyHome()))
    );
    Items item3 = Items(
      title: "Plant",
      subtitle: "UI for rent plant",
      page: "2 pages",
      img: "assets/icons/flower.png",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomeScreen()))
    );
    Items item4 = Items(
      title: "Effortlessly",
      subtitle: "UI for effort",
      page: "1 pages",
      img: "assets/icons/user.png",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HelpSection()))
    );
    Items item5 = Items(
      title: "Pet",
      subtitle: "UI for pet",
      page: "4 pages",
      img: "assets/images/cat.png",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PetMain()))
    );
    Items item6 = Items(
      title: "Furniture",
      subtitle: "UI for furniture",
      page: "2 pages",
      img: "assets/images/Item_1.png",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductsScreen()))
    );
    Items item7 = Items(
      title: "Coffee",
      subtitle: "UI for coffee shop",
      page: "2 pages",
      img: "assets/images/capuchino.jpg",
      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CoffeeHome()))
    );
    List<Items> myList = [item1, item2, item3, item4, item5, item6, item7];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: data.onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img!,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title!,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle!,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.page!,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  GestureTapCallback? onTap;
  String? title;
  String? subtitle;
  String? page;
  String? img;
  Items({this.title, this.subtitle, this.page, this.img,this.onTap});
}