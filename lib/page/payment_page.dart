import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import '../bo/cart.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalisation de la commande"),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              buildCardRecap(context, cart), // Pass the Cart object here
              SizedBox(height: 20), // Add space between cards
              Text("Adresse de livraison"),
              buildCardAdress(context), // Add another card
              Text("Methode de paiement"),
              SizedBox(height: 20), // Add space between cards
              IconCardRow(),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme
                .of(context)
                .primaryColor, // Use the primary color from the theme
            onPrimary:
            Theme
                .of(context)
                .primaryTextTheme
                .button
                ?.color, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Optional: if you need round corners
            ),
          ),
          // onPressed: () => context.go("/payment"),
          onPressed: () {},
          child: const Text("Confirmer l'achat"),
        ),
      ),);
  }
}

Widget buildCardRecap(BuildContext context, Cart cart) {
  int subTotalCents = int.parse(cart.priceTotalInCents());
  double subTotalEuro = subTotalCents / 100;
  double taxEuro = subTotalEuro * 0.2;
  double savingsEuro = 1.0;
  double totalEuro = subTotalEuro + taxEuro - savingsEuro;

  String subTotalString = "${subTotalEuro.toStringAsFixed(2)}€";
  String taxString = "${taxEuro.toStringAsFixed(2)}€";
  String totalString = "${totalEuro.toStringAsFixed(2)}€";

  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRow("Récapitulatif de votre commande", ""),
          buildRow("Sous Total", subTotalString),
          buildRow("Vous Economisez", "1€"),
          buildRow("TVA", taxString),
          buildRow("Total", totalString),
        ],
      ),
    ),
  );
}




Widget buildCardAdress(BuildContext context) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Theme
            .of(context)
            .colorScheme
            .outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Michel Le Poney"),
          Text("8 Rue des ouvertures de portes"),
          Text("91204 CORBEAUX"),
        ],
      ),
    ),
  );
}

Widget buildRow(String text, String number) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(text),
      Text(number),
    ],
  );
}

class IconCardRow extends StatelessWidget {
  const IconCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Distribute the cards evenly across the Row
      children: <Widget>[
        buildCard(FontAwesomeIcons.ccVisa),
        buildCard(FontAwesomeIcons.ccApplePay),
        buildCard(FontAwesomeIcons.ccMastercard),
        buildCard(FontAwesomeIcons.ccPaypal),
      ],
    );
  }

  Widget buildCard(IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimum space
          children: <Widget>[
            Icon(icon), // Icon for the card
          ],
        ),
      ),
    );
  }
}
