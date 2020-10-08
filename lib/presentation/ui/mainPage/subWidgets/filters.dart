import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildFilters extends StatefulWidget {
  @override
  _BuildFiltersState createState() => _BuildFiltersState();
}

class _BuildFiltersState extends State<BuildFilters> {
  final List<String> filters = [
    LocaleKeys.allOrders,
    LocaleKeys.nearOrders,
    LocaleKeys.mostOrders
  ];
  int get _selectedFilter => IN.get<RestaurantsStore>().selectedFilter;
  set selectedFilter(s) => IN.get<RestaurantsStore>().selectedFilter = s;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          filters.length,
          (index) {
            return FittedBox(
              child: InkWell(
                  onTap: () {
                    setState(() => selectedFilter = index);
                    RM.get<RestaurantsStore>().setState(
                          (s) => s.filterRequests[index],
                          onError: (c,e){
                            print('Erro in homePage: $e');
                          },
                          onData: (c,d){
                            print('NO. OF RESTO ${d.allHomeFilters[index].data.length}');
                          }
                        );
                  },
                  child: _BuildFilterBtn(
                      isSelected: _selectedFilter == index,
                      filter: filters[index])),
            );
          },
        ),
      ),
    );
  }
}

class _BuildFilterBtn extends StatelessWidget {
  final bool isSelected;
  final String filter;

  const _BuildFilterBtn({Key key, this.isSelected, this.filter})
      : super(key: key);

  // const _BuildFilterBtn({Key key, this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // bool isSelected = selectedIndex == selectedFilter;
    final style = TxtStyle()
      ..borderRadius(all: 12)
      ..padding(vertical: 5, horizontal: 12)
      ..fontFamily('bein')
      ..fontSize(18)
      ..margin(vertical: 15)
      ..border(color: Colors.white, all: 2)
      ..textColor(isSelected ? ColorsD.main : Colors.white)
      ..background.color(isSelected ? Colors.white : ColorsD.main);
    return Txt(
      filter,
      style: style,
    );
  }
}
