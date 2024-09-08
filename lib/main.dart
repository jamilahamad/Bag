import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Bag',
      home: ShoppingBagScreen(),
    );
  }
}

class ShoppingBagScreen extends StatefulWidget {
  @override
  _ShoppingBagScreenState createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  int pulloverCount = 1;
  int tshirtCount = 1;
  int sportDressCount = 1;

  int pulloverPrice = 51;
  int tshirtPrice = 30;
  int sportDressPrice = 43;

  @override
  Widget build(BuildContext context) {
    int totalAmount = (pulloverCount * pulloverPrice) +
        (tshirtCount * tshirtPrice) +
        (sportDressCount * sportDressPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildCartItem(context, 'Pullover', 'Black', 'L', pulloverPrice,
                    pulloverCount, (newCount) {
                  setState(() {
                    pulloverCount = newCount;
                  });
                }, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb1NN05_tHHufnFw8O-NhtxF6RGrE7f1mnZg&s'),
                // Pullover network image
                // if you run this code on emulator you have to wait for images load
                buildCartItem(
                    context, 'T-Shirt', 'Gray', 'L', tshirtPrice, tshirtCount,
                    (newCount) {
                  setState(() {
                    tshirtCount = newCount;
                  });
                }, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb1NN05_tHHufnFw8O-NhtxF6RGrE7f1mnZg&s'),
                // T-Shirt network image
                // if you run this code on emulator you have to wait for images load
                buildCartItem(context, 'Sport Dress', 'Black', 'M',
                    sportDressPrice, sportDressCount, (newCount) {
                  setState(() {
                    sportDressCount = newCount;
                  });
                }, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb1NN05_tHHufnFw8O-NhtxF6RGrE7f1mnZg&s'),
                // Sport Dress network image
                // if you run this code on emulator you have to wait for images load
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount: ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      ' \$$totalAmount',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Congratulations! You checked out successfully.'),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('CHECK OUT', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(
      BuildContext context,
      String itemName,
      String color,
      String size,
      int price,
      int count,
      Function(int) onCountChanged,
      String imageUrl) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Left side image
            Image.network(imageUrl, width: 80, height: 80),
            SizedBox(width: 10),
            // Middle content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  RichText(
                    text: TextSpan(
                      text: 'Color: ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: color,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '  Size: '),
                        TextSpan(
                          text: size,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (count > 0) {
                            onCountChanged(count - 1);
                          }
                        },
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                      Text('$count'),
                      IconButton(
                        onPressed: () {
                          onCountChanged(count + 1);
                        },
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Icon(Icons.more_vert),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text('\$$price', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
