import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/dashboard_button.dart';
import '../widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButtton(context, title: products, count: "${data.length}", icon: icProducts),
                        dashboardButtton(context, title: orders, count: "15", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     dashboardButtton(context, title: rating, count: "60", icon: icStar),
                    //     dashboardButtton(context, title: totalSales, count: "15", icon: icOrders),
                    //   ],
                    // ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(data.length, (index) {
                          return data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(data: data[index]));
                                  },
                                  leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
                                  title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                                  subtitle: normalText(text: "\$${data[index]['p_price']}", color: darkGrey),
                                );
                        }),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
