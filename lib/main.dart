import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _needleValue = 4000;

  void _updateNeedleValue(double value) {
    setState(() {
      _needleValue = double.parse(value.toStringAsFixed(2));
    });
  }

  // Helper method to create a WidgetPointer with value and text
  WidgetPointer _buildWidgetPointer(double value, double offset, String text) {
    return WidgetPointer(
      value: value,
      offsetUnit: GaugeSizeUnit.logicalPixel,
      offset: offset,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 180,
          endAngle: 360,
          canScaleToFit: true,
          minimum: 0,
          maximum: 8000,
          showLabels: false,
          showTicks: false,
          axisLineStyle: const AxisLineStyle(
            cornerStyle: CornerStyle.bothCurve,
            thickness: 100,
            color: Color.fromARGB(255, 119, 168, 252),
          ),
          minorTicksPerInterval: 0,
          showLastLabel: true,
          pointers: <GaugePointer>[
            RangePointer(
              value: 2500,
              cornerStyle: CornerStyle.bothCurve,
              width: 100,
              color: Colors.blue.shade900,
            ),
            NeedlePointer(
              value: _needleValue,
              needleStartWidth: 2,
              needleEndWidth: 15,
              needleLength: 0.7,
              needleColor: Colors.black,
              knobStyle: const KnobStyle(
                color: Colors.black,
              ),
              enableDragging: true,
              onValueChanged: _updateNeedleValue,
              onValueChanging: (ValueChangingArgs args) {
                if (args.value < 1000 || args.value > 7000) {
                  args.cancel = true;
                }
              },
            ),
            _buildWidgetPointer(0, -55, '0'),
            _buildWidgetPointer(2000, -75, '2000'),
            _buildWidgetPointer(6000, -75, '6000'),
            _buildWidgetPointer(8000, -55, '8000'),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                'Value: $_needleValue',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              angle: 90,
              positionFactor: 0.2,
            ),
          ],
        )
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Creating an Interactive Rounded Radial Gauge with Flutter')),
      body: const Center(
        child: MyApp(),
      ),
    ),
  ));
}
