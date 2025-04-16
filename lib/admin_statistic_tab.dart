import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminStatisticTab extends StatefulWidget {
  const AdminStatisticTab({super.key});

  @override
  State<AdminStatisticTab> createState() => _AdminStatisticTabState();
}

class _AdminStatisticTabState extends State<AdminStatisticTab> {
  final List<Map<String, dynamic>> revenueData = [
    {'month': 'Jan', 'revenue': 5000000},
    {'month': 'Feb', 'revenue': 4000000},
    {'month': 'Mar', 'revenue': 5500000},
    {'month': 'Apr', 'revenue': 6000000},
    {'month': 'May', 'revenue': 4500000},
    {'month': 'Jun', 'revenue': 7000000},
  ];

  final int totalOrders = 120;
  final int totalProductsSold = 350;
  final String topSellingProduct = 'Bó hoa hồng đỏ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Thống kê doanh thu'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildStatCard(Icons.shopping_cart, "Tổng số đơn hàng", "$totalOrders"),
            const SizedBox(height: 12),
            _buildStatCard(Icons.inventory_2, "Sản phẩm đã bán", "$totalProductsSold"),
            const SizedBox(height: 12),
            _buildStatCard(Icons.star, "Sản phẩm bán chạy", topSellingProduct),
            const SizedBox(height: 24),
            const Text(
              '📈 Doanh thu hàng tháng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            if (value.toInt() >= 0 && value.toInt() < revenueData.length) {
                              return Text(revenueData[value.toInt()]['month']);
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            return Text('${value.toInt()}tr');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: revenueData
                            .asMap()
                            .entries
                            .map((entry) =>
                                FlSpot(entry.key.toDouble(), entry.value['revenue'] / 1000000))
                            .toList(),
                        isCurved: true,
                        color: Colors.pinkAccent,
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.pinkAccent.withOpacity(0.2),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink.shade100,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ),
    );
  }
}
