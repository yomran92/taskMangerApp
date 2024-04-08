import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final String message;
  final Function callBack;
  final bool isRtl;
  final double? height;
  final double? width;

  const ErrorWidgetScreen(
      {required this.message,
      required this.isRtl,
      required this.callBack,
      this.width,
      this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(
      //     horizontal: width * 0.05, vertical: height * 0.05),
      child: Center(
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Styles.colorBackgroundContanier, //.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // // SizedBox(height: height*0.2,),
                CustomText(
                  text: message ?? "",
                  style: Styles.w500TextStyle()
                      .copyWith(color: Styles.colorTextError),
                  textAlign: TextAlign.start,
                ),

                Container(
                  // padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 20.w),
                  margin:
                      EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),

                  child: CustomButton(
                    height: (height ?? 25) * 0.2,
                    text: "reload",
                    style: Styles.w500TextStyle().copyWith(
                        color: Styles.colorTextWhite, fontSize: 20.sp),
                    textAlign: TextAlign.center,
                    color: Styles.colorPrimary,
                    fillColor: Styles.colorPrimary,
                    alignmentDirectional: AlignmentDirectional.center,
                    onPressed: callBack,
                  ),
                ),
                // SizedBox(height: height*0.05,),
              ],
            )),
      ),
    );
  }
}
