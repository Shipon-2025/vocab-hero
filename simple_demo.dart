// Simple Demo Version of Vocab Hero
// This can be run on DartPad (dartpad.dev) for a quick preview

import 'package:flutter/material.dart';

void main() {
  runApp(VocabHeroDemo());
}

class VocabHeroDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocab Hero Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: DemoHomeScreen(),
    );
  }
}

class DemoHomeScreen extends StatefulWidget {
  @override
  _DemoHomeScreenState createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  int currentLevel = 5;
  int currentXP = 75;
  int xpToNextLevel = 100;
  int streakCount = 12;
  int gemsCount = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00A99D), Color(0xFF00A99D).withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    // User Info Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Color(0xFF00A99D), size: 28),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning!',
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              Text(
                                'Vocab Hero',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Gems and Streak
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD100),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.diamond, color: Colors.black87, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '$gemsCount',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF6B35),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '$streakCount',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // XP Progress
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level $currentLevel',
                                style: TextStyle(
                                  color: Color(0xFFFFD100),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$currentXP / $xpToNextLevel XP',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: currentXP / xpToNextLevel,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD100)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Current Path Card
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFF00A99D).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.record_voice_over, color: Color(0xFF00A99D)),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Current Path',
                                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                              ),
                              Text(
                                'Spoken English Power-Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Today\'s Goal: Learn 5 new words',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showWordDemo(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00A99D),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Learn Today\'s Words',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Quick Actions Grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Access',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        _buildQuickActionCard(
                          'Practice',
                          'Smart Review',
                          Icons.psychology,
                          Color(0xFF00A99D),
                          '3',
                        ),
                        _buildQuickActionCard(
                          'Take Quiz',
                          'Test Knowledge',
                          Icons.quiz,
                          Color(0xFF7ED321),
                          null,
                        ),
                        _buildQuickActionCard(
                          'Leaderboard',
                          'See Rankings',
                          Icons.leaderboard,
                          Color(0xFFFF6B6B),
                          null,
                        ),
                        _buildQuickActionCard(
                          'Dictionary',
                          'Search Words',
                          Icons.menu_book,
                          Color(0xFFFFD100),
                          null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 100), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, String? badge) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              if (badge != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6B6B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showWordDemo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Word Demo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Serendipity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A99D),
              ),
            ),
            SizedBox(height: 8),
            Text('noun', style: TextStyle(color: Color(0xFF00A99D))),
            SizedBox(height: 16),
            Text('আকস্মিক সুখকর আবিষ্কার'),
            SizedBox(height: 16),
            Text(
              'Example: Finding this book was pure serendipity.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
