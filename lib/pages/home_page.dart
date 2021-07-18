import 'package:audiozic/pages/product_details_page.dart';
import 'package:audiozic/widget/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color _primaryColor = Color(0xFF060DD9);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int>? _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _notifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _buildBNB(),
    );
  }

  CupertinoTabBar _buildBNB() {
    return CupertinoTabBar(
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 22.0,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.grey,
            size: 22.0,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.transparent,
            size: 22.0,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.news,
            color: Colors.grey,
            size: 22.0,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.grey,
            size: 22.0,
          ),
        ),
      ],
    );
  }

  Container _buildFAB() {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: _primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3.0,
          color: Colors.white,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.0),
            color: _primaryColor.withOpacity(0.15),
            spreadRadius: 1.5,
            blurRadius: 5.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: 30.0,
        child: Image.asset('assets/bag.png'),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24.0,
            child: Image.asset('assets/logo.png'),
          ),
          Text(
            'Audiozic',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      leading: Container(
        padding: EdgeInsets.all(20.0),
        child: Image.asset('assets/menuIcon.png'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.search,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text(
              'Choose Brand',
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    _buildBrand(image: images[i], index: i),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Beats Products',
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (contex) => ProductDetailsScreen(
                          product: _products[index],
                        ),
                      ),
                    );
                  },
                  child: ProductTile(
                    product: _products[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand({required String image, required int index}) {
    return ValueListenableBuilder(
      valueListenable: _notifier!,
      builder: (context, _index, _) {
        return GestureDetector(
          onTap: () {
            _notifier!.value = index;
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            height: 64,
            width: 100.0,
            child: SizedBox(
              height: 30.0,
              child: Image.asset('assets/$image.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: _index == index
                      ? Colors.grey.shade100
                      : Colors.transparent,
                  spreadRadius: 2.0,
                  blurRadius: 5.0,
                  offset: Offset(0, 8.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Product {
  final String? title;
  final double? price;
  final bool? isFav;
  final List<Color>? colors;
  final List<String>? images;

  Product({
    @required this.title,
    @required this.price,
    @required this.colors,
    @required this.images,
    this.isFav = false,
  });
}

List<Product> _products = [
  Product(
    title: 'Beats Solo3',
    price: 249.6,
    colors: [Colors.purple, Colors.redAccent, Colors.tealAccent],
    images: ['purple', 'pink', 'blue'],
    isFav: true,
  ),
  Product(
    title: 'Beats Solo Pro',
    price: 160.6,
    colors: [Colors.redAccent, Colors.purple, Colors.tealAccent],
    images: ['pink', 'purple', 'blue'],
  ),
  Product(
    title: 'Beats Solo',
    price: 225.86,
    colors: [Colors.blue, Colors.purple, Colors.red],
    images: ['blue', 'purple', 'red'],
  ),
  Product(
    title: 'Beats EP',
    price: 140.86,
    colors: [Colors.red, Colors.blue, Colors.red],
    images: ['deepred', 'blue', 'red'],
  ),
];

var images = ['beats', 'jbl', 'akg'];
