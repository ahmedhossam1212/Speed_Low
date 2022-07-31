import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final double _xStart;
  late final double _yStart;
  double _xEnd = 0.0;
  double _yEnd = 0.0;
  Timer? _timer;
  double _time = 0.0;
  double _velocity = 0.0;
  double calcVelocity() {
    _velocity =
        sqrt(pow((_xStart - _xEnd), 2) + pow((_yStart - _yEnd), 2)) / _time;
    return _velocity;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (PointerEvent details) {
        setState(() {
          _xEnd = details.position.dx;
          _yEnd = details.position.dy;
          calcVelocity();
        });
      },
      onEnter: (PointerEvent details) {
        _xStart = details.position.dx;
        _yStart = details.position.dy;
        debugPrint('$_xStart,$_yStart');
        _timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) {
            _time++;
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
             width: double.infinity,
            child: Column(
              children: [
                Text(
                  " I'm Here (${_xEnd.round().toString()} , ${_yEnd.round().toString()})",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                 SizedBox( width: 300,
              height: 300,
                child: SfRadialGauge(
                  title: const GaugeTitle(
                      text: 'Time',
                      textStyle:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  axes: <RadialAxis>[
                    RadialAxis( 
                      minimum: 0, maximum: 60, ranges: <GaugeRange>[
                      GaugeRange( 
                          startValue: 0,
                          endValue: 20,
                          color: Colors.green,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                        
                          startValue: 20,
                          endValue: 40,
                          color: Colors.orange,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 40,
                          endValue: 60,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10)
                    ], pointers:  <GaugePointer>[
                      NeedlePointer(value: _time )
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child:  Text(' ${_time.round().toString()} Sec ',
                                  style: const TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold))),
                          angle: 90,
                          positionFactor: 0.5)
                    ])
                  ]),
              ),
               const SizedBox(height: 20,),
                 SizedBox( width: 300,
              height: 300,
                child: SfRadialGauge(
                  title: const GaugeTitle(
                      text: 'Velocity',
                      textStyle:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  axes: <RadialAxis>[
                    RadialAxis( 
                      minimum: 0, maximum: 600, ranges: <GaugeRange>[
                      GaugeRange( 
                          startValue: 0,
                          endValue: 200,
                          color: Colors.green,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                        
                          startValue: 200,
                          endValue: 400,
                          color: Colors.orange,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 400,
                          endValue: 600,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10)
                    ], pointers:  <GaugePointer>[
                      NeedlePointer(value: _velocity )
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [ const SizedBox(height: 170,),
                                Text(' $_velocity M/S ',
                                    style: const TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.5)
                    ])
                  ]),
              ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}