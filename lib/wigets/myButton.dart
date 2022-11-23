import 'package:flutter/material.dart';


class myButton extends StatelessWidget {
  VoidCallback ontap;
  double myheight;
  double mywidth;
  String mytitle;
  Color mycolor;
  bool loading;

  myButton({
    Key? key,
    required this.ontap,
    required this.myheight,
    required this.mywidth,
    required this.mytitle,
    required this.mycolor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: myheight,
        width: mywidth,
        decoration: BoxDecoration(
            color: mycolor, borderRadius: BorderRadius.circular(9)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(color: Colors.white, strokeWidth: 4,)
              : Text(
                  mytitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
        ),
      ),
    );
  }
}
