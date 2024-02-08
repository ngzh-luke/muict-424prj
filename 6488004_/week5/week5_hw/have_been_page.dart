// Kittipich Aiumbhornsin
// section 3 #6488004
// Good Boys group
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class BeenPage extends StatefulWidget {
  const BeenPage({super.key, required this.title});
  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<BeenPage> createState() => _BeenPageState(title: title);
}

class _BeenPageState extends State<BeenPage> {
  final String title;

  _BeenPageState({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(context),
        backgroundColor: Colors.teal[100],
        body: Center(
          child: theTabs(context),
        ),
      ),
    );
  }

  Column theTabs(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.blueGrey[200],
          height: 5,
          thickness: 2,
          indent: 75,
          endIndent: 75,
        ), // horizontal line between appbar and the tabview
        const SizedBox(
          height: 10,
        ), // fixed sized space between top appbar and the tabview
        SizedBox(
          // color: Colors.transparent,
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height - 100,

          child: DefaultTabController(
            length: 2,
            child: ClipRRect(
              // make rounded white box
              borderRadius: BorderRadius.circular(20.0),
              child: Scaffold(
                // backgroundColor: Colors.amber,
                appBar: AppBar(
                  toolbarHeight: 0, // hide appbar title
                  bottom: const TabBar(
                    labelColor: Colors.red,
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.map),
                        text: "Map view",
                      ),
                      Tab(
                        icon: Icon(Icons.list),
                        text: "List view",
                      )
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  // map view body

                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      SizedBox(height: 365, child: MyMapView()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Center(child: Text('You have been to ___')),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 25, left: 20, right: 20),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.teal[900]),
                                child: const Center(
                                    child: Text("Add More!",
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  Center(
                    // list view body
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ListView(children: const [
                          Places('Place 1', "description", "when"),
                          Places('Place 2', "description", "when"),
                          Places('Place 3', "description", "when"),
                          Places('Place 4', "description", "when"),
                          Places('Place 5', "description", "when"),
                          Places('Place 6', "description", "when"),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 25, left: 20, right: 20),
                          child: Container(
                            // width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.teal[900]),
                            child: const Center(
                                child: Text("Add More!",
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
      toolbarHeight: 40,
    );
  }
}

class MyMapView extends StatelessWidget {
  MyMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
          mapController: MapController(),
          options: const MapOptions(
            interactionOptions: InteractionOptions(
                enableMultiFingerGestureRace: true, enableScrollWheel: true),
            initialCenter: LatLng(51.50, -0.128928),
            initialZoom: 7.2,
          ),
          children: [
            TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.GoodBoys.app'),
            PolygonLayer(
              polygons: [
                Polygon(
                    isFilled: true,
                    borderColor: Colors.blueAccent,
                    borderStrokeWidth: 2.1,
                    strokeCap: StrokeCap.round,
                    color: Colors.blueAccent.withOpacity(0.4),
                    points: [
                      const LatLng(36.95, -9.5),
                      const LatLng(42.25, -9.5),
                      const LatLng(42.25, -6.2),
                      const LatLng(36.95, 40)
                    ])
              ],
            )
          ])
    ]);
  }
}

class Places extends StatelessWidget {
  final String name;
  final String description;
  final String when;
  const Places(this.name, this.description, this.when, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(description),
                          Text("When: $when"),
                        ],
                      )))
            ])));
  }
}
