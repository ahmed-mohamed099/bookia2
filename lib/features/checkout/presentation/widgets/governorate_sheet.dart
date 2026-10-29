import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/checkout/data/models/governorate_model.dart';

/// The white sheet that slides up with the list of governorates.
Future<GovernorateModel?> showGovernorateSheet(
  BuildContext context,
  List<GovernorateModel> governorates,
) {
  return showModalBottomSheet<GovernorateModel>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => SizedBox(
      height: 0.6.sh,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
          child: Text('Select Governorate',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: governorates.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(governorates[i].name, style: TextStyle(fontSize: 14.sp)),
              onTap: () => Navigator.pop(context, governorates[i]),
            ),
          ),
        ),
      ]),
    ),
  );
}
