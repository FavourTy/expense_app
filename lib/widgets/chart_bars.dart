import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  const ChartBars(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return  Column(
      children: [
        SizedBox(
            height: constraints.maxHeight *0.15,
            child: FittedBox(
                child: Text("#${spendingAmount.toStringAsFixed(0)}"))),
         SizedBox(
          height: constraints.maxHeight *0.5,
        ),
        SizedBox(
          height: constraints.maxHeight *0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              )),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.purple),
                ),
              )
            ],
          ),
        ),
         SizedBox(
          height:  constraints.maxHeight *0.6,
        ),
        Container(
          height:  constraints.maxHeight *0.15  ,
          child: FittedBox(child: Text(label)))
      ],
    );  
    });
   
  }
}
