import 'package:emart_seller/views/widgets/text_style.dart';

import '../../const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;

  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    print('HELLO');
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data['p_imgs'].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //tittle and details section
                  boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  //tittle!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", color: fontGrey, size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}", color: fontGrey, size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  //rating
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(text: "\$${data['p_price']}", color: red, size: 18.0),

                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color", color: fontGrey),
                            //child: "Color: ".text.color(textfieldGrey).make(),
                          ),
                          Row(children: [
                            for (var i in data['p_colors']) ...{
                              VxBox().size(40, 40).roundedFull.color(Color(i)).margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {}),
                            }
                          ]),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Quantity", color: fontGrey),
                          ),
                          normalText(text: "${data['p_quantity']} items", color: fontGrey),
                        ],
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
