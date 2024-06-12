import 'package:flutter/material.dart';



class Back extends StatelessWidget {
  const Back({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 60 ,
          height: 60,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50) ,
          ),
          child: IconButton(
            onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios_rounded , color: Colors.grey[600],),
          ),
        )

      ],
    );
  }
}
