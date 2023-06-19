import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantList(),
      child: MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        home: RestaurantListScreen(),
      ),
    );
  }
}

class RestaurantList extends ChangeNotifier {
  List<Restaurant> restaurants = [
    Restaurant(
      name: 'Tickeled Pink',
      description:
          'North Indian, Italian, Mexican, Biryani, Desserts, Mediterranean, Continental, European',
      imageURL:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    ),
    Restaurant(
      name: 'Cafe Delhi Heights',
      description:
          'North Indian, Asian, Italian, Desserts, Beverages, Biryani, Salad',
      imageURL:
          'https://b.zmtcdn.com/data/pictures/6/4766/eb78a10db1ea400e2f31d80f39c4bef6.jpg',
    ),
    Restaurant(
      name: ' The Sky High',
      description:
          'French, Chinese, Italian, Greece, COntinental, North-Indian, Desserts, Sides, Mexican, Thai',
      imageURL:
          'https://images.unsplash.com/photo-1544148103-0773bf10d330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHJlc3RhdXJhbnRzfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    ),
    Restaurant(
      name: ' Social',
      description:
          'American, Mexican, Indian, Thai, Turkey, Continental, Speciality in Desi dhaba',
      imageURL:
          'https://media.istockphoto.com/id/1356890630/photo/interior-of-modern-loft-style-restaurant-with-fresh-flowers-and-mirror.jpg?b=1&s=170667a&w=0&k=20&c=A1K7hQu7t39DaPXQWa068wmk6CX5-kVXdpM3btblI4o=',
    ),
  ];

  void addRestaurant(Restaurant restaurant) {
    restaurants.add(restaurant);
    notifyListeners();
  }

  void updateRestaurant(int index, Restaurant restaurant) {
    restaurants[index] = restaurant;
    notifyListeners();
  }

  void deleteRestaurant(int index) {
    restaurants.removeAt(index);
    notifyListeners();
  }
}

class RestaurantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 194, 194, 1.000),
        appBar: AppBar(
          title: Text(
            'Restaurant List',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(194, 244, 244, 1.000),
        ),
        body: Consumer<RestaurantList>(
          //SizedBox(height: 10,),
          builder: (context, restaurantList, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 30,
              ),
              itemCount: restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantList.restaurants[index];
                return ListTile(
                  leading: Image.network(restaurant.imageURL),
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      restaurantList.deleteRestaurant(index);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailsScreen(index: index),
                      ),
                    );
                  },
                );
              },
            );
          }, //builder
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          //child: Text('add item'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRestaurantScreen(),
              ),
            );
          },
        ));
  }
}
// class RestaurantDetailScreen extends StatelessWidget{
//   final int index=0;

class RestaurantDetailsScreen extends StatelessWidget {
  final int index;

  RestaurantDetailsScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    final restaurantList = Provider.of<RestaurantList>(context);
    final restaurant = restaurantList.restaurants[index];

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(restaurant.imageURL),
          SizedBox(height: 20),
          Text(
            restaurant.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            restaurant.description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditRestaurantScreen(index: index),
            ),
          );
        },
      ),
    );
  }
}

class AddRestaurantScreen extends StatefulWidget {
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  late String name;
  late String description;
  late String imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Restaurant'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              onChanged: (value) {
                setState(() {
                  imageURL = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                final restaurant = Restaurant(
                  name: name,
                  description: description,
                  imageURL: imageURL,
                );
                final restaurantList =
                    Provider.of<RestaurantList>(context, listen: false);
                restaurantList.addRestaurant(restaurant);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditRestaurantScreen extends StatefulWidget {
  final int index;

  EditRestaurantScreen({required this.index});

  @override
  _EditRestaurantScreenState createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  late String name;
  late String description;
  late String imageURL;

  @override
  Widget build(BuildContext context) {
    final restaurantList = Provider.of<RestaurantList>(context);
    final restaurant = restaurantList.restaurants[widget.index];
    name = restaurant.name;
    description = restaurant.description;
    imageURL = restaurant.imageURL;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Restaurant'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              controller: TextEditingController(text: name),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              controller: TextEditingController(text: description),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
              onChanged: (value) {
                setState(() {
                  imageURL = value;
                });
              },
              controller: TextEditingController(text: imageURL),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final updatedRestaurant = Restaurant(
                  name: name,
                  description: description,
                  imageURL: imageURL,
                );
                restaurantList.updateRestaurant(
                    widget.index, updatedRestaurant);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
