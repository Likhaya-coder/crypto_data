import 'dart:io' show Platform;
import 'package:crypto_currencies/classes/coin_data.dart';
import 'package:crypto_currencies/constants.dart';
import 'package:crypto_currencies/pages/details.dart';
import 'package:crypto_currencies/widgets/crypto_container.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Crypto extends StatefulWidget {
  const Crypto({Key? key}) : super(key: key);

  @override
  State<Crypto> createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> with SingleTickerProviderStateMixin {
  String selectedValue = 'USD';
  String rate = '?';

  List<String> cryptoImage = cryptoImages;
  late final List<String> crypto = cryptoList;

  late final AnimationController _controller;
  late final Animation _colorAnimation;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedValue,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          getCoinData();
        });
      },
    );
  }

  // CupertinoPicker IOSPicker() {
  //   List<Text> currencyOptions = [];
  //   for (String currency in currenciesList) {
  //     currencyOptions.add(Text(currency));
  //   }
  //
  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (selectedIndex) {},
  //     children: currencyOptions,
  //   );
  // }

  void getCoinData() async {
    try {
      double data = await CoinData().getData(selectedValue);
      setState(() {
        rate = data.toStringAsFixed(0);
      });
    } catch (e) {
      print('could not get the data $e');
    }
  }

  @override
  void initState() {
    getCoinData();
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.yellow).animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _controller.reverse(from: 1.0);
        });
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 40.0, 0, 0),
              child: Text(
                'In the past 24 hours',
                style: kMutedColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (BuildContext context, double _value, Widget? child) {
                  return Opacity(
                    opacity: _value,
                    child: Padding(
                      padding: EdgeInsets.only(top: _value * 20.0),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  'Market is up',
                  style: kUnmutedColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Agne',
                ),
                child: AnimatedTextKit(
                  pause: const Duration(seconds: 3),
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText('Bitcoin'),
                    TypewriterAnimatedText('Ethereum'),
                    TypewriterAnimatedText('Light Coin'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      selectedValue: selectedValue,
                      rate: rate,
                      crypto: crypto[0],
                      image: cryptoImage[0],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                margin: const EdgeInsets.all(0.0),
                color: Colors.white24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: 'cryptoImage',
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          cryptoImage[0],
                        ),
                        minRadius: 40.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bitcoin',
                          style: kMutedColor,
                        ),
                        Text(
                          crypto.first,
                          style: kAcronyms,
                        ),
                      ],
                    ),
                    CryptoContainers(data: rate, color: _colorAnimation.value),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      selectedValue: selectedValue,
                      rate: rate,
                      crypto: crypto[1],
                      image: cryptoImage[1],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                color: Colors.white24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        cryptoImage[1],
                      ),
                      minRadius: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ethereum',
                          style: kMutedColor,
                        ),
                        Text(
                          crypto[1],
                          style: kAcronyms,
                        ),
                      ],
                    ),
                    CryptoContainers(data: rate, color: _colorAnimation.value),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      selectedValue: selectedValue,
                      rate: rate,
                      crypto: crypto[2],
                      image: cryptoImage[2],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                color: Colors.white24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        cryptoImage[2],
                      ),
                      minRadius: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Light Coin',
                          style: kMutedColor,
                        ),
                        Text(
                          crypto.last,
                          style: kAcronyms,
                        ),
                      ],
                    ),
                    CryptoContainers(data: rate, color: _colorAnimation.value),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80.0),
            Column(
              children: [
                Container(
                  height: 70.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: androidDropdown(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
