import 'package:expense_tracker/utils/expense.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartGraph extends StatefulWidget {
  final List<ExpenseBucket> expenseBuckets;
  final double totalAmount;
  const ChartGraph(
      {super.key, required this.expenseBuckets, required this.totalAmount});

  @override
  State<ChartGraph> createState() => _ChartGraphState();
}

class _ChartGraphState extends State<ChartGraph> {
  final Map<Category, Color> _Labels = {
    Category.Food: Colors.blue,
    Category.Advertising: Color(0xFF57A4F2),
    Category.Travel: Color(0xFFA0CCF8),
    Category.Work: Colors.orange,
    Category.Telephone: Colors.red,
  };

  //update code
  Map<Category, Color> get _labelsForToday {
    final labels = <Category, Color>{};
    for (var bucket in widget.expenseBuckets) {
      if (bucket.totalExpenses > 0) {
        labels[bucket.category] = _Labels[bucket.category]!;
      }
    }
    return labels;
  }

  List<GaugeRange> _buildRangePointers() {
    double cumulativeValue = 0;
    double totalValue = widget.totalAmount;

    // widget.expenseBuckets.fold(0, (sum, bucket) {
    //   print("sumBucket ${sum + bucket.totalExpenses}");
    //   return sum + bucket.totalExpenses;
    // }); // Tổng giá trị của tất cả chi phí
    List<GaugeRange> ranges = [];
    ranges.add(GaugeRange(
      startValue: 0,
      endValue: 100,
      color: Colors.grey.shade300, // Background color for total amount
      startWidth: 0.3,
      endWidth: 0.3,
      sizeUnit: GaugeSizeUnit.factor,
    ));
    widget.expenseBuckets.forEach((bucket) {
      final color = _labelsForToday[bucket.category];
      if (color == null) {
        print('Color for category ${bucket.category} is null');
      }
      double endValue =
          cumulativeValue + (bucket.totalExpenses / totalValue) * 100;

      ranges.add(GaugeRange(
        startValue: cumulativeValue,
        endValue: endValue,
        color: color,
        startWidth: 0.3,
        endWidth: 0.3,
        sizeUnit: GaugeSizeUnit.factor,
      ));
      print(
          'Category: ${bucket.category}, Color: $color, Start: $cumulativeValue, End: $endValue');
      cumulativeValue = endValue;
    });

    return ranges;
  }

  List<GaugeAnnotation> _buildAnnotations() {
    double cumulativeValue = 0;
    double totalValue = widget.totalAmount;
    List<GaugeAnnotation> annotations = [];

    widget.expenseBuckets.forEach((bucket) {
      double percentage = (bucket.totalExpenses / totalValue) * 100;
      if (percentage > 0) {
        // Only add annotation for non-zero values
        double endValue = cumulativeValue + percentage;
        annotations.add(GaugeAnnotation(
          widget: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB0B8BF)),
          ),
          angle: 180 + (cumulativeValue + endValue) / 2 * 1.8, // Adjust angle
          positionFactor: 1.2, // Adjust position factor
          horizontalAlignment: GaugeAlignment.center,
        ));
        cumulativeValue = endValue;
      }
    });

    return annotations;
  }

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
                  child: SfRadialGauge(
                    axes: [
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        showAxisLine: false,
                        canScaleToFit: true,
                        radiusFactor: 0.8,
                        startAngle: 180,
                        endAngle: 360,
                        ranges: _buildRangePointers(),
                        annotations: _buildAnnotations(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _Labels.keys.map((category) {
                  return LabelCharts(
                    category.toString().split('.').last,
                    _Labels[category] ?? Colors.grey,
                  );
                }).toList(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget LabelCharts(String label, Color color) {
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
