import 'package:again/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HostelFeesScreen extends StatelessWidget {
  HostelFeesScreen({Key? key}) : super(key: key);
  final userController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: userController,
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0XFF5E35B1),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Hostel Fees',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0XFF5E35B1).withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.apartment_rounded,
                              color: Color(0XFF5E35B1),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Room Details',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0XFF5E35B1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildDetailBox(
                                'Block',
                                '${controller.userProfile?.blockNumber}',
                                Icons.location_city_rounded,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDetailBox(
                                'Room',
                                '${controller.userProfile?.roomNumber}',
                                Icons.meeting_room_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0XFF5E35B1).withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.receipt_long_rounded,
                              color: Color(0XFF5E35B1),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Charges Breakdown',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0XFF5E35B1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildChargeItem(
                                'Room Charge',
                                double.parse(controller
                                        .userProfile?.charges?.roomCharge
                                        .toString() ??
                                    '')),
                            _buildChargeItem(
                                'Maintenance',
                                double.parse(controller
                                        .userProfile?.charges?.maintenance
                                        .toString() ??
                                    '')),
                            _buildChargeItem(
                                'Parking',
                                double.parse(controller
                                        .userProfile?.charges?.parking
                                        .toString() ??
                                    '')),
                            _buildChargeItem(
                                'Water',
                                double.parse(controller
                                        .userProfile?.charges?.water
                                        .toString() ??
                                    '')),
                            const Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0XFF5E35B1),
                                  ),
                                ),
                                Text(
                                  '${'\$'}${(double.parse(controller.userProfile?.charges?.roomCharge.toString() ?? '') + double.parse(controller.userProfile?.charges?.maintenance.toString() ?? '') + double.parse(controller.userProfile?.charges?.parking.toString() ?? '') + double.parse(controller.userProfile?.charges?.water.toString() ?? '')).toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0XFF5E35B1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color(0XFF5E35B1),
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                //   child: Text(
                //     'Pay Now',
                //     style: GoogleFonts.poppins(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }

  Widget _buildDetailBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0XFF5E35B1), size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0XFF5E35B1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargeItem(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}
