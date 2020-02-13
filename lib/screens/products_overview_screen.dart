import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/product_grid.dart';

//adding enum for selection
enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavories = false;
  var _isInit = true;
  var _isLoading = false;
  PageController _myPage = PageController(initialPage: 0);

  @override
  void initState() {
    // _isLoading = true;
    // Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    // _isLoading = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My Shop'),
      //   //adding vertical elipsis menu
      //   actions: <Widget>[
      //     PopupMenuButton(
      //       onSelected: (FilterOptions selectedValue) {
      //         setState(() {
      //           if (selectedValue == FilterOptions.Favorites) {
      //             _showOnlyFavories = true;
      //           } else {
      //             _showOnlyFavories = false;
      //           }
      //         });
      //       },
      //       icon: Icon(Icons.more_vert),
      //       itemBuilder: (_) => [
      //         PopupMenuItem(
      //             child: Text('Only Favorites'),
      //             value: FilterOptions.Favorites),
      //         PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
      //       ],
      //     ),
      //     //added consumer because only this widget should rebuild not even how icon looks, just the count
      //     Consumer<Cart>(
      //       builder: (_, cart, ch) => Badge(
      //         child: ch,
      //         value: cart.itemCount.toString(),
      //       ),
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.shopping_cart,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(CartScreen.routeName);
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavories),
    );
  }
}
