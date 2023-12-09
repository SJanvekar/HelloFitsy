import 'dart:async';
import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/screen/createClass/CreateClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/createClassStep8TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectClassLocation extends StatefulWidget {
  SelectClassLocation({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<SelectClassLocation> createState() => _SelectClassLocationState();
}

class _SelectClassLocationState extends State<SelectClassLocation> {
  late double currentLat;
  late double currentLong;
  late CameraPosition _kCurrentLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentLat = position.latitude;
      currentLong = position.longitude;
      _kCurrentLocation = CameraPosition(
        target: LatLng(currentLat, currentLong),
        zoom: 12,
      );
      _addMarker();
    });
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Marker'),
          position: LatLng(currentLat, currentLong),
          infoWindow:
              InfoWindow(title: 'Marker Title', snippet: 'Marker Snippet'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 26),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) =>
                      CreateClassPicture(classTemplate: widget.classTemplate)));
            },
            child: Text("Back", style: logInPageNavigationButtons),
          ),
        ),
        leadingWidth: 78,
      ),
      body: Column(
        children: [
          GoogleMap(
            markers: _markers,
            mapType: MapType.terrain,
            initialCameraPosition: _kCurrentLocation ??
                CameraPosition(target: LatLng(0, 0), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: jetBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 45.0, left: 26.0, right: 26.0),
        child: GestureDetector(
          child: FooterButton(
              buttonColor: strawberry, textColor: snow, buttonText: 'Continue'),
          onTap: () {
            switch (widget.classTemplate.classType) {
              case ClassType.Solo:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassTitleAndPrice(
                        classTemplate: widget.classTemplate)));
                break;
              case ClassType.Group:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassTitleAndPrice(
                        classTemplate: widget.classTemplate)));
                break;
              case ClassType.Virtual:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassTitleAndPrice(
                        classTemplate: widget.classTemplate)));
                break;
            }
          },
        ),
      ),
    );
  }
}

Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 46.5, right: 46.5),
      child: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Upload a picture for your class',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
