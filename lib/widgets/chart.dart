import 'package:audit/providers/transacts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chartAmount = Provider.of<Transacts>(context);
    Map<String, double> dataMap = new Map();

    List<Color> colorList = [
      Colors.purple[50],
      Colors.purple[100],
      Colors.purple[200],
      Colors.purple[300],
      Colors.purple[400],
      Colors.purple[500],
      Colors.purple[600],
      Colors.purple[700],
      Colors.purple[800],
      Colors.purple[900],
      Colors.blue[50],
      Colors.blue[100],
      Colors.blue[200],
      Colors.blue[300],
      Colors.blue[400],
      Colors.blue[500],
      Colors.blue[600],
      Colors.blue[700],
      Colors.blue[800],
      Colors.blue[900],
    ];

    return FutureBuilder(
      future: Provider.of<Transacts>(context).fetchAndSetTransaction(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Transacts>(
                child: Container(),
                builder: (ctx, transacts, ch) {
                  return transacts.transactoin.length <= 0
                      ? ch
                      : Container(
                          height: 200,
                          child: ListView.builder(
                              itemCount: chartAmount.transactoin.length,
                              itemBuilder: (context, i) {
                                for (var i = 0;
                                    i < chartAmount.transactoin.length;
                                    i++) {
                                  if (chartAmount.transactoin[i].type == 'Debt')
                                    dataMap.putIfAbsent(
                                        chartAmount.transactoin[i].name,
                                        () =>
                                            chartAmount.transactoin[i].amount);
                                }
                                return (dataMap.isNotEmpty)
                                    ? Container(
                                        height: 200,
                                        child: ListView(
                                          children: <Widget>[
                                            PieChart(
                                              dataMap: dataMap,
                                              animationDuration:
                                                  Duration(milliseconds: 800),
                                              chartLegendSpacing: 32.0,
                                              chartRadius:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.7,
                                              showChartValuesInPercentage: true,
                                              showChartValues: true,
                                              showChartValuesOutside: false,
                                              chartValueBackgroundColor:
                                                  Colors.grey[200],
                                              colorList: colorList,
                                              showLegends: true,
                                              legendPosition:
                                                  LegendPosition.right,
                                              decimalPlaces: 1,
                                              showChartValueLabel: true,
                                              initialAngle: 0,
                                              legendStyle: TextStyle(
                                                  color: Colors.white),
                                              chartValueStyle:
                                                  defaultChartValueStyle
                                                      .copyWith(
                                                color: Colors.blueGrey[900]
                                                    .withOpacity(0.9),
                                              ),
                                              chartType: ChartType.disc,
                                            ),
                                            Center(
                                              child: Text(
                                                'Chart Debts',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5))
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                      );
                              }),
                        );
                });
      },
    );
  }
}
