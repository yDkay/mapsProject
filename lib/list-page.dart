import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key, required this.markers}) : super(key: key);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> markerCards = widget.markers.values.map((marker) {
      return const Card(
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Text('Googleplex'),
          subtitle: Text('37.4218175, -122.0841106'),
          trailing: Icon(Icons.more_vert),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Lista de localizações")),
      body: ListView(
        children: markerCards,
      ),
    );
  }
}
