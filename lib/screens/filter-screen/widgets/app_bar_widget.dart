import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_resources.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget
{
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      elevation: 0,
      title: const Text(
        'Filter Options',
        style: TextStyle(color: ColorResources.TEXT_COLOR,
        fontWeight: FontWeight.bold,
        ),
      ),
      leading: CupertinoNavigationBarBackButton(
        onPressed: () => Navigator.of(context).pop(),
        color: ColorResources.TEXT_COLOR,
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
