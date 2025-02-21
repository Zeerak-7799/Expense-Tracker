import 'package:expense_tracker/theme/mycolor.dart';
import 'package:flutter/material.dart';




Widget categoryBox(IconData icon, Color color, String label) {
  return Container(
    
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, size: 40,color: MyColor().naval,),
              ),
            ),
            Divider(color: color,),
            Text(label,style: TextStyle(color: MyColor().naval),)
          ],
        ),
      ),
    ),
  );
}
