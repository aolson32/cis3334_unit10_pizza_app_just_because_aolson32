import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pizza Order'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Pizza> pizzaInOrder = [];

  void _addPizza() {

    final pizzaToppingTextField = TextEditingController();
    int _sizeSelected =1;

    // TODO: display add pizza Dialog window
    print("addPizza called");
    // setState(() {
    //   pizzaInOrder.add(Pizza(1, "TOPPING"));
    // });
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
                height:300,
                child:  Column(
                  children: <Widget>[
                    Text(
                      'Toppings:',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextField(
                      controller: pizzaToppingTextField,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    DropdownButton(
                        style: Theme.of(context).textTheme.headline4,
                        value: _sizeSelected,
                        items:[
                          DropdownMenuItem(child: Text("Small"), value: 0),
                          DropdownMenuItem(child: Text("Medium"), value: 1),
                          DropdownMenuItem(child: Text("Large"), value: 2),
                          DropdownMenuItem(child: Text("X-Lareg"), value: 3)
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            _sizeSelected = value!;
                          });
                        }),
                    ElevatedButton(
                      child: Text('Add Pizza'),
                      onPressed: () {
                        print("Adding a pizza");
                        setState(() {
                          Pizza newPizza = new Pizza(_sizeSelected, pizzaToppingTextField.text);
                          pizzaInOrder.add(newPizza);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: pizzaInOrder.length,
          itemBuilder: (BuildContext context, int position){
            return ListTile(
              title: Text(pizzaInOrder[position].description!),
              leading: Icon(Icons.local_pizza),
            );
          }



      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Pizza{
  String toppings;
  double? price;
  int _size;
  String? description;

  final PIZZA_SIZES = ["Small","Medium","Large","X-Large"];
  final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];

  Pizza(int this._size, String this.toppings){
    price = PIZZA_PRICES[_size];
    description = "temp";
    description = "${PIZZA_SIZES[_size]} $toppings Pizza";
  }

  @override
  String toString(){
    return (PIZZA_SIZES[_size] + toppings + " Pizza");
  }

}




