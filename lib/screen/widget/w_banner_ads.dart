import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final double width;
  final double height;
  final String adUnitId;

  const BannerAdWidget({
    super.key,
    required this.width,
    required this.height,
    required this.adUnitId,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState(
    width: width,
    height: height,
    adUnitId: adUnitId,
  );
}

class _BannerAdWidgetState extends State<BannerAdWidget> with WidgetsBindingObserver {
  final double width;
  final double height;
  final String adUnitId;

  BannerAd? _bannerAd;

  _BannerAdWidgetState({
    required this.width,
    required this.height,
    required this.adUnitId,
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _bannerAd != null ? AdWidget(ad: _bannerAd!) : const Text(''),
    );
  }

  void _loadAd() {
    setState(() {
      _bannerAd = null;
    });

    BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize(
        width: width.toInt(),
        height: height.toInt(),
      ),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }
}