import 'package:flutter/material.dart';

import '../app_palette.dart';

//--- Dart ---
/*
Its an transformed extension with return of E and an original of T
When implementing the extension of compactMap, for instance like this:
List<int?> numbers = [1, 2, null, 4, 5];
List<int> result = numbers.compactMap();
as it seems doesn't use any function of the transform, 
this will allowing empty list or nullable list due to (T?)?.

-- The (T?) -> refers to value of each elements that can be null
-- The ? on outside of (T?) or can be said (T?)? allowing to be an empty or nullable list 

Firstly each elements in the list will be inserted to transform which is (T?)?
this is the main reason why need an ternary so whenever the transform was null,
it will grab the value (e)=>e as a default value.

Second the where() is for filtering out the nullable element that contains inside (e)
afterward it will be casting to the expected return type which will return an output
of relatable type of each value nor an empty iterable if the value or transform is all null.
*/
extension CompactMapExtension<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) {
    return map(transform ?? (e) => e).where((element) => element != null).cast<T>();
  }
}

//--- Widget ---
extension PaddingWidget on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget paddingOnly({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }

  Widget space() => const Spacer();
}

extension ElevatedButtonExtension on ElevatedButton {
  ElevatedButton styledButton({
    required double width,
    required double height,
    Color? color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: color ?? AppPalette.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: child,
    );
  }
}

extension WidgetExtension on Widget {
  Center center() => Center(child: this);
  SizedBox sized({double? w, double? h}) => SizedBox(
        width: w,
        height: h,
        child: this,
      );
}

extension ImageProviderExtension on ImageProvider {
  CircleAvatar imageProviderCircleAvatar({double? radius}) => CircleAvatar(
        radius: radius ?? 25,
        backgroundImage: this,
      );
  Container imageProviderContainer({double? w, double? h}) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: this,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      );
}
