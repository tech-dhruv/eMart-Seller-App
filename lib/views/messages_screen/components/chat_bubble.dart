import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

Widget chatBubble() {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          //color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
          color: purpleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //"${data['msg']}".text.align(data['uid'] == currentUser!.uid ? TextAlign.right : TextAlign.left).white.size(16).make(),
         normalText(text: "Your message here..."),
          10.heightBox,
          //time.text.color(whiteColor.withOpacity(0.5)).make(),
          normalText(text: "10:45PM"),
        ],
      ),
    ),
  );
}
