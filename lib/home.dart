import 'dart:math';
import 'package:flutter/widgets.dart';
import 'result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  bool isMale = true;
  double heighVal = 170;

  int weight = 55;
  int age = 18;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Mass Index',),centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  m1Expanded(context, 'male'),
                  const SizedBox(width: 15,),
                  m1Expanded(context, 'female'),
                ],
              ),
            ),
          ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
                   ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Height', style: Theme.of(context).textTheme.headline2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                        Text(heighVal.toStringAsFixed(1), style: Theme.of(context).textTheme.headline1),
                        Text('CM', style: Theme.of(context).textTheme.bodyText1),
                      ],
                      ),
                      Slider(
                        min: 50,
                        max: 220,
                        value: heighVal,
                        onChanged: (newValue)=> setState(() => heighVal = newValue)
                      )

                    ],
                  )
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m2Expanded(context, 'weight'),
                    const SizedBox(width: 15,),
                    m2Expanded(context, 'age'),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height/12,
              child: TextButton(
                onPressed: (){

                var  result = weight / pow(heighVal/100, 2);
                print(result);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Result(result: result, isMale: isMale, age: age))
                  );},
                child: Text('Calculate',
                style: Theme.of(context).textTheme.headline2,
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                  isMale = type=='male'? true: false;
              });
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: (isMale&&type == 'female')||(!isMale&&type == 'male')? Colors.teal : Colors.blueGrey
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(type=='male'? Icons.male: Icons.female),
                  const SizedBox(height: 15,),
                  Text(
                    type=='male'? 'Male': 'Female',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
          ),
        );
  }
  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type=='age'? 'age': 'weight',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 15,),
            Text(
              type=='age'? '$age': '$weight',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              FloatingActionButton(
                heroTag:  type=='age'? 'age--': 'weight--',
                onPressed: () => setState(() => type =='age'? age--: weight--),
                child: const Icon(Icons.remove),
                mini: true,
              ),
              SizedBox(width: 8,),
              FloatingActionButton(
                heroTag:  type=='age'? 'age++': 'weight++',
                onPressed: () => setState(() => type =='age'? age++: weight++),
                child: const Icon(Icons.add),
                mini: true,
              ),
            ],
            )
          ],
        ),
      ),
    );
  }
}
