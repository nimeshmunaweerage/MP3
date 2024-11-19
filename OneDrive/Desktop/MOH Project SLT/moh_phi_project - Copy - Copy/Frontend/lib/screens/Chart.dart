import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charts"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bar Chart",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        Expanded(child: _buildBarChart()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final data = [
      DiseaseData('Matara', 5),
      DiseaseData('Dewinuwara', 10),
      DiseaseData('Hakmana', 7),
      DiseaseData('Deniyaya', 8),
    ];

    final series = [
      charts.Series<DiseaseData, String>(
        id: 'Disease',
        domainFn: (DiseaseData sales, _) => sales.day,
        measureFn: (DiseaseData sales, _) => sales.sales,
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      behaviors: [
        charts.ChartTitle('Location',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Total Patients',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
      ],
    );
  }
}

class DiseaseData {
  final String day;
  final int sales;

  DiseaseData(this.day, this.sales);
}
