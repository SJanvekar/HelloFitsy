import 'dart:async';
import 'package:balance/Constants.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/CreateClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/createClassStep8TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/BodyButton2_withIcon.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
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

var _textController = TextEditingController();

class _SelectClassLocationState extends State<SelectClassLocation> {
  //Vars
  bool isExpanded = false;
  late double currentLat;
  late double currentLong;
  CameraPosition _kCurrentLocation = const CameraPosition(
    target: LatLng(43.6532, -79.3832),
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

  String kGoogleApiKey = "API_KEY";

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      currentLat = 43.6532; //position.latitude
      currentLong = -79.3832; //position.longitude
      _kCurrentLocation = CameraPosition(
        target: LatLng(currentLat, currentLong),
        zoom: 14,
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
      print(currentLat);
      print(currentLong);
    });
  }

  //Get Current Location

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
          leadingWidth: 65,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        FitsyIconsSet1.arrowleft,
                        color: jetBlack60,
                        size: 15,
                      ),
                      const Text(
                        "Back",
                        style: logInPageNavigationButtons,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => SelectClassLocation(
                              classTemplate: classTemplate,
                            )));
                  },
                ),
              ],
            ),
          ),
          title: Text(
            'Where is your class located?',
            style: sectionTitles,
          )),
      body: GestureDetector(
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Expanded(
            child: GoogleMap(
              compassEnabled: false,
              myLocationButtonEnabled: false,
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: _kCurrentLocation,
              onMapCreated: (GoogleMapController controller) {
                _getCurrentLocation();
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
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: isExpanded ? 420 : 40,
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextField(
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  controller: _textController,
                                  autofocus: true,
                                  style: bodyFontDefaultJetblack,
                                  cursorColor: ocean,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      FitsyIconsSet1.search,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    suffixIcon: _textController.text.isNotEmpty
                                        ? GestureDetector(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                  right: 15,
                                                ),
                                                width: 80,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Icons.close,
                                                  size: 18,
                                                  color: jetBlack60,
                                                )),
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              _textController.clear();
                                              isExpanded = false;
                                              setState(() {});
                                            })
                                        : null,
                                  ),
                                ),
                              ),
                              PageDivider(leftPadding: 20, rightPadding: 20),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: GestureDetector(
                                  child: BodyButtonWithIcon(
                                      buttonColor: shark40,
                                      textColor: jetBlack,
                                      buttonText: 'Use current location',
                                      buttonIcon:
                                          CupertinoIcons.location_circle_fill,
                                      buttonIconColor: jetBlack),
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    _getCurrentLocation();
                                    Future.delayed(Duration(milliseconds: 10));
                                    setState(() {
                                      isExpanded = false;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            print(index);
                                            isExpanded = false;
                                          });
                                        },
                                        title: Text(
                                          'Location',
                                          style: profileBodyTextFont,
                                        ),
                                        leading: Icon(
                                          CupertinoIcons.location_circle,
                                          size: 18,
                                          color: jetBlack40,
                                        ),
                                        minLeadingWidth: 5,
                                      );
                                    })),
                              ),
                              const SizedBox(height: 10.0)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(
                                  FitsyIconsSet1.search,
                                  size: 15,
                                  color: jetBlack60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'Search',
                                  style: profileBodyTextFont,
                                ),
                              ),
                            ],
                          ),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 55.0, left: 15.0, right: 15.0),
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
