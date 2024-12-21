import 'package:drone_lander/presentation/resources/customdrawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showCenterRefresh = false;

  // Settings state variables
  bool _notifications = true;
  bool _locationServices = true;
  bool _autoRecording = false;
  double _maxAltitude = 120.0; // in meters
  String _measurementUnit = 'Metric';
  bool _safetyMode = true;
  double _returnHomeAltitude = 30.0;
  String _defaultFlightMode = 'Sport';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.purpleAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.purple[900]?.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: children),
        ),
      ],
    );
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
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Settings',
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
                            color: Colors.purple[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.purpleAccent,
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
                        'Preferences',
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
                Expanded(
                  child: ListView(
                    children: [
                      _buildSettingsSection(
                        'General',
                        [
                          SwitchListTile(
                            title: const Text('Notifications',
                                style: TextStyle(color: Colors.white)),
                            value: _notifications,
                            onChanged: (bool value) {
                              setState(() {
                                _notifications = value;
                              });
                            },
                            secondary: const Icon(Icons.notifications,
                                color: Colors.purpleAccent),
                          ),
                          SwitchListTile(
                            title: const Text('Location Services',
                                style: TextStyle(color: Colors.white)),
                            value: _locationServices,
                            onChanged: (bool value) {
                              setState(() {
                                _locationServices = value;
                              });
                            },
                            secondary: const Icon(Icons.location_on,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                      _buildSettingsSection(
                        'Flight Settings',
                        [
                          ListTile(
                            title: const Text('Maximum Altitude',
                                style: TextStyle(color: Colors.white)),
                            subtitle: Slider(
                              value: _maxAltitude,
                              min: 0,
                              max: 500,
                              divisions: 50,
                              label: '${_maxAltitude.round()}m',
                              onChanged: (double value) {
                                setState(() {
                                  _maxAltitude = value;
                                });
                              },
                            ),
                            leading: const Icon(Icons.height,
                                color: Colors.purpleAccent),
                          ),
                          ListTile(
                            title: const Text('Return Home Altitude',
                                style: TextStyle(color: Colors.white)),
                            subtitle: Slider(
                              value: _returnHomeAltitude,
                              min: 20,
                              max: 100,
                              divisions: 16,
                              label: '${_returnHomeAltitude.round()}m',
                              onChanged: (double value) {
                                setState(() {
                                  _returnHomeAltitude = value;
                                });
                              },
                            ),
                            leading: const Icon(Icons.home,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                      _buildSettingsSection(
                        'Camera Settings',
                        [
                          SwitchListTile(
                            title: const Text('Auto Recording',
                                style: TextStyle(color: Colors.white)),
                            value: _autoRecording,
                            onChanged: (bool value) {
                              setState(() {
                                _autoRecording = value;
                              });
                            },
                            secondary: const Icon(Icons.videocam,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                      _buildSettingsSection(
                        'Safety',
                        [
                          SwitchListTile(
                            title: const Text('Safety Mode',
                                style: TextStyle(color: Colors.white)),
                            subtitle: const Text(
                                'Enable additional safety features',
                                style: TextStyle(color: Colors.grey)),
                            value: _safetyMode,
                            onChanged: (bool value) {
                              setState(() {
                                _safetyMode = value;
                              });
                            },
                            secondary: const Icon(Icons.security,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                      _buildSettingsSection(
                        'Preferences',
                        [
                          ListTile(
                            title: const Text('Measurement Unit',
                                style: TextStyle(color: Colors.white)),
                            trailing: DropdownButton<String>(
                              value: _measurementUnit,
                              dropdownColor: Colors.purple[900],
                              style: const TextStyle(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _measurementUnit = newValue;
                                  });
                                }
                              },
                              items: <String>[
                                'Metric',
                                'Imperial'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            leading: const Icon(Icons.straighten,
                                color: Colors.purpleAccent),
                          ),
                          ListTile(
                            title: const Text('Default Flight Mode',
                                style: TextStyle(color: Colors.white)),
                            trailing: DropdownButton<String>(
                              value: _defaultFlightMode,
                              dropdownColor: Colors.purple[900],
                              style: const TextStyle(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _defaultFlightMode = newValue;
                                  });
                                }
                              },
                              items: <String>[
                                'Sport',
                                'Normal',
                                'Cinematic'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            leading: const Icon(Icons.flight,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
