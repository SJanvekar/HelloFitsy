import 'dart:async';
import 'dart:convert';
import 'package:balance/Constants.dart';
import 'package:balance/Requests/GooglePlacesAPIUtility.dart';
import 'package:balance/feModels/LocationPrediction.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep8TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/BodyButton2_withIcon.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocode/geocode.dart';

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
  List<Prediction> predictions = [];
  late AddressLatLong currentSelectedAddress;
  CameraPosition _kCurrentLocation = CameraPosition(
    target: LatLng(43.6532, -79.3832),
    zoom: 12,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  GeoCode geoCode = GeoCode();

  @override
  void initState() {
    super.initState();
    _textController.clear();

    _getCurrentLocation();
  }

  String? kGoogleApiKey = dotenv.env['GOOGLEMAPS_SECRET'];

  void placeAutoComplete(String query) async {
    print(kGoogleApiKey);
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": kGoogleApiKey,
    });

    String? response = await NetworkUtilityGoogleAPIPlaces.fetchUrl(uri);
    print(response);
    if (response != null) {
      Map<String, dynamic> data = json.decode(response);

      predictions = List<Prediction>.from(
        data['predictions']
            .map((prediction) => Prediction.fromJson(prediction)),
      );
    }
  }

  void fetchLocationDetails(String placeId) async {
    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json', {
      "place_id": placeId,
      "key": kGoogleApiKey,
    });

    print(uri);
    var response = await NetworkUtilityGoogleAPIPlaces.fetchUrl(uri);

    if (response != null) {
      currentSelectedAddress =
          AddressLatLong.fromJsonLatLong(json.decode(response));

      print(currentSelectedAddress.lat);
      print(currentSelectedAddress.long);
    } else {
      throw Exception('Failed to fetch location details');
    }
  }

  // void getCoordinatesForAddress(String addressSelected) async {
  //   try {
  //     Coordinates coordinates =
  //         await geoCode.forwardGeocoding(address: addressSelected);

  //     currentLat = coordinates.latitude!;
  //     currentLong = coordinates.longitude!;

  //     print(currentLat);
  //     print(currentLong);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _getCurrentLocation() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        currentLat = position.latitude; //position.latitude
        currentLong = position.longitude; //position.longitude
        _kCurrentLocation = CameraPosition(
          target: LatLng(currentLat, currentLong),
          zoom: 14,
        );
        _addMarker(currentLat, currentLong);
      });
    }
  }

  void _addMarker(double lat, double long) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('Selected Location'),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      print(_markers);
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
          GoogleMap(
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
                                    setState(() {
                                      if (val != null || val != "") {
                                        placeAutoComplete(val);
                                      }
                                    });
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
                                    itemCount: predictions.length,
                                    itemBuilder: ((context, index) {
                                      var predictionItem = predictions[index];
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            print(index);
                                            fetchLocationDetails(
                                                predictionItem.placeId);
                                            isExpanded = false;
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
                                              if (currentSelectedAddress.lat !=
                                                      null &&
                                                  currentSelectedAddress.long !=
                                                      null) {
                                                _kCurrentLocation =
                                                    CameraPosition(
                                                  target: LatLng(
                                                      currentSelectedAddress
                                                          .lat!,
                                                      currentSelectedAddress
                                                          .long!),
                                                  zoom: 14,
                                                );
                                                _addMarker(
                                                    currentSelectedAddress.lat!,
                                                    currentSelectedAddress
                                                        .long!);
                                                currentLat =
                                                    currentSelectedAddress.lat!;
                                                currentLong =
                                                    currentSelectedAddress
                                                        .long!;
                                              }
                                            });
                                          });
                                        },
                                        title: Text(
                                          predictionItem.description,
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
            widget.classTemplate.classLatitude = currentLat;
            widget.classTemplate.classLongitude = currentLong;
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
