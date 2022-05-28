import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:startup_namer/list-page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late LatLng center = const LatLng(-24.9555, -53.4552);
  final _nameController = TextEditingController();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LatLng> getCurrentPostion() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position currentPostion = await Geolocator.getCurrentPosition();
    return LatLng(currentPostion.latitude, currentPostion.longitude);
  }

  void addMarker(String name, LatLng latLng) {
    final MarkerId markerId = MarkerId(name);
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: name, snippet: '*'),
      onTap: () {
        print('Clicou no marker: ' + name);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<void> createMarkerDialog(
      BuildContext context, LatLng currentPosition) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Qual o nome desta localização?'),
          content: TextField(
            onChanged: (value) {},
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Escreva um nome"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Salvar'),
              autofocus: true,
              onPressed: () {
                addMarker(_nameController.text, currentPosition);
                _nameController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 11.0,
            ),
            markers: Set<Marker>.of(markers.values),
          ),
          Stack(
            children: [
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
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        print(markers);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListPage(markers: markers)),
                        );
                      },
                    ),
                  ),
                ),
              ),
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
                      onPressed: () async {
                        LatLng currentPosition = await getCurrentPostion();
                        createMarkerDialog(context, currentPosition);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
