import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _currentLocation = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<Position>? _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation =
            'Lat: ${position.latitude}, Long: ${position.longitude}';
      });
      return position;
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        _currentLocation = 'Error fetching location';
      });
      throw Exception('Error getting location'); // Throw an error instead of returning null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white, 
      child: FutureBuilder<Position>(
        future: _getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.location_on, color: Colors.black,size: 30,),
                SizedBox(width: 12.0),
                Text(
                  'Fetching location...',
                  style: TextStyle(color: Colors.black,fontSize: 24),
                ),
                SizedBox(width: 130,),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black,size: 32,),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.location_on, color: Colors.black,size: 30,),
                SizedBox(width: 8.0),
                Text(
                  'Error fetching location',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 130,),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black,size: 32,),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),  
              ],
            );
          } else if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.location_on, color: Colors.black,size: 30,),
                    SizedBox(width: 8.0),
                    Text(
                      'Lat: ${snapshot.data!.latitude}, Long: ${snapshot.data!.longitude}',
                      style: TextStyle(color: Colors.black,fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(width: 130,), 
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black,size: 32,),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),
              ],
            );
          } else {
            return Container(); // Placeholder while waiting for data
          }
        },
      ),
    )
    );
  }
}
