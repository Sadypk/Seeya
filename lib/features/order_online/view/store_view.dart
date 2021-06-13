import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/chat/repository/streachatConfig.dart';
import 'package:seeya/features/chat/view/chattingScreen.dart';
import 'package:seeya/features/order_online/model/get_chat_orderList.dart';
import 'package:seeya/features/order_online/repo/get_chat_orderList_repo.dart';
import 'package:seeya/features/order_online/repo/get_store_products.dart';
import 'package:seeya/features/order_online/view/cart_page.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/cartModel.dart';
import 'package:seeya/main_app/util/keyboardVisibility.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/util/snack.dart';

import '../../../newMainAPIs.dart';

class StoreView extends StatefulWidget {
  final StoreData storeData;

  const StoreView({Key key, this.storeData}) : super(key: key);

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  TextEditingController searchController = TextEditingController();
  bool dataLoad = true;
  List<ProductModel> products = [];
  List<Catalog> catalog = [];
  List<Tab> tabs = [];
  ProductData productData;
  GetChatOrderAutocompleteData getChatOrderAutocompleteData;
  bool keyboard = false;
  List<List<String>> selectedTab = [];

  List<String> searchResult = [];
  bool matchFound = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    getChatOrderAutocompleteData = await GetChatOrderListRepo.getCharOrder(widget.storeData.id);
    onSearchTextChanged('');
    productData = await GetStoreProducts.getStoreProducts(widget.storeData.id);
    products.addAll(productData.products);

    productData.products.forEach((element) {
      getChatOrderAutocompleteData.data.add(ChatOrderList(id: element.id, name: element.name));

      if (catalog.length == 0) {
        catalog.add(element.catalog);
      } else {
        catalog.where((el) {
          if (el.name != element.catalog.name) {
            catalog.add(element.catalog);
          }
          return false;
        });
      }
    });

    catalog.forEach((element) {
      tabs.add(Tab(text: element.name));
    });

