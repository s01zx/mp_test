// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mp_test/models/generic_models.dart';
import 'package:mp_test/resources/colors.dart';
import 'package:mp_test/resources/helper_functions.dart';
import 'package:mp_test/resources/helper_widgets.dart';
import 'package:mp_test/screens/map/components/mapmenu.dart';
import 'package:mp_test/screens/map/components/marker_view.dart';
import 'package:mp_test/screens/map/components/search_bar.dart';
import 'package:mp_test/screens/welcome/components/bottom_menu.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const routeName = '/mapscreen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapZoomPanBehavior _zoomPanBehavior;
  late MapTileLayerController _mapController;
  late List<GenericModels> locations;
  late int _currentSelectedIndex;
  // late bool _canUpdateFocalLatLng;
  // late int _tappedMarkerIndex;

  bool showmenu = false;

  @override
  void initState() {
    locations = [
      GenericModels(place: "Delta loc", lat: 6.2059, logi: 6.6959),
      GenericModels(place: "Bayelsa loc", lat: 4.7719, logi: 6.0699),
      GenericModels(place: "Lagos loc", lat: 6.5244, logi: 3.3792),
      GenericModels(place: "Abuja loc", lat: 9.0563, logi: 7.4985),
    ];
    _currentSelectedIndex = 1;
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      maxZoomLevel: 10,
      focalLatLng: MapLatLng(locations[_currentSelectedIndex].lat,
          locations[_currentSelectedIndex].logi),
      enableDoubleTapZooming: true,
    );
    _zoomPanBehavior.zoomLevel = 6;
    _mapController = MapTileLayerController();
    // _canUpdateFocalLatLng = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            //Map from syncfusion
            SfMaps(
              layers: <MapLayer>[
                MapTileLayer(
                  /// URL to request the tiles from the providers.
                  ///
                  /// The [urlTemplate] accepts the URL in WMTS format i.e. {z} —
                  /// zoom level, {x} and {y} — tile coordinates.
                  ///
                  /// We will replace the {z}, {x}, {y} internally based on the
                  /// current center point and the zoom level.
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  zoomPanBehavior: _zoomPanBehavior,
                  controller: _mapController,
                  initialMarkersCount: locations.length,
                  tooltipSettings: const MapTooltipSettings(
                    color: Colors.transparent,
                  ),

                  markerBuilder: (BuildContext context, int index) {
                    final double markerSize =
                        _currentSelectedIndex == index ? 40 : 25;
                    return MapMarker(
                      latitude: locations[index].lat,
                      longitude: locations[index].logi,
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        // onTap: () {
                        //   if (_currentSelectedIndex != index) {
                        //     _canUpdateFocalLatLng = false;
                        //     _tappedMarkerIndex = index;
                        //   }
                        // },
                        child: MarkerView(tx: locations[index].place ?? ""),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SearchBarx(),
            Positioned(
              bottom: calculateSize(120.0),
              left: calculateSize(20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showmenu = !showmenu;
                      setState(() {});
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff5e6062),
                      child: Icon(
                        Icons.insert_emoticon_sharp,
                        color: Color(0xffb8bbbc),
                      ),
                    ),
                  ),
                  verticalspace(10.0),
                  GestureDetector(
                    onTap: () {
                      showmenu = !showmenu;
                      setState(() {});
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff5e6062),
                      child: Icon(
                        Icons.send_outlined,
                        color: Color(0xffb8bbbc),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showmenu,
              child: Positioned(
                bottom: calculateSize(180.0),
                left: calculateSize(20.0),
                child: const Mapmenu(),
              ),
            ),
            Positioned(
              bottom: calculateSize(120.0),
              right: calculateSize(20.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const ShapeDecoration(
                  color: Color(0xff5e6062),
                  shape: StadiumBorder(),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    appText("List of variants", 16,
                        color: Colors.white, leftmargin: 10.0),
                  ],
                ),
              ),
            ),
            BottomMenu(
              initialindex: 0,
              ishomepage: false,
            ),
          ],
        ),
      ),
    );
  }
}
