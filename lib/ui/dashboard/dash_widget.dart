import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/dashboard/crypto_card.dart';
import 'package:busha_app/ui/dashboard/latest_block_widget.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../models/block.dart';
import '../../util/functions.dart';

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

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUser();
    _getLatestBlock();
  }

  User? user;
  Block? block;
  bool _busy = false;

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
    setState(() {});
  }

  void _navigateToLatestBlock() {
    if (block != null) {
      NavigationUtils.navigateToPage(
          context: context,
          widget: LatestBlockWidget(
            block: block!,
            onTransactionListRequired: (mHash) {
              _navigateToTransactionList();
            },
          ));
    }
  }

  void _navigateToTransactionList() {
    if (_blockTransactions != null) {
      NavigationUtils.navigateToPage(
          context: context,
          widget: TransactionList(blockTransactions: _blockTransactions!, time: block!.data!.time!,));
    } else {
      _getBlockTransactions();
    }
  }

  void _getLatestBlock() async {
    pp('$mm .......... _getLatestBlock ......');

    setState(() {
      _busy = true;
    });
    try {
      block = await blockchainService.getLatestBlock();
      if (block != null) {
        try {
          pp('$mm latest block returned, will get transactions ..'
              ' 🍎 hash: ${block!.data!.hash} 🍎');
          await _getBlockTransactions();
          _navigateToLatestBlock();
        } catch (e, s) {
          pp('$e $s');
          if (mounted) {
            showErrorDialog(message: '$e', context: context);
          }
        }
      }
    } catch (e, s) {
      pp('$mm ERROR: $e $s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }

    setState(() {
      _busy = false;
    });
  }

  BlockTransactions? _blockTransactions;

  Future _getBlockTransactions() async {
    pp('$mm .......... _getBlockTransactions ......');

    setState(() {
      _busy = true;
    });
    try {
      if (block != null) {
        pp('$mm _blockTransactions returned, 🍎 time: ${block!.data!.time} 🍎');
        _blockTransactions =
            await blockchainService.getBlockTransactions(block!.data!.hash!);
        pp('$mm _blockTransactions returned, 🍎 mainChain: ${_blockTransactions!.mainChain!} 🍎');
      }
    } catch (e, s) {
      pp('$mm ERROR: $e $s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }

    setState(() {
      _busy = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busha Dashboard',
          style: myTextStyleMediumBoldPrimaryColor(context),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('assets/busha_logo.jpeg'),
                      ),
                      Text(
                        user == null ? '' : user!.name!,
                        style: myTextStyleMediumBoldPrimaryColor(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Assets',
                        style: myTextStyleLarge(context),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: myTextStyleMediumBoldPrimaryColor(context),
                          )),
                    ],
                  ),
                ),
                const CryptoCard(
                    name: 'Bitcoin',
                    ticker: 'BTC',
                    imagePath: 'assets/logos/bitcoin.svg',
                    upArrow: true,
                    amount: 98540,
                    percentage: 15.92),
                const CryptoCard(
                    name: 'Ethereum',
                    ticker: 'ETH',
                    imagePath: 'assets/logos/ethereum.svg',
                    upArrow: true,
                    amount: 5890,
                    percentage: 6.48),
                const CryptoCard(
                    name: 'Tezos',
                    ticker: 'TZX',
                    imagePath: 'assets/logos/tezos.svg',
                    upArrow: false,
                    amount: 6752,
                    percentage: -4.91),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      gapW16,
                      Text(
                        'Today\'s Top Movers',
                        style: myTextStyleMediumBold(context),
                      ),
                    ],
                  ),
                ),
                TopMoversCarousel(
                    carouselData: carouselDataList,
                    carouselController: carouselController),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      gapW16,
                      Text(
                        'Trending News',
                        style: myTextStyleMediumBold(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _busy
              ? const Positioned(child: Center(child: BusyIndicator()))
              : gapH32,
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
              label: 'Refresh',
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
              _getLatestBlock();
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
