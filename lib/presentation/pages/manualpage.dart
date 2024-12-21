import 'package:drone_lander/presentation/resources/customdrawer.dart';
import 'package:flutter/material.dart';

class Manualpage extends StatefulWidget {
  const Manualpage({super.key});

  @override
  State<Manualpage> createState() => _ManualpageState();
}

class _ManualpageState extends State<Manualpage> {
  void _refreshPage() {
    setState(() {
      
    });
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInstructionStep(
      String title, String description, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Drone Manual',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _refreshPage,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Getting Started'),
              _buildInstructionStep(
                '1. Pre-flight Check',
                'Ensure all components are properly connected and the battery is fully charged. Check propellers for any damage.',
                'assets/images/preflight_check.png',
              ),
              _buildInstructionStep(
                '2. Power On',
                'Press and hold the power button for 3 seconds until you hear a beep. Wait for the LED indicators to show ready status.',
                'assets/images/power_on.png',
              ),
              _buildInstructionStep(
                '3. Connect Controller',
                'Turn on the controller and wait for it to pair with the drone. Confirm connection through the app.',
                'assets/images/controller_connection.png',
              ),

              _buildSectionTitle('Basic Flight Controls'),
              _buildInstructionStep(
                'Takeoff and Landing',
                'Use the takeoff/landing button or slowly push the left stick up for takeoff. For landing, use the auto-land feature or slowly decrease altitude.',
                'assets/images/takeoff_landing.png',
              ),
              _buildInstructionStep(
                'Basic Movement',
                'Left stick controls altitude and rotation. Right stick controls forward/backward and left/right movement.',
                'assets/images/basic_movement.png',
              ),
              _buildInstructionStep(
                'Advanced Maneuvers',
                'Once comfortable with basic controls, try gentle turns and figure-8 patterns to improve control precision.',
                'assets/images/advanced_moves.png',
              ),

              // Safety section
              _buildSectionTitle('Safety Guidelines'),
              _buildInstructionStep(
                'Emergency Procedures',
                'In case of emergency, press the auto-land button or kill switch. Always maintain visual contact with your drone.',
                'assets/images/emergency.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
