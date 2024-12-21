import 'dart:ui';

import 'package:drone_lander/presentation/resources/CustomDrawer.dart';
import 'package:drone_lander/presentation/resources/buildcategorychip.dart';
import 'package:drone_lander/presentation/resources/hourlyforecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'All';

  // Define a method to filter grid items based on selected category
  List<Widget> _filterGridItems() {
    final List<Widget> allGridItems = [
      
      
      // Current Weather Card (Weather Category)
      Card(
        key: const ValueKey('weather-card'),
        elevation: 10,
        shadowColor: Colors.lightBlue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '30°C',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Icon(
                    Icons.wb_sunny_sharp,
                    size: 64,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Sunny',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Weather Forecast Card (Weather Category)
      Column(
        key: const ValueKey('weather-forecast-card'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weather Forecast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HourlyForecastItem(
                  time: '00:00',
                  icon: Icons.cloud,
                  temperature: '25°C',
                ),
                const SizedBox(width: 16),
                HourlyForecastItem(
                  time: '03:00',
                  icon: Icons.cloudy_snowing,
                  temperature: '20°C',
                ),
                const SizedBox(width: 16),
                HourlyForecastItem(
                  time: '06:00',
                  icon: Icons.cloud_sharp,
                  temperature: '26°C',
                ),
                const SizedBox(width: 16),
                HourlyForecastItem(
                  time: '09:00',
                  icon: Icons.sunny,
                  temperature: '30°C',
                ),
                const SizedBox(width: 16),
                HourlyForecastItem(
                  time: '12:00',
                  icon: Icons.sunny_snowing,
                  temperature: '23°C',
                ),
              ],
            ),
          ),
        ],
      ),
      Card(
        key: const ValueKey('weather-forecast-card'),
        elevation: 10,
        shadowColor: Colors.lightBlue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Forecast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Humidity: 94'),
                          SizedBox(height: 10),
                          Text('Wind Speed: 2.84'),
                          SizedBox(height: 10),
                          Text('Pressure: 1021'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.water_drop,size: 25),
                          SizedBox(height: 10),
                          Icon(Icons.air_rounded,size: 25),
                          SizedBox(height: 10),
                          Icon(Icons.beach_access_rounded,size: 25),
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Drone Status Card (Drone Activity Category)
      Card(
        key: const ValueKey('drone-status-card'),
        elevation: 10,
        shadowColor: Colors.lightBlue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drone Status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Battery: 85%'),
                          SizedBox(height: 8),
                          Text('Signal: Strong'),
                          SizedBox(height: 8),
                          Text('GPS: Connected'),
                        ],
                      ),
                      Icon(
                        Icons.flight,
                        size: 64,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Recent Flights Card (Drone Activity Category)
      Card(
        key: const ValueKey('flight-history-card'),
        elevation: 10,
        shadowColor: Colors.lightBlue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Flights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.flight_takeoff),
                          title: Text('Flight #${index + 1}'),
                          subtitle: Text('Duration: ${15 + index * 5} minutes'),
                          trailing: Text(DateTime.now()
                              .subtract(Duration(days: index))
                              .toString()
                              .split(' ')[0]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Battery Statistics Card (Battery Category)
      Card(
        key: const ValueKey('battery-stats-card'),
        elevation: 10,
        shadowColor: Colors.lightBlue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'Battery Statistics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: 0.85,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text('Estimated Flight Time : 25 mins'),
                    Text('Battery Health : 85%'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ];

    // Filter items based on selected category
    if (selectedCategory == 'All') {
      return allGridItems;
    } else {
      return allGridItems.where((item) {
        switch (selectedCategory) {
          case 'Weather':
            return item.key.toString().contains('weather');
          case 'Drone Activity':
            return item.key.toString().contains('drone') ||
                item.key.toString().contains('flight');
          case 'Battery':
            return item.key.toString().contains('battery');
          default:
            return true;
        }
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background effects
              Align(
                alignment: const AlignmentDirectional(9, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade900),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-9, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade900),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Drone\nLander',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.yellow)),
                            filled: true,
                            fillColor: Colors.black,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Menu bar section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                          builder: (context) => IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: const Icon(Icons.menu_outlined,
                                    color: Colors.white),
                              )),
                      const Text(
                        'Home',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CategoryList(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: const Text(
                      "DashBoard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        final filteredItems = _filterGridItems();
                        if (index < filteredItems.length) {
                          return filteredItems[index];
                        }
                        return null;
                      },
                      itemCount: _filterGridItems().length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
