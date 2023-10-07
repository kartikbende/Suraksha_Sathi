import 'package:flutter/material.dart';

class toilets extends StatelessWidget {
  final Function? onMapFunction;
  const toilets({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('toilets near me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'assests/toilets.png',
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          Text('Toilets')
        ],
      ),
    );
  }
}
