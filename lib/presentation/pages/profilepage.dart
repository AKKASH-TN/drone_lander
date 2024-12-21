import 'package:drone_lander/presentation/resources/customdrawer.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showCenterRefresh = false;
  
  // Profile state variables
  String _userName = "Akkash";
  String _userEmail = "HackerAsh@gmail.com";
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _nameController.text = _userName;
    _emailController.text = _userEmail;
  }

  void _handleRefresh() async {
    setState(() {
      _showCenterRefresh = true;
    });

    _controller.reset();
    _controller.forward();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _showCenterRefresh = false;
      });

      _controller.repeat();
    }
  }

  Widget _buildEditableField({
    required String value,
    required bool isEditing,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onEditPressed,
    required VoidCallback onSavePressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueAccent[900]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 15),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter $label",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
          ),
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: Colors.blueAccent,
            ),
            onPressed: isEditing ? onSavePressed : onEditPressed,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      RotationTransition(
                        turns: _animation,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.person_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: _handleRefresh,
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Profile Avatar Section
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 58,
                              backgroundImage: AssetImage('assets/images/akkash.jpg'),
                              
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                // Profile Information Section
                _buildEditableField(
                  value: _userName,
                  isEditing: _isEditingName,
                  controller: _nameController,
                  label: "name",
                  icon: Icons.person_outline,
                  onEditPressed: () {
                    setState(() {
                      _isEditingName = true;
                    });
                  },
                  onSavePressed: () {
                    setState(() {
                      _userName = _nameController.text;
                      _isEditingName = false;
                    });
                  },
                ),
                _buildEditableField(
                  value: _userEmail,
                  isEditing: _isEditingEmail,
                  controller: _emailController,
                  label: "email",
                  icon: Icons.email_outlined,
                  onEditPressed: () {
                    setState(() {
                      _isEditingEmail = true;
                    });
                  },
                  onSavePressed: () {
                    setState(() {
                      _userEmail = _emailController.text;
                      _isEditingEmail = false;
                    });
                  },
                ),
              ],
            ),
          ),
          // Centered refresh animation
          if (_showCenterRefresh)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple[900]?.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RotationTransition(
                  turns: _animation,
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}