    setState(() {
      dataLoad = false;
    });
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      getChatOrderAutocompleteData.data.forEach((element) {
        setState(() {
          searchResult.add(element.name);
          matchFound = false;
        });
      });
      return;
    }

    getChatOrderAutocompleteData.data.forEach((element) {
      if (element.name.toLowerCase().contains(text.toLowerCase())) {
        setState(() {
          searchResult.add(element.name);
          matchFound = true;
        });
      }
    });
  }

  bool screenLoading = false;

  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      screenLoading : screenLoading,
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.only(right: 10),
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${widget.storeData.name}', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text('(${widget.storeData.defaultCashbackOffer}% cashback)', style: TextStyle(color: Colors.white, fontSize: 11)),
                            ],
                          ),
                          Text(dataLoad ? '' : 'Wallet balance: ${productData.walletAmount == 0 ? widget.storeData.defaultCashbackOffer : productData.walletAmount}',
                              style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.sticky_note_2_outlined,
                              color: AppConst.themePurple,
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.phone_outlined,
                              color: AppConst.themePurple,
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: InkWell(
                          onTap: () async{
                            print('123');

                            setState(() {
                              screenLoading = true;
                            });
                            final channel = await SConfig.createChat(widget.storeData.id);
                            setState(() {
                              screenLoading = false;
                            });
                            if(channel != null){
                              Get.to(ChattingScreen(channel: channel));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.message_outlined,
                                color: AppConst.themePurple,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          body: dataLoad
              ? SpinKitDualRing(color: AppConst.themePurple)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Color(0xff252525).withOpacity(0.4)), color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 3),
                                            child: Icon(
                                              Icons.search,
                                              color: AppConst.black.withOpacity(0.7),
                                            )),
                                        Flexible(
                                            child: TextFormField(
                                          controller: searchController,
                                          onChanged: onSearchTextChanged,
                                          decoration: InputDecoration.collapsed(
                                              hintText: 'Enter any product name here',
                                              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'open', color: AppConst.black.withOpacity(0.7))),
                                        ))
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (searchController.text.isNotEmpty) {
                                        if (CartItemModel.rawItem.isEmpty) {
                                          CartItemModel.rawItem.add(RawProduct(name: searchController.text, quantity: 1));
                                          if (CartItemModel.selectedStore.isEmpty) {
                                            CartItemModel.selectedStore.add(widget.storeData);
                                            CartItemModel.rawItem.add(RawProduct(name: searchController.text, quantity: 1));
                                            CartItemModel.walletAmount.value = productData.walletAmount;
                                          } else if (CartItemModel.selectedStore.contains(widget.storeData.id)) {
                                            CartItemModel.rawItem.add(RawProduct(name: searchController.text, quantity: 1));
                                          } else {
                                            Snack.top('Alert!', 'Item from another store is in cart.');
                                          }
                                        } else {
                                          bool sameItem = true;
                                          for (var x in CartItemModel.rawItem) {
                                            if (x.name.toLowerCase() != searchController.text.toLowerCase()) {
                                              sameItem = false;
                                            } else {
                                              sameItem = true;
                                            }
                                          }
                                          if (!sameItem) {
                                            CartItemModel.rawItem.add(RawProduct(name: searchController.text, quantity: 1));
                                          }
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text('Add', style: TextStyle(color: AppConst.themePurple, fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            KeyboardVisibilityBuilder(
                              builder: (context, child, isKeyboardVisible) {
                                keyboard = isKeyboardVisible;
                                if (isKeyboardVisible) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 18, bottom: 10),
                                    child: SingleChildScrollView(
                                      child: Obx(() => Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CartItemModel.rawItem.isEmpty
                                                  ? SizedBox()
                                                  : Text(
                                                      'Added List',
                                                      style: AppConst.titleText1,
                                                    ),
                                              CartItemModel.rawItem.isEmpty
                                                  ? SizedBox()
                                                  : Container(
                                                      child: ListView.builder(
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          itemCount: CartItemModel.rawItem.length,
                                                          itemBuilder: (_, index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                CartItemModel.rawItem.remove(CartItemModel.rawItem[index]);
                                                                if(CartItemModel.rawItem.isEmpty){
                                                                  CartItemModel.selectedStore.clear();
                                                                  CartItemModel.walletAmount.value = 0;
                                                                }
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 4.0, bottom: 2.0, right: 20),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      CartItemModel.rawItem[index].name,
                                                                      style: AppConst.titleText1Purple,
                                                                    ),
                                                                    Icon(
                                                                      Icons.remove_circle_outline,
                                                                      size: 20,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              matchFound
                                                  ? Text(
                                                      'Quick replies',
                                                      style: AppConst.titleText1,
                                                    )
                                                  : SizedBox(),
                                              matchFound
                                                  ? Container(
                                                      child: ListView.builder(
                                                          padding: EdgeInsets.only(bottom: 20),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          itemCount: searchResult.length,
                                                          itemBuilder: (_, index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (CartItemModel.rawItem.isEmpty) {
                                                                    if (CartItemModel.selectedStore.isEmpty) {
                                                                      CartItemModel.selectedStore.add(widget.storeData);
                                                                      CartItemModel.rawItem.add(RawProduct(name: searchResult[index], quantity: 1));
                                                                      CartItemModel.walletAmount.value = productData.walletAmount;
                                                                    } else if (CartItemModel.selectedStore.contains(widget.storeData.id)) {
                                                                      CartItemModel.rawItem.add(RawProduct(name: searchResult[index], quantity: 1));
                                                                    } else {
                                                                      Snack.top('Alert!', 'Item from another store is in cart.');
                                                                    }
                                                                  } else {
                                                                    bool sameItem = true;
                                                                    for (var x in CartItemModel.rawItem) {
                                                                      if (x.name.toLowerCase() != searchResult[index].toLowerCase()) {
                                                                        sameItem = false;
                                                                      } else {
                                                                        sameItem = true;
                                                                      }
                                                                    }
                                                                    if (!sameItem) {
                                                                      CartItemModel.rawItem.add(RawProduct(name: searchResult[index], quantity: 1));
                                                                    }
                                                                  }
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                                child: Text(
                                                                  searchResult[index],
                                                                  style: AppConst.titleText1Purple,
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  : SizedBox()
                                            ],
                                          )),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 18, bottom: 10),
                                    child: DefaultTabController(
                                      length: tabs.length,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ButtonsTabBar(
                                            physics: AlwaysScrollableScrollPhysics(),
                                            backgroundColor: Color(0xff252525),
                                            unselectedBackgroundColor: Colors.white,
                                            unselectedLabelStyle: TextStyle(color: Color(0xff252525)),
                                            radius: 20,
                                            borderColor: Color(0xff707070),
                                            unselectedBorderColor: Color(0xff707070),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            borderWidth: 1,
                                            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            tabs: tabs,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 450,
                                            child: TabBarView(
                                                children: catalog.map((cat) {
                                              List<ProductModel> categoryProducts = products.where((element) => element.catalog.id == cat.id).toList();

                                              return categoryProducts.length > 0
                                                  ? GridView.builder(
                                                      shrinkWrap: true,
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 10,
                                                        crossAxisSpacing: 10,
                                                        childAspectRatio: ((MediaQuery.of(context).size.width / 2) / 195),
                                                      ),
                                                      itemCount: categoryProducts.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return Obx(() {
                                                          bool isSelected = CartItemModel.products.contains(categoryProducts[index]);
                                                          return GestureDetector(
                                                              onTap: () {
                                                                if (isSelected) {
                                                                  CartItemModel.products.remove(categoryProducts[index]);
                                                                  if(CartItemModel.products.isEmpty){
                                                                    CartItemModel.selectedStore.clear();
                                                                    CartItemModel.walletAmount.value = 0;
                                                                  }
                                                                } else {
                                                                  if (CartItemModel.selectedStore.isEmpty) {
                                                                    CartItemModel.selectedStore.add(widget.storeData);
                                                                    CartItemModel.products.add(categoryProducts[index]);
                                                                    CartItemModel.walletAmount.value = productData.walletAmount;
                                                                  } else if (CartItemModel.selectedStore.contains(widget.storeData.id)) {
                                                                    CartItemModel.products.add(categoryProducts[index]);
                                                                  } else {
                                                                    Snack.top('Alert!', 'Item from another store is in cart.');
                                                                  }
                                                                }
                                                              },
                                                              child: ProductCardWidget(data: categoryProducts[index], isSelected: isSelected));
                                                        });
                                                      },
                                                    )
                                                  : Expanded(
                                                      child: Center(
                                                        child: Text('No Product Found'),
                                                      ),
                                                    );
                                            }).toList()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(), // this widget goes to the builder's child property. Made for better performance.
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CartPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(color: AppConst.themePurple, borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Added to Cart (${CartItemModel.rawItem.length + CartItemModel.products.length} items)', style: TextStyle(color: Colors.white, fontSize: 14)),
                              Text('View Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
    );
  }
}
