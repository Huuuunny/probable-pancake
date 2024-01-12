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
              buildCardRecap(context, cart),
              SizedBox(height: 20),
              Text("Adresse de livraison"),
              SizedBox(height: 10),
              buildCardAdress(context),
              SizedBox(height: 20),
              Text("Methode de paiement"),
              SizedBox(height: 10),
              IconCardRow(),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme
                .of(context)
                .primaryTextTheme
                .labelLarge
                ?.color, backgroundColor: Theme
                .of(context)
                .primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text("Proceder au paiement"),
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
          buildRow("Vous Economisez", "-1€"),
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

class IconCardRow extends StatefulWidget {
  const IconCardRow({super.key});

  @override
  _IconCardRowState createState() => _IconCardRowState();
}

class _IconCardRowState extends State<IconCardRow> {
  // Variable to keep track of the selected card index.
  int selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Distribute the cards evenly across the Row
      children: <Widget>[
        buildCard(FontAwesomeIcons.ccVisa, 0), // Pass an index to identify the card
        buildCard(FontAwesomeIcons.ccApplePay, 1),
        buildCard(FontAwesomeIcons.ccMastercard, 2),
        buildCard(FontAwesomeIcons.ccPaypal, 3),
      ],
    );
  }

  Widget buildCard(IconData icon, int cardIndex) {
    bool isSelected = cardIndex == selectedCardIndex;

    return GestureDetector(
      onTap: () {
        // Toggle the selection when the card is tapped
        setState(() {
          if (isSelected) {
            selectedCardIndex = -1; // Deselect the card if it's already selected
          } else {
            selectedCardIndex = cardIndex; // Select the card
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 48.0), // Adjust size here
            ],
          ),
        ),
      ),
    );
  }
}
