import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:tawasool/router.gr.dart';

class MapScreen extends StatefulWidget {
  final Function callback;

  const MapScreen({Key key, this.callback}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  checkPermission() async {
    geolocator.checkGeolocationPermissionStatus().then((geoStatus) {
      if (geoStatus == GeolocationStatus.denied)
        Permission.location.request().then((_) =>
            getCurrentLocation()); // requestPermissions([PermissionGroup.location]).then((_)=>getCurrentLocation());
      else
        getCurrentLocation();
    });
  }

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'حدد موقعك',
            style: TextStyle(fontFamily: 'bein'),
          ),
          centerTitle: true,
          backgroundColor: ColorsD.main,
          leading: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (currentPos == null) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Txt('من فضلك حدد موقعك'),
                  ));
                } else
                  ExtendedNavigator.rootNavigator.pop(currentPos);
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () => checkPermission())
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              
              onTap: (s) {
                getLocation(s);
                if(widget.callback!=null){
                  widget.callback(s);
                }
                marker = Set.from([
                  Marker(
                      markerId: MarkerId('0'),
                      draggable: true,
                      onDragEnd: getLocation,
                      position:
                          LatLng(currentPos.latitude, currentPos.longitude))
                ]);
                print(currentPos.longitude);
                setState(() {});
              },
              initialCameraPosition: CameraPosition(zoom: 10,
                target: LatLng(0, 0),
              ),
              markers: marker,

              // myLocationEnabled: true,
              // myLocationButtonEnabled: true,
              onMapCreated: onMapCreated,
            ),
            Align(
              alignment: Alignment(0,-1),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: buildlocationName()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Completer<GoogleMapController> completer = Completer();
  GoogleMapController _mapController;
  Geolocator geolocator = Geolocator();
  Position currentPos;
  Set<Marker> marker = Set.of([]);
  onMapCreated(GoogleMapController controller) async {
    completer.complete(controller);
    _mapController = controller;

    // getCurrentLocation();
  }

  bool loadingLocation = false;
  String locationName;
  getLocation(LatLng s) async {
    currentPos = Position(longitude: s.longitude, latitude: s.latitude);
    loadingLocation = true;
    setState(() {});
    final address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(s.latitude, s.longitude));
    locationName = address.first.addressLine;
    loadingLocation = false;
    setState(() {});
  }

  Widget buildlocationName() {
    return Center(
      child: Container(width:MediaQuery.of(context).size.width * 0.85 ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Visibility(
                visible: loadingLocation,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: CircularProgressIndicator(),
              ),
              Txt(locationName ?? '',
                  style: TxtStyle()
                    ..maxLines(3)
                    ..width(MediaQuery.of(context).size.width * 0.7)
                    ..textAlign.center())
            ],
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    if (true) {
      currentPos = await geolocator.getCurrentPosition();
      if (currentPos == null)
        AppSettings.openLocationSettings();
      else if (true)
        _mapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 13,
                target: LatLng(currentPos.latitude, currentPos.longitude))))
            .then((s) {
              getLocation(LatLng(currentPos.latitude, currentPos.longitude));
          marker = Set.from([
            Marker(
              draggable: true,
              onDragEnd: (s) {
                currentPos =
                    Position(longitude: s.longitude, latitude: s.latitude);
              },
              markerId: MarkerId('0'),
              position: LatLng(currentPos.latitude, currentPos.longitude),
            )
          ]);
          setState(() {});
        });
    }
    // else
    // widget.setLocation(currentPos);
  }
}
