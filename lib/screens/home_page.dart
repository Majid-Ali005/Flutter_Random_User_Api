import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users =
      []; // bhai yaha pr api ka data hum list me call krwaynge.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Call"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user[
                'email']; // jo b cheez aap ko chaye hy oss ko iss trha pehly yaha pe access krna hy or phir call krna hy jaise title etc.
            final name = user['name']['first'];
            //agr key na hogi jaise email etc tho pir ye aap ko error throw karega tho api k andar jo key hy oss k hisab se kaam kare.
            final imageUrl = user['picture']['thumbnail'];
            return ListTile(
              // leading: Text('${index+1}'), iss se indexing hoti hy.
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ), // iss se aap ki indexing beautifully circular avatar me dikhengi.
              // leading: CircleAvatar(child: Image.network(imageUrl)),//iss se image show honngi
              title: Text(name),
              subtitle: Text(email),
            );
          }),
      //floating acetion button for api on click calling. matlab aik function k click hone pr etc.
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUser,
        child: const Icon(Icons.add), // This adds a plus icon to the button
      ),
    );
  }

  void fetchUser() async {
    print("hello world");
    const url =
        'https://randomuser.me/api/?results=100'; // yaha pr apne api ko paste krdena hy jo b ho aap k pass.
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
    print("fetch is completed");
  }
}
