import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/dashboard/crypto_card.dart';
import 'package:busha_app/ui/dashboard/latest_block_widget.dart';
import 'package:busha_app/ui/landing/info_page.dart';
import 'package:busha_app/ui/news/article_viewer.dart';
import 'package:busha_app/ui/news/news_widget.dart';
import 'package:busha_app/ui/dashboard/top_movers_carousel.dart';
import 'package:busha_app/ui/dashboard/transaction_list.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:busha_app/util/styles.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as bd;
import '../../models/block.dart';
import '../../util/functions.dart';
import '../landing/landing_page.dart';

class DashWidget extends StatefulWidget {
  const DashWidget({super.key});

  @override
  DashWidgetState createState() => DashWidgetState();
}

class DashWidgetState extends State<DashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Prefs prefs = GetIt.instance<Prefs>();
  final BlockchainService blockchainService =
      GetIt.instance<BlockchainService>();
  final CarouselController carouselController = CarouselController();

  static const mm = ' 🍎  🍎  🍎 Dashboard 🍎';

  static const _bitcoinAssets = 129860;
  static const _ethAssets = 28844;
  static const _tezosAssets = 82599;
  static const _totalAssets = _bitcoinAssets + _ethAssets + _tezosAssets;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUser();
  }

  User? user;
  Block? block;

  void _getUser() {
    user = prefs.getUser();
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/bitcoin.svg',
        name: 'Bitcoin',
        upArrow: true,
        percentage: 19.88));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/ethereum.svg',
        name: 'Ethereum',
        upArrow: true,
        percentage: 4.73));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/tezos.svg',
        name: 'Tezos',
        upArrow: true,
        percentage: 2.85));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/doge.svg',
        name: 'Doge',
        upArrow: true,
        percentage: 15.42));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/shibu.svg',
        name: 'Shibu',
        upArrow: true,
        percentage: 13.5));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/litecoin.svg',
        name: 'Litecoin',
        upArrow: true,
        percentage: 8.12));
    carouselDataList.add(CarouselData(
        imagePath: 'assets/logos/usdc.svg',
        name: 'USDC',
        upArrow: true,
        percentage: 15.42));
    setState(() {});
  }

  void _navigateToLatestBlock() {
    NavigationUtils.navigateToPage(
        context: context, widget: const LatestBlockWidget());
  }

  void _navigateToTransactionList() {
    NavigationUtils.navigateToPage(
        context: context, widget: const TransactionList());
  }

  List<CarouselData> carouselDataList = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToSettings() {
    NavigationUtils.navigateToPage(
        context: context, widget: const SettingsWidget());
  }
  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
  }
  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('###,###,###,###');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busha Dashboard',
          style: myTextStyleMediumBoldPrimaryColor(context),
        ),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(100), child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    user == null ? '' : user!.name!,
                    style: myTextStyleSmallBoldPrimaryColor(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 8, bottom: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Assets',
                    style: myTextStyleLarge(context),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(nf.format(_totalAssets),
                        style: myNumberStyleLargerPrimaryColor(context)),
                  ),
                ],
              ),
            ),
          ],
        )),
        actions:  [
          GestureDetector(
            onTap: (){
              _navigateToLanding();
            },
            child: const CircleAvatar(
              radius: 18.0,
              backgroundImage: AssetImage('assets/busha_logo.jpeg'),
            ),
          ),
          gapW8,
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [


                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CryptoCard(
                      name: 'Bitcoin',
                      ticker: 'BTC',
                      imagePath: 'assets/logos/bitcoin.svg',
                      upArrow: true,
                      amount: _bitcoinAssets,
                      percentage: 18.92),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CryptoCard(
                      name: 'Ethereum',
                      ticker: 'ETH',
                      imagePath: 'assets/logos/ethereum.svg',
                      upArrow: true,
                      amount: _ethAssets,
                      percentage: 6.48),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CryptoCard(
                      name: 'Tezos',
                      ticker: 'TZX',
                      imagePath: 'assets/logos/tezos.svg',
                      upArrow: false,
                      amount: _tezosAssets,
                      percentage: -4.91),
                ),
                gapH32,
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 8, bottom: 8, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Top Movers',
                        style: myTextStyleLarge(context),
                      ),
                      bd.Badge(
                        badgeContent: Text('${carouselDataList.length}',
                        style: const TextStyle(color: Colors.white),),
                        badgeStyle: bd.BadgeStyle(
                          badgeColor: Colors.green.shade800,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ),
                gapH32,
                TopMoversCarousel(
                    carouselData: carouselDataList,
                    carouselController: carouselController),
                gapH32,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      gapW16,
                      Text(
                        'Trending News',
                        style: myTextStyleLarge(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 8, bottom: 8),
                  child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewsWidget(
                          onArticleRequested: (url) {
                            NavigationUtils.navigateToPage(
                                context: context,
                                widget: ArticleViewer(url: url));
                          },
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
              tooltip: 'Change Mode and Color',
              backgroundColor: Theme.of(context).primaryColorLight),
          BottomNavigationBarItem(
              icon: const Icon(Icons.refresh),
              label: 'Latest Block',
              tooltip: 'Get Latest Block',
              backgroundColor: Theme.of(context).primaryColorLight),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.cloud_download,
                color: Colors.blue,
              ),
              label: 'Transactions',
              tooltip: 'Get Block Transactions',
              backgroundColor: Theme.of(context).primaryColorLight),
        ],
        elevation: 16,
        onTap: (index) {
          pp('$mm ... BottomNavigationBarItem index : $index');
          switch (index) {
            case 0:
              _navigateToSettings();
              break;
            case 1:
              _navigateToLatestBlock();
              break;
            case 2:
              _navigateToTransactionList();
              break;
          }
        },
      ),
    );
  }
}
