import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../Model/model_kampus.dart';

class MapsAllPage extends StatefulWidget {
  @override
  _MapsAllPageState createState() => _MapsAllPageState();
}

class _MapsAllPageState extends State<MapsAllPage> {
  late GoogleMapController mapController;
  Future<ModelKampus>? _kampusFuture;

  @override
  void initState() {
    super.initState();
    _kampusFuture = fetchKampus();
  }

  Future<ModelKampus> fetchKampus() async {
    final response = await http.get(Uri.parse('http://192.168.100.110/latihan%20kampus%20apps/getKampus.php'));

    if (response.statusCode == 200) {
      return modelKampusFromJson(response.body);
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
            Set<Marker> markers = snapshot.data!.data.map((kampus) {
              return Marker(
                markerId: MarkerId(kampus.nama_kampus ?? 'Unknown Campus'),
                position: LatLng(
                  double.parse(kampus.lat_kampus ?? '0'),
                  double.parse(kampus.long_kampus ?? '0'),
                ),
                infoWindow: InfoWindow(
                  title: kampus.nama_kampus,
                  snippet: kampus.lokasi_kampus,
                ),
              );
            }).toSet();

            return GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-0.9145, 100.4607), // Koordinat pusat peta
                zoom: 10,
              ),
              markers: markers,
            );
          }
        },
      ),
    );
  }
}
