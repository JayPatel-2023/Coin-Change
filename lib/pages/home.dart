import 'package:currency_converter/widgets/anyToAny.dart';
import 'package:currency_converter/widgets/usdToAny.dart';

import '../services/functions/fetch_rates.dart';
import 'package:flutter/material.dart';

import '../services/models/ratesmodel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    result = fetchRates();
    allcurrencies = fetchcurrencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Coin Change',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 36, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: Center(
                      child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context, currSnapshot) {
                      if (currSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          UsdToAny(
                            rates: snapshot.data!.rates,
                            currencies: currSnapshot.data!,
                          ),
                          const SizedBox(height: 25),
                          AnyToAny(
                            rates: snapshot.data!.rates,
                            currencies: currSnapshot.data!,
                          )
                        ],
                      );
                    },
                  )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
