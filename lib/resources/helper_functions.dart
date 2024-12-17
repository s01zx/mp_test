import 'package:mp_test/resources/sizeConfig.dart';

double calculateSize(double size,
    {bool useWidth = false, double scaleFactor = 8.53}) {
  /* 
  8.53 scale factor...could be 9 or 5 or whatever fits best with your design. 
  If 8.5 is too small or too large for your design scale, you can tweak it.
  */
  assert(
      SizeConfig.heightMultiplier != null && SizeConfig.widthMultiplier != null,
      'SizeConfig not initialized');
  var val = size / scaleFactor;
  return val *
      (useWidth ? SizeConfig.widthMultiplier! : SizeConfig.heightMultiplier!);
}
