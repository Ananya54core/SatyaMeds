import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satyameds/store/product_detailscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicinalPlantStoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Applying a gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade100, Colors.indigo.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Section with Title and Search Icon
                      _buildHeader(),

                      SizedBox(height: 20),

                      // Shopkeepers Section
                      Text(
                        'Our Shopkeepers',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigoAccent,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildShopkeepersGrid(),

                      SizedBox(height: 30),

                      // Locate Nearby Shops Button with Icon
                      ElevatedButton.icon(
                        onPressed: () {
                          const link = "https://vruksham.vercel.app/";
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.inAppWebView);
                        },
                        icon: Icon(Icons.location_on, size: 24.0),
                        label: Text(
                          'Locate Nearby Shops',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          backgroundColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 5.0,
                        ),
                      ),

                      SizedBox(height: 30),

                      // Products Section
                      Text(
                        'Our Products',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigoAccent,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildProductsGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header Widget
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SatyaMeds Store',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent,
          ),
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.indigo[800]),
          onPressed: () {
            // Search logic
          },
        ),
      ],
    );
  }

  // Shopkeepers Grid
  Widget _buildShopkeepersGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _shopkeepers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final shopkeeper = _shopkeepers[index];
        return _buildShopkeeperCard(shopkeeper);
      },
    );
  }

  // Products Grid
  Widget _buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 2 / 3, // Adjusted aspect ratio for taller cards
      ),
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductCard(product);
      },
    );
  }

  // Product Card
  Widget _buildProductCard(Map<String, String> product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: InkWell(
        onTap: () =>
            Get.to(() =>
                ProductDetailsScreen(name: 'Multi Veda Tablets',
                  price: '₹159.99',
                  imagePath: 'assets/onboarding/pr1.png',)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                product['imagePath']!,
                height: 100, // Increased height
                width: 100, // Increased width
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            // Product Name
            Text(
              product['name']!,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
            SizedBox(height: 5),
            // Product Price
            Text(
              product['price']!,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shopkeeper Card
  Widget _buildShopkeeperCard(Map<String, String> shopkeeper) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Column(
        children: [
          // Shopkeeper Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              shopkeeper['imagePath']!,
              height: 70, // Increased height
              width: 70, // Increased width
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          // Shopkeeper Name
          Flexible(
            child: Text(
              shopkeeper['name']!,
              style: TextStyle(
                fontSize: 14.0, // Kept the font size slightly reduced
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5),
          // Distance and Verified Icon
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 14.0, color: Colors.indigoAccent),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    shopkeeper['distance']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.verified,
                  color: Colors.indigo,
                  size: 14.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sample data for shopkeepers
  final List<Map<String, String>> _shopkeepers = [
    {
      'name': 'Ram Parekh',
      'imagePath': 'assets/onboarding/shop1.png',
      'distance': '2.5 km',
    },
    {
      'name': 'Priya Pal',
      'imagePath': 'assets/onboarding/shop2.png',
      'distance': '1.8 km',
    },
    {
      'name': 'Palash Mittal',
      'imagePath': 'assets/onboarding/shop3.png',
      'distance': '3.2 km',
    },
  ];

  // Sample data for products
  final List<Map<String, String>> _products = [
    {
      'name': 'Multi Veda Tablets',
      'imagePath': 'assets/onboarding/pr1.png',
      'price': '₹159.99', // Ensure consistency in currency symbols
    },
    {
      'name': 'Patoladi Jar',
      'imagePath': 'assets/onboarding/pr2.png',
      'price': '₹220.49',
    },
    {
      'name': 'Aroplex Capsule',
      'imagePath': 'assets/onboarding/pr3.png',
      'price': '₹188.75',
    },
    {
      'name': 'Gokshura Tablets',
      'imagePath': 'assets/onboarding/pr4.png',
      'price': '₹1222.50',
    },
  ];
}
