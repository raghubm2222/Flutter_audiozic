import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

Color _primaryColor = Color(0xFF060DD9);

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;
  const ProductDetailsScreen({Key? key, @required this.product})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController? _pageController;
  ValueNotifier<int>? _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<int>(0);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _notifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Image.asset(
                'assets/bag.png',
                color: Colors.black,
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lens_blur_rounded, color: _primaryColor),
            Text(
              'Audiozic',
              style: TextStyle(
                color: _primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF3F3FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: size.height * 0.05,
                  width: size.width,
                  child: SizedBox(
                    height: size.height * 0.35,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int index) {
                        _notifier!.value = index;
                      },
                      itemCount: widget.product!.images!.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: 'assets/${widget.product!.images![0]}.png',
                          child: Image.asset(
                            'assets/${widget.product!.images![index]}.png',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _notifier!,
                  builder: (context, _index, __) {
                    if (_index == 0) {
                      return Container();
                    }
                    return Positioned(
                      top: size.height * 0.2,
                      left: 10.0,
                      child: GestureDetector(
                        onTap: () {
                          _pageController!.animateToPage(
                            _index,
                            duration: Duration(milliseconds: 10),
                            curve: Curves.easeIn,
                          );
                          _notifier!.value = _index - 1;
                        },
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundColor:
                              _index == 0 ? Colors.transparent : Colors.white,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: _index == 0
                                ? Colors.transparent
                                : _primaryColor,
                            size: 18.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _notifier!,
                  builder: (context, _index, __) {
                    if (_index == widget.product!.images!.length - 1) {
                      return Container();
                    }
                    return Positioned(
                      top: size.height * 0.2,
                      right: 10.0,
                      child: GestureDetector(
                        onTap: () {
                          _pageController!.animateToPage(
                            _index,
                            duration: Duration(milliseconds: 10),
                            curve: Curves.easeIn,
                          );
                          _notifier!.value = _index + 1;
                        },
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: _primaryColor,
                            size: 18.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                _buildDetails(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align _buildDetails(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Colors',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            ValueListenableBuilder(
              valueListenable: _notifier!,
              builder: (context, _int, _) {
                return Row(
                  children: [
                    for (int i = 0; i < widget.product!.colors!.length; i++)
                      GestureDetector(
                        onTap: () {
                          _notifier!.value = i;
                          _pageController!.animateToPage(
                            i,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            color: widget.product!.colors![i],
                            shape: BoxShape.circle,
                            border: Border.all(width: 3.0, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: _int == i
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.transparent,
                                blurRadius: 1.0,
                                spreadRadius: 3.0,
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
            Spacer(),
            Text(
              'Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(
              'Input Type: 3.5mm stereo jack\nOther Features: Bluetooth, Foldable, Noise Isolation, Stereo, Stereo Bluetooth, Wireless\nForm Factor: On-Ear\nConnections: Bluetooth, Wireless\nSpeaker Configurations: Stereo',
              style: TextStyle(fontSize: 12.0),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F3FF),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
