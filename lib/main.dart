import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

/* class NavDrawer extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
 */

/* bool isHomePageSelected = true;
  Widget _appBar() {
    return Container(
      //padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.menu, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  } */

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = LatLng(-24.9555, -53.4552);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    /*  */
    /*  */

    late geo.Position position;
    String long = "", lat = "";
    late StreamSubscription<geo.Position> positionStream;

    Future<void> _checkPermission() async {
      final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
      final isGpsOn = serviceStatus == ServiceStatus.enabled;
      if (!isGpsOn) {
        print('Turn on location services before requesting permission.');
        return;
      }

      final status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        print('Permission granted');
      } else if (status == PermissionStatus.denied) {
        print(
            'Permission denied. Show a dialog and again ask for the permission');
      } else if (status == PermissionStatus.permanentlyDenied) {
        print('Take the user to the settings page.');
        await openAppSettings();
      }
      setState(() {
        //refresh the UI
      });
    }

    /*  */
    /*  */
    getLocation() async {
      position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);
      print(position.longitude);
      print(position.latitude);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {});

      geo.LocationSettings locationSettings = geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
        distanceFilter: 10,
      );

      StreamSubscription<geo.Position> positionStream =
          geo.Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((geo.Position position) {
        print(position.longitude);
        print(position.latitude);

        long = position.longitude.toString();
        lat = position.latitude.toString();

        setState(() {});
      });
    }

    /*  */

    /*  */
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),
          Stack(children: [
            Positioned(
                top: 50,
                left: 20,
                child: Center(
                    child: Material(
                  color: Colors.grey,
                  shape: const CircleBorder(),
                  child: IconButton(
                    splashColor: Colors.black,
                    splashRadius: 24,
                    icon: const Icon(
                      Icons.menu,
                    ),
                    onPressed: () {
                      print("menu");
                    },
                  ),
                ))),
            Positioned(
                bottom: 25,
                right: 0,
                left: 0,
                child: Center(
                    child: Material(
                  color: Colors.grey,
                  shape: const CircleBorder(),
                  child: IconButton(
                    splashColor: Colors.black,
                    splashRadius: 24,
                    icon: const Icon(
                      Icons.location_on,
                    ),
                    onPressed: () {
                      _checkPermission();
                      getLocation();
                      print("long: $long");
                      print("lat: $lat");
                    },
                  ),
                ))),
          ])
        ]),
      ),
    );
  }
}






/* class Buttonzadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          print("clicou");
        },
        icon: Text(
          "Salvar Localização",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        label: Icon(Icons.location_on),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 40),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
} */

/* floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            print("clicou");
          },
          icon: Text(
            "Salvar Localização",
            style: TextStyle(fontSize: 16),
          ),
          label: Icon(Icons.location_on),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(50, 40),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ), */

/* floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ), */

/* 
floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 20,
              left: 180,
              child: FloatingActionButton(
                heroTag: 'salve',
                onPressed: () {/*  print("clicou"); */},
                backgroundColor: Colors.white,
                splashColor: Colors.grey,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'menu',
                onPressed: () {/* Do something */},
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            // Add more floating buttons if you want
            // There is no limit
          ],
        ),
*/