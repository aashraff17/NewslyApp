import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF5FA8A3);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : primaryColor,
      appBar: AppBar(
        title: const Text('Analytics Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 1. SUMMARY STATS (Horizontal Scroll)
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildStatCard("Total Reads", "1.2k", Icons.menu_book_rounded, Colors.orange),
                _buildStatCard("Saved Items", "432", Icons.bookmark_rounded, Colors.blue),
                _buildStatCard("AI Chats", "89", Icons.auto_awesome, Colors.purple),
                _buildStatCard("Avg. Time", "12m", Icons.timer_rounded, Colors.green),
              ],
            ),
          ),

          // 2. MAIN ANALYSIS SHEET
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Category Interest",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildAnalysisBar("Technology", 0.85, primaryColor),
                    _buildAnalysisBar("Sports", 0.65, Colors.orange),
                    _buildAnalysisBar("Politics", 0.40, Colors.redAccent),
                    _buildAnalysisBar("Health", 0.30, Colors.blue),

                    const SizedBox(height: 32),
                    const Text("Weekly Activity",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildWeeklyGraph(isDark),

                    const SizedBox(height: 32),
                    _buildSystemStatusCard(isDark),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAnalysisBar(String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}%"),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.1),
            color: color,
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyGraph(bool isDark) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(40, "M"), _buildBar(70, "T"), _buildBar(50, "W"),
          _buildBar(90, "T"), _buildBar(60, "F"), _buildBar(100, "S"),
          _buildBar(80, "S"),
        ],
      ),
    );
  }

  Widget _buildBar(double height, String day) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 12,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF5FA8A3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(day, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSystemStatusCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5FA8A3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF5FA8A3).withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_user_rounded, color: Color(0xFF5FA8A3)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("AI Model Status: Optimal", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("All news feeds synchronized successfully.", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}