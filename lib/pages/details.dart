import 'package:crypto_currencies/widgets/crypto_container.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String selectedValue;
  final String rate;
  final String crypto;
  final String image;

  const Details(
      {Key? key,
      required this.selectedValue,
      required this.rate,
      required this.crypto,
        required this.image})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CryptoContainers(
              data: widget.selectedValue,
              color: const Color(0xEE404040),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: 'cryptoImage',
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              15.0,
              20.0,
              0,
              0,
            ),
            child: Hero(
              tag: 'rateAmount',
              child: Text(
                '${widget.crypto} = ${widget.rate}',
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
