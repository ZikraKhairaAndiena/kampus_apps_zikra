import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/model_kampus.dart';

class PageMaps extends StatefulWidget {
  @override
  _PageMapsState createState() => _PageMapsState();
}

class _PageMapsState extends State<PageMaps> {
  late GoogleMapController mapController;
  Future<ModelKampus>? _kampusFuture;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _kampusFuture = fetchKampus();
  }

  Future<ModelKampus> fetchKampus() async {
    final response = await http.get(Uri.parse('http://192.168.100.110/latihan kampus apps/getKampus.php'));

    if (response.statusCode == 200) {
      var kampusData = modelKampusFromJson(response.body);
      setState(() {
        _markers = kampusData.data.map((kampus) {
          return Marker(
            markerId: MarkerId(kampus.nama_kampus ?? 'Unknown Campus'),
            position: LatLng(
              double.tryParse(kampus.lat_kampus ?? '0') ?? 0,
              double.tryParse(kampus.long_kampus ?? '0') ?? 0,
            ),
            infoWindow: InfoWindow(
              title: kampus.nama_kampus,
              snippet: kampus.lokasi_kampus,
            ),
          );
        }).toSet();
      });
      return kampusData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sekolah'),
      ),
      body: FutureBuilder<ModelKampus>(
        future: _kampusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-0.9145, 100.4607), // Initial map center point
                zoom: 10,
              ),
              markers: _markers,
            );
          }
        },
      ),
    );
  }
}
