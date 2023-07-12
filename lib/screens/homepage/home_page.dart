import 'package:catseye_app/data/home-page-data/home-page-data.dart';
import 'package:catseye_app/widgets/home_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../appColors/app_colors.dart';
import '../../routes/routes.dart';
import '../../services/services_homepage_products.dart';
import '../../stylies/home_screen_stylies.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/show_all_widget.dart';
import '../../widgets/singleProduct_widget.dart';
import '../detailscreen/detail_screen.dart';
import '../slider/slider_controller.dart';
import '../tabbar/tabbar_data.dart';

class HomePage extends StatelessWidget {
  AppBar buildAppBar() {
    return AppBar(
      bottom: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 15),
        indicator: BoxDecoration(
          color: Colors.transparent,
        ),
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: AppColors.baseBlackColor,
        labelColor: AppColors.baseDarkPinkColor,
        tabs: [
          Text("All"),
          Text("Clothing"),
          Text("Shoes"),
          Text("Accesories"),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Column(
        children: [
          TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                hintText: "Search Catseye",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
              style: TextStyle(fontSize: 12, height: 0.2))
        ],
      ),
    );
  }

//Advertisment Method
  Widget buildAdvertismentPlace() {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Container(height: 170, child: HomeBannerWidget()),
    );
  }

//showAllHomePageProduct

  Widget showAllHomePageProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: sigleProductData.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          var data = sigleProductData[index];
          return SingleProductWidget(
            productImage: data.productImage,
            productModel: data.productModel,
            productName: data.productName,
            productOldPrice: data.productOldPrice,
            productPrice: data.productPrice,
            onPressed: () {
              PageRouting.goToNextPage(
                context: context,
                navigateTo: DetailScreen(
                  data: data,
                ),
              );
            },
          );
        },
      ),
    );
  }

//Test

  Widget TestMyProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: FutureBuilder(
          future: getHomePageProduct(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (snapshot.data[index].image == "") {
                      return Container(
                        child: Row(
                          children: [
                            Text("images/productImages/" +
                                snapshot.data[index].image),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${snapshot.data![index].color}",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      var path = "images/productImages/";
                      var fileName = snapshot.data[index].image;
                      var imagePath = path + fileName;
                      print(imagePath);
                      return Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              child: Image.asset(
                                  "images/productImages/${snapshot.data[index].image}"),
                              // Text("images/productImages/" +
                              //     snapshot.data[index].image)
                              // decoration: BoxDecoration(
                              //   color: Colors.transparent,
                              //   image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: AssetImage(
                              //       "images/productImages/" +
                              //           snapshot.data![index].image,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        //     child: Text(
                        //   "${snapshot.data![index].color}",
                        //   style: TextStyle(
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // )
                      );
                    }
                  });
            }
          }),
    );
  }

//Tending Product Method
  Widget buildTrendingProduct(
      {required String productImage,
      required String productName,
      required String productModel,
      required double productPrice}) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 20),
      height: 90,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Material(
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.network(productImage),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: HomeScreenStylies.trendingProductNameStyle,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    productModel,
                    style: HomeScreenStylies.trendingProductModelStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: MaterialButton(
              color: AppColors.baseLightPinkColor,
              elevation: 0,
              height: 45,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(0.7),
              ),
              onPressed: () {},
              child: Text(
                "\$ $productPrice",
                style: HomeScreenStylies.trendingProductPriceStyle,
              ),
            ),
          )
        ],
      ),
    );
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: buildAppBar(),
          body: TabBarView(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  //Advertisment
                  buildAdvertismentPlace(),

                  //Show All Product
                  ShowAllWidget(
                    leftText: "New Arrival",
                  ),

                  TestMyProduct(),

                  Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                  //Show Trending Product
                  ShowAllWidget(
                    leftText: "What\'s Trending",
                  ),
                  buildTrendingProduct(
                    productImage:
                        'https://www.decathlon.com.bd/pub/media/catalog/product/cache/c687aa7517cf01e65c009f6943c2b1e9/k/a/kalenji_run_cushion_w_shoes_frosty_turquoise_pe21_-_001_---_expires_on_20-11-2029-min.jpg',
                    productModel: 'Tank-tops',
                    productName: 'Classics mesh ',
                    productPrice: 15,
                  ),
                  buildTrendingProduct(
                    productImage:
                        'https://www.decathlon.com.bd/pub/media/catalog/product/cache/c687aa7517cf01e65c009f6943c2b1e9/k/a/kalenji_run_cushion_w_shoes_frosty_turquoise_pe21_-_001_---_expires_on_20-11-2029-min.jpg',
                    productModel: 'Tank-tops',
                    productName: 'Classics mesh ',
                    productPrice: 15,
                  ),
                  buildTrendingProduct(
                    productImage:
                        'https://www.decathlon.com.bd/pub/media/catalog/product/cache/c687aa7517cf01e65c009f6943c2b1e9/k/a/kalenji_run_cushion_w_shoes_frosty_turquoise_pe21_-_001_---_expires_on_20-11-2029-min.jpg',
                    productModel: 'Tank-tops',
                    productName: 'Classics mesh ',
                    productPrice: 15,
                  ),

                  //History

                  ShowAllWidget(
                    leftText: "Your History",
                  ),
                  Container(
                    height: 260,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      primary: true,
                      itemCount: sigleProductData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        var historyDataStore = sigleProductData[index];
                        var data = sigleProductData[index];
                        return SingleProductWidget(
                          productImage: data.productImage,
                          productModel: data.productModel,
                          productName: data.productName,
                          productOldPrice: data.productOldPrice,
                          productPrice: data.productPrice,
                          onPressed: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
              TabBarBar(
                productData: colothsData,
              ),
              TabBarBar(
                productData: shoesData,
              ),
              TabBarBar(
                productData: accessoriesData,
              ),
            ],
          )),
    );
  }
}
