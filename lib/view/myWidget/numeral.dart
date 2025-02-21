import 'package:flutter/material.dart';

numeral({required String num,required Function() onTap}) {
 return TextButton(
      onPressed: onTap,
      style:
          const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(100, 50))),
      child:  Text(num,style:const TextStyle(fontSize: 26)));
}
