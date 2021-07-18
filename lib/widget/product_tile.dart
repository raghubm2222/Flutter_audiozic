import 'package:audiozic/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'smooth_star_rating.dart';

class ProductTile extends StatelessWidget {
  final Product? product;
  const ProductTile({
    Key? key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.0),
            color: Colors.grey.shade100,
            blurRadius: 5.0,
            spreadRadius: 1.5,
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: product!.isFav! ? Colors.redAccent : Colors.grey,
              radius: 10.0,
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 11.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 100.0,
              child: Hero(
                tag: 'assets/${product!.images![0]}.png',
                child: Image.asset('assets/${product!.images![0]}.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.title!,
                  style: TextStyle(fontSize: 12.0),
                ),
                SmoothStarRating(
                  color: Colors.yellow,
                  borderColor: Colors.yellow,
                  rating: 4.0,
                  starCount: 5,
                  size: 12.0,
                ),
                Text(
                  '\$${product!.price.toString()}',
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Color _primaryColor = Color(0xFF060DD9);
