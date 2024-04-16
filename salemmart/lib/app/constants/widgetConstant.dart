import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';

class WidgetConstant {
  static const spinkitLoading = LoadingSpinkit();
  static const LoginLoading = LoginLoadingSpinkit();
}

class LoadingSpinkit extends StatelessWidget {
  const LoadingSpinkit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 25,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven
                ? ColorConstant.primeryColor
                : ColorConstant.backgroundColor,
          ),
        );
      },
    );
  }
}

class LoginLoadingSpinkit extends StatelessWidget {
  const LoginLoadingSpinkit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven
                ? ColorConstant.backgroundColor
                : ColorConstant.backgroundColor.withOpacity(0.4),
          ),
        );
      },
    );
  }
}
