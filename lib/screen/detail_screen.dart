import 'package:exercise2/controller/restaurant_controller.dart';
import 'package:exercise2/model/restaurant.dart';
import 'package:exercise2/screen/home_screen.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final RestaurantController _controller = RestaurantController();

  @override
  void initState() {
    super.initState();
    _controller.getRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Orang'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _controller.getRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Restaurant tempat = snapshot.data![index];
                return ListTile(
                  title: Text(tempat.nama),
                  subtitle: Text(tempat.alamat),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
