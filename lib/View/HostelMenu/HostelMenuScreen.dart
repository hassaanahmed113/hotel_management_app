import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HostelMenuScreen extends StatelessWidget {
  const HostelMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weeklyMenu = [
      {
        'day': 'Monday',
        'menu': {
          'dishes': [
            {
              'name': 'Chicken Biryani',
              'type': 'Main Course',
              'icon': Icons.rice_bowl
            },
            {
              'name': 'Palak Gosht',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {'name': 'Kheer', 'type': 'Dessert', 'icon': Icons.icecream}
          ],
          'drink': 'Lassi'
        }
      },
      {
        'day': 'Tuesday',
        'menu': {
          'dishes': [
            {'name': 'Nihari', 'type': 'Main Course', 'icon': Icons.restaurant},
            {
              'name': 'Dal Chawal',
              'type': 'Main Course',
              'icon': Icons.rice_bowl
            },
            {'name': 'Zarda', 'type': 'Dessert', 'icon': Icons.cake}
          ],
          'drink': 'Chai'
        }
      },
      {
        'day': 'Wednesday',
        'menu': {
          'dishes': [
            {'name': 'Karahi', 'type': 'Main Course', 'icon': Icons.restaurant},
            {
              'name': 'Chicken Pulao',
              'type': 'Main Course',
              'icon': Icons.rice_bowl
            },
            {'name': 'Shahi Tukda', 'type': 'Dessert', 'icon': Icons.cake}
          ],
          'drink': 'Rooh Afza'
        }
      },
      {
        'day': 'Thursday',
        'menu': {
          'dishes': [
            {
              'name': 'Mutton Korma',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {
              'name': 'Aloo Keema',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {
              'name': 'Gajar Ka Halwa',
              'type': 'Dessert',
              'icon': Icons.icecream
            }
          ],
          'drink': 'Doodh Patti'
        }
      },
      {
        'day': 'Friday',
        'menu': {
          'dishes': [
            {
              'name': 'Beef Qorma',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {
              'name': 'Mix Sabzi',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {'name': 'Lab-e-Shireen', 'type': 'Dessert', 'icon': Icons.icecream}
          ],
          'drink': 'Mango Shake'
        }
      },
      {
        'day': 'Saturday',
        'menu': {
          'dishes': [
            {
              'name': 'Chicken Karahi',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {
              'name': 'Chana Pulao',
              'type': 'Main Course',
              'icon': Icons.rice_bowl
            },
            {'name': 'Ras Malai', 'type': 'Dessert', 'icon': Icons.cake}
          ],
          'drink': 'Sweet Lassi'
        }
      },
      {
        'day': 'Sunday',
        'menu': {
          'dishes': [
            {
              'name': 'Mutton Biryani',
              'type': 'Main Course',
              'icon': Icons.rice_bowl
            },
            {
              'name': 'Mix Dal',
              'type': 'Main Course',
              'icon': Icons.restaurant
            },
            {'name': 'Gulab Jamun', 'type': 'Dessert', 'icon': Icons.cake}
          ],
          'drink': 'Mint Lemonade'
        }
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff5e35b1),
        title: Text(
          'Hostel Menu',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weeklyMenu.length,
        itemBuilder: (context, index) {
          final dayMenu = weeklyMenu[index];
          return DayMenuCard(
            day: dayMenu['day'] as String,
            menu: dayMenu['menu'] as Map<String, dynamic>,
          );
        },
      ),
    );
  }
}

class DayMenuCard extends StatelessWidget {
  final String day;
  final Map<String, dynamic> menu;

  const DayMenuCard({
    Key? key,
    required this.day,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff5e35b1).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff5e35b1).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xff5e35b1),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  day,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff5e35b1),
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DISHES',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  (menu['dishes'] as List).length,
                  (index) => MenuItem(
                    dish: menu['dishes'][index] as Map<String, dynamic>,
                  ),
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(
                      Icons.local_drink,
                      color: Color(0xff5e35b1),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DRINK',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          menu['drink'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Map<String, dynamic> dish;

  const MenuItem({
    Key? key,
    required this.dish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            dish['icon'] as IconData,
            color: const Color(0xff5e35b1),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish['type'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  dish['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
