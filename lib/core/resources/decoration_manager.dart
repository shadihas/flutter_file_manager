import 'package:flutter/material.dart'; 
class DecorationManager {
 static  BoxDecoration authBackgroundDecoration({required String image}) =>
      BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
             image,
            ),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter));
  
}
