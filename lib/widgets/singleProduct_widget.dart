import 'package:catseye_app/appColors/app_colors.dart';
import 'package:flutter/material.dart';

class SingleProductWidget extends StatefulWidget {
  dynamic productImage;
  dynamic productName;
  dynamic productModel;
  dynamic productPrice;
  dynamic productOldPrice;
  final Function() onPressed;
  SingleProductWidget({
    required this.productImage,
    required this.productName,
    required this.productModel,
    required this.productPrice,
    required this.productOldPrice,
    required this.onPressed,
  });

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  bool isFave = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 250,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.productName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.productModel,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.baseDarkPinkColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "\$ ${widget.productPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "\$ ${widget.productOldPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
