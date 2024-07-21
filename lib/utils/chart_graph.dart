import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartGraph extends StatefulWidget {
  const ChartGraph({super.key});

  @override
  State<ChartGraph> createState() => _ChartGraphState();
}

class _ChartGraphState extends State<ChartGraph> {
  final Map<String, Color> _Labels = {
    'Food': Colors.blue,
    'Advertising': Color(0xFF57A4F2),
    'Telephone': Color(0xFFA0CCF8),
    // 'Travel': Colors.purple
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F7),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      // height: 200,
      // width: 200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                // width: 650,
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      showAxisLine: false,
                      canScaleToFit: true,
                      radiusFactor: 0.9,
                      startAngle: 180,
                      endAngle: 180,
                      annotations: [
                        GaugeAnnotation(
                            widget: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFDCDFE3),
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                        )),
                      ],
                    ),
                    RadialAxis(
                      // radiusFactor: 0.8,
                      showTicks: false,
                      showLabels: false,
                      showAxisLine: false,

                      pointers: [
                        RangePointer(
                          value: 50,
                          color: Color(0xFF0E33F3),
                          width: 50,
                        )
                      ],
                      startAngle: 180,
                      endAngle: 24,
                    ),
                    RadialAxis(
                      // radiusFactor: 0.8,
                      showTicks: false,
                      showLabels: false,
                      showAxisLine: false,
                      pointers: [
                        RangePointer(
                          value: 50,
                          color: Color(0xFF57A4F2),
                          width: 50,
                        )
                      ],
                      startAngle: -75,
                      endAngle: 12,
                    ),
                    RadialAxis(
                      showTicks: false,
                      showLabels: false,
                      showAxisLine: false,
                      // radiusFactor: 0.8,
                      pointers: [
                        RangePointer(
                          value: 30,
                          color: Color(0xFFA0CCF8),
                          width: 50,
                        )
                      ],
                      startAngle: -30,
                      endAngle: 18,
                    ),
                  ],
                ),
              )),
              SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    3,
                    (index) => LabelCharts(_Labels.keys.elementAt(index),
                        _Labels.values.elementAt(index))),
              )
            ],
          )
        ],
      ),
    );
  }

  LabelCharts(String label, Color color) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(label),
      ],
    );
  }
}
