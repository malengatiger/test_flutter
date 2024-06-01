import '../ui/dashboard/top_movers_carousel.dart';

List<CarouselData> getCarouselData() {
  List<CarouselData> carouselDataList = [];
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
  carouselDataList.add(CarouselData(
      imagePath: 'assets/logos/polkadot.svg',
      name: 'Polkadot',
      upArrow: true,
      percentage: 5.1));
  return carouselDataList;
}