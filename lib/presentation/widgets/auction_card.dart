import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String title;
  final String address;
  final String image;

  RestaurantCard({Key key, this.title, this.address, this.image})
      : super(key: key);
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>ExtendedNavigator.rootNavigator.pushNamed(Routes.restaurantDetails, arguments: RestaurantDetailsArguments(restaurantData: RestaurantData())),
          child: Container(
        width: size.width * 0.8,
        child: Card(
          child: ListTile(
            title: Text(
              '$title',
              softWrap: true,
              
              style: TextStyle(color: Colors.black, fontSize: 18,height: 1.8),
            ),
            isThreeLine: false,
            subtitle: Text('$address', style: TextStyle(color: Colors.grey,height: 1.2)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('25', style: TextStyle(color: Colors.black)),
                Text(' kg', style: TextStyle(color: Colors.black)),
                SizedBox(height: 10,)
              ],
            ),
            leading: Container(
              height: size.height / 9,
              width: size.height / 9,
              child: CachedNetworkImage(
                imageUrl: '${APIs.imageBaseUrl}$image',
                imageBuilder: (context, imageB) => Container(
                  height: size.height / 9,
                  width: size.height / 9,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageB, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                placeholder: (context, imageStr) => imageStr.contains('null')
                    ? StylesD.noImageWidget()
                    : WaitingWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
