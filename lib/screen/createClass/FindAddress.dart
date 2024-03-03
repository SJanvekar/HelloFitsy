import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "YAIzaSyBV9PTGFF4zstX3IFIbGx0tzbdu3xZkQpo");
  List<PlacesSearchResult> _predictions = [];

  void _searchPlaces() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: "AIzaSyBV9PTGFF4zstX3IFIbGx0tzbdu3xZkQpo",
      mode: Mode.overlay, // Mode.fullscreen works as well
      language: "en",
      components: [Component(Component.country, "ca")],
    );

    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      if (detail != null && detail.result != null) {
        setState(() {
          _predictions.add(detail.result as PlacesSearchResult);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Search'),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: _searchPlaces,
            child: Text('Search Location'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _predictions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_predictions[index].name),
                  subtitle: Text(_predictions[index].formattedAddress ?? ''),
                  onTap: () {
                    // Handle location selection
                    print('Selected: ${_predictions[index].name}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
