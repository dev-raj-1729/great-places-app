import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Place'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, greatPlacesSnapshot) =>
            greatPlacesSnapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child
                            : ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        greatPlaces.items[index].image),
                                  ),
                                  title: Text(greatPlaces.items[index].title),
                                  onTap: () {},
                                ),
                                itemCount: greatPlaces.items.length,
                              ),
                    child: Center(
                      child: Text('Got no Places yet'),
                    ),
                  ),
      ),
    );
  }
}
