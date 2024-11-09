import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.indigoAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: GestureDetector(
                    onTap: () {
                      // Add logic for changing profile picture
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: const [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150', // Replace with profile image URL
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Iconsax.camera,
                            color: Colors.indigoAccent,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Adjust spacing for the profile picture

            // Username and Email
            Column(
              children: const [
                Text(
                  "John Doe", // Replace with dynamic username
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "johndoe@example.com", // Replace with dynamic email
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Personal Details Section
            _buildSectionHeading("Personal Details"),
            _buildListTile(
              icon: Iconsax.location,
              title: "Address",
              subtitle: "Manage your delivery address",
              onTap: () {},
            ),
            _buildListTile(
              icon: Iconsax.home,
              title: "Billing Address",
              subtitle: "Set up your billing address",
              onTap: () {},
            ),
            _buildListTile(
              icon: Iconsax.gift,
              title: "Offers & Coupons",
              subtitle: "View available offers and discounts",
              onTap: () {},
            ),
            _buildListTile(
              icon: Iconsax.card,
              title: "Payment Methods",
              subtitle: "Manage your saved cards and UPI",
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // App Settings Section
            _buildSectionHeading("App Settings"),
            _buildListTile(
              icon: Iconsax.notification,
              title: "Notifications",
              subtitle: "Manage notification preferences",
              onTap: () {},
            ),
            _buildListTile(
              icon: Iconsax.security,
              title: "Privacy Settings",
              subtitle: "Control your privacy options",
              onTap: () {},
            ),
            const SizedBox(height: 30),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // Add logout logic
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Section Heading Widget
  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ListTile Widget for Menu Options
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.indigoAccent, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
