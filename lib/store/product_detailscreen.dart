import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'package:get/get.dart';
class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String price;

  ProductDetailsScreen({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header with Image, Back Button, and Share Button
            Stack(
              children: [
                // Product Image as the background
                Container(
                  height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Back Button and Share Button on top of the image
                Positioned(
                  top: 40.0,
                  left: 20.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  right: 20.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Share logic here
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Product Name, Rating, and Brand with Verified Tick
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name with gradient
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade800, Colors.indigo.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orangeAccent, size: 20.0),
                      SizedBox(width: 5),
                      Text(
                        '4.8 (2.3k)',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Health Veda Organics',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.indigo[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.verified, color: Colors.indigoAccent, size: 18.0),
                    ],
                  ),
                  SizedBox(height: 15), // Reduced padding here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[500],
                        ),
                      ),
                      Text(
                        'In Stock',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.indigo[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Reduced padding here
                ],
              ),
            ),

            // Product Description with Less/More Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    isExpanded
                        ? 'Multi Veda Tablets are designed to provide a wide range of essential nutrients to support overall health. It contains herbal extracts and essential vitamins that promote wellness and vitality. Recommended for daily use.'
                        : 'Multi Veda Tablets are designed to provide a wide range of essential nutrients to support overall health. It contains herbal extracts...',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Less' : 'More',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[500],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // Checkout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: ()=> Get.to(()=>CartScreen()) ,
                    // Checkout logic here
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                    backgroundColor: Colors.indigo[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5.0,
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
