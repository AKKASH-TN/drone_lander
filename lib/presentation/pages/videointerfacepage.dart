import 'package:drone_lander/presentation/resources/customdrawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Videointerfacepage extends StatefulWidget {
  const Videointerfacepage({super.key});

  @override
  State<Videointerfacepage> createState() => _VideointerfacepageState();
}

class _NetworkVideoFeed extends StatefulWidget {
  final String videoUrl;
  final bool isStreamActive;

  const _NetworkVideoFeed({
    Key? key, 
    required this.videoUrl, 
    this.isStreamActive = true
  }) : super(key: key);

  @override
  _NetworkVideoFeedState createState() => _NetworkVideoFeedState();
}

class _NetworkVideoFeedState extends State<_NetworkVideoFeed> {
  bool _isLoading = true;
  bool _hasError = false;
  late Timer _retryTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isStreamActive) {
      _startVideoFeed();
    }
  }

  void _startVideoFeed() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    
    // Test the network connection
    _testNetworkConnection();
  }

  Future<void> _testNetworkConnection() async {
    try {
      final response = await http.get(Uri.parse(widget.videoUrl));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _hasError = false;
        });
      } else {
        _handleError();
      }
    } catch (e) {
      _handleError();
    }
  }

  void _handleError() {
    setState(() {
      _isLoading = false;
      _hasError = true;
    });

    // Setup a retry mechanism
    _retryTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (widget.isStreamActive) {
        _startVideoFeed();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If stream is not active, show a stopped state
    if (!widget.isStreamActive) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.yellowAccent, width: 2),
        ),
        child: const Center(
          child: Text(
            'Video Stream Stopped',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.yellowAccent, width: 2),
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        'Unable to connect to video feed',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: _startVideoFeed,
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                )
              : Image.network(
                  widget.videoUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    _handleError();
                    return const SizedBox.shrink();
                  },
                ),
    );
  }

  @override
  void dispose() {
    _retryTimer.cancel();
    super.dispose();
  }
}

class _VideointerfacepageState extends State<Videointerfacepage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showCenterRefresh = false;
  bool _isRecording = false;
  bool _isMuted = false;
  double _zoomLevel = 1.0;
  
  // New variables for video stream control
  bool _isVideoStreamActive = false;

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

  // New method to start video stream
  void _startVideoStream() {
    setState(() {
      _isVideoStreamActive = true;
    });
  }

  // New method to stop video stream
  void _stopVideoStream() {
    setState(() {
      _isVideoStreamActive = false;
    });
  }

  // New method to send emergency alert
  void _sendEmergencyAlert() {
    try {
      http.post(
        Uri.parse('http://192.168.31.214:5000/send_alert'),
        body: {
          'message': 'Alert!! Elephant Detected Near the Village Border. Please stay alert and stay safe. Nandri :)',
        }
      ).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Emergency Alert Sent!'),
              backgroundColor: Colors.green,
            )
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to Send Alert'),
              backgroundColor: Colors.red,
            )
          );
        }
      });
    } catch (e) {
      print('Alert sending error: $e');
    }
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

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
    // Add recording logic here
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    // Add mute logic here
  }

  void _adjustZoom(double newValue) {
    setState(() {
      _zoomLevel = newValue;
    });
    // Add zoom logic here
  }

  @override
  void dispose() {
    _controller.dispose();
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
                // Existing header content
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Video\nInterface',
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
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Menu and refresh row
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
                        'Live Feed',
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
                // Video feed container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _NetworkVideoFeed(
                      videoUrl: 'http://192.168.172.99:5000/video_feed',
                      isStreamActive: _isVideoStreamActive,
                    ),
                  ),
                ),
                // Control panel
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Zoom slider
                      Row(
                        children: [
                          const Icon(Icons.zoom_out, color: Colors.white),
                          Expanded(
                            child: Slider(
                              value: _zoomLevel,
                              min: 1.0,
                              max: 5.0,
                              activeColor: Colors.yellowAccent,
                              inactiveColor: Colors.grey,
                              onChanged: _adjustZoom,
                            ),
                          ),
                          const Icon(Icons.zoom_in, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Control buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Start Stream Button
                          IconButton(
                            onPressed: _startVideoStream,
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          // Stop Stream Button
                          IconButton(
                            onPressed: _stopVideoStream,
                            icon: const Icon(
                              Icons.stop,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: _toggleMute,
                            icon: Icon(
                              _isMuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: _toggleRecording,
                            icon: Icon(
                              Icons.fiber_manual_record,
                              color: _isRecording ? Colors.red : Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add screenshot logic
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          // Emergency Alert Button
                          IconButton(
                            onPressed: _sendEmergencyAlert,
                            icon: const Icon(
                              Icons.emergency_outlined,
                              color: Colors.red,
                              size: 30,
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
          // Center refresh animation
          if (_showCenterRefresh)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
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