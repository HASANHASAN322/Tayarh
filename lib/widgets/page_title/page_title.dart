import 'package:flutter/material.dart';

import '../../constant/size.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key, required this.title, required this.subTitle,
  });

  final String title , subTitle ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: MySize.fontSizeXLg),
        ),
        const SizedBox(height: MySize.spaceBtwItems / 2,) ,
        Text(subTitle,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: MySize.fontSizeMd))
      ],
    );
  }
}
