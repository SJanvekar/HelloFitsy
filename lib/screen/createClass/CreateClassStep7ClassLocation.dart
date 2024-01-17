import 'dart:async';
import 'package:balance/constants.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/createClassStep8TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool isExpanded = false;
  late double currentLat;
  late double currentLong;
  CameraPosition _kCurrentLocation = const CameraPosition(
    target: LatLng(41.40338, 2.17403),
    zoom: 12,
  );
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
          toolbarHeight: 55,
          centerTitle: true,
          elevation: 0,
          backgroundColor: snow,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_rounded,
              color: jetBlack,
            ),
            onTap: () {
              print("Back");
              Navigator.of(context).pop(CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) =>
                      CreateClassPicture(classTemplate: widget.classTemplate)));
            },
          ),
          title: Text(
            'Where is your class located?',
            style: sectionTitlesClassCreation,
          )),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Expanded(
          child: GoogleMap(
            compassEnabled: false,
            myLocationButtonEnabled: false,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: _kCurrentLocation,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle('''[
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "landscape.natural.terrain",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#cce8c6"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebebeb"
      },
      {
        "weight": 1
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#d6d6d6"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a1caf1"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "visibility": "simplified"
      }
    ]
  }
]
''');
            },
          ),
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
              color: snow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
        ),
        Positioned(
            top: 20,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 40,
                  width: isExpanded
                      ? MediaQuery.of(context).size.width - (40 * 2)
                      : MediaQuery.of(context).size.width - (120 * 2),
                  decoration: BoxDecoration(
                    color: snow,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 15,
                        color: jetBlack.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: isExpanded
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for an address',
                              prefixIcon: Icon(
                                HelloFitsy.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            )
            // Container(
            //   height: 45,
            //   width: MediaQuery.of(context).size.width - (100 * 2),
            //   decoration: BoxDecoration(
            //     color: snow,
            //     borderRadius: BorderRadius.circular(20),
            //     boxShadow: <BoxShadow>[
            //       BoxShadow(
            //         offset: Offset(0, 0),
            //         blurRadius: 15,
            //         color: jetBlack.withOpacity(0.3),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(right: 5.0),
            //         child: Icon(
            //           HelloFitsy.search,
            //           color: jetBlack40,
            //           size: 12,
            //         ),
            //       ),
            //       Text(
            //         'Search for an address',
            //         style: buttonText3Jetblack40,
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ]),
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
