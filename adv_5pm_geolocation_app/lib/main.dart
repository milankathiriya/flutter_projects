import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? lat, long;
  double? liveLat, liveLong;
  String area = "--";
  String location = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await openAppSettings();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$lat, $long",
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: const Text("Get Current Position"),
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition();

                setState(() {
                  lat = position.latitude;
                  long = position.longitude;
                });
              },
            ),
            Text(
              "$liveLat, $liveLong",
              style: const TextStyle(fontSize: 24, color: Colors.purple),
            ),
            ElevatedButton(
              child: const Text("Get Live Position"),
              onPressed: () async {
                Geolocator.getPositionStream().listen((Position position) {
                  setState(() {
                    liveLat = position.latitude;
                    liveLong = position.longitude;
                  });
                });
              },
            ),
            Text(
              area,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: const Text("Get Location Area"),
              onPressed: () async {
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(lat!, long!);

                setState(() {
                  area = placemarks[0].toString();
                });
              },
            ),
            Text(
              location,
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: const Text("Get Location from Address"),
              onPressed: () async {
                List<Location> locations = await locationFromAddress(
                    "206,Sunshine Point, near Sudama Chowk, Mota Varachha, Surat, Gujarat 394101");

                setState(() {
                  location = locations[0].toString();
                });
              },
            ),
            // ElevatedButton(
            //   child: const Text("Camera Request"),
            //   onPressed: () async {
            //     PermissionStatus status = await Permission.camera.request();
            //
            //     if (status.isGranted) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text("Permission Allowed..."),
            //         ),
            //       );
            //     }
            //   },
            // ),
            // ElevatedButton(
            //   child: const Text("Location Request"),
            //   onPressed: () async {
            //     // PermissionStatus status = await Permission.location.request();
            //     //
            //     // if (status.isGranted) {
            //     //   ScaffoldMessenger.of(context).showSnackBar(
            //     //     const SnackBar(
            //     //       content: Text("Location Permission Allowed..."),
            //     //       backgroundColor: Colors.green,
            //     //     ),
            //     //   );
            //     // }
            //
            //     Map<Permission, PermissionStatus> statuses = await [
            //       Permission.location,
            //       Permission.locationAlways,
            //       Permission.locationWhenInUse,
            //     ].request();
            //
            //     // if(statuses[PermissionStatus] != PermissionStatus.granted){
            //     //
            //     // }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
