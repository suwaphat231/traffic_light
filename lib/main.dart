import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Light Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const TrafficLightPage(),
    );
  }
}

class TrafficLightPage extends StatefulWidget {
  const TrafficLightPage({super.key});

  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  /// 0 = red, 1 = yellow, 2 = green
  int currentLight = 0;

  void _nextLight() {
    setState(() {
      currentLight = (currentLight + 1) % 3;
    });
  }

  double _opacityFor(int index) => currentLight == index ? 1.0 : 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traffic Light Animation')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // กรอบตู้สัญญาณไฟ (ตกแต่งให้เหมือนในรูป)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 28,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                      color: Color(0x22000000),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      opacity: _opacityFor(0),
                      child: const _LightDot(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      opacity: _opacityFor(1),
                      child: const _LightDot(color: Colors.yellow),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      opacity: _opacityFor(2),
                      child: const _LightDot(color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _nextLight,
                child: const Text('เปลี่ยนไฟ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LightDot extends StatelessWidget {
  const _LightDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          // เพิ่มเงานิดหน่อยให้ดูสว่างเวลาค่า opacity = 1.0
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 2,
            color: color.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
