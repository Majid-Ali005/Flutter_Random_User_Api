
# Flutter API call

- Step1: create a simple Flutter Fresh Application
### Note:
- iss me aap ko zaroori nhi hy k aap ki application firebase k sath connect ho. q k hum externally hi api ko use kr rhy hy tho iss wja se.
- aap ko jo home ki file hongi oss k widget ko statefull rakhna hy.
```bash
- flutter create Project_Name
- Flutter Run 
```

## Api Lena
hum yaha pr random user k api ko user karenge jiss ko aap randomuser.me ki website se le sakty hy.

Note: apne function ko chekc krne k liye k wo kaam kr rha hy k nhi tho oss k liye ye code likhe or phir oss ka output agr onclick pr arha hy tho sahi hy pr hum aghy ka kaam jarhi rakty hy.

```bash 
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Call"),
      ),
      //floating acetion button for api on click calling. matlab aik function k click hone pr etc.
     floatingActionButton: FloatingActionButton(onPressed: fetchUser),
      
    );
  }
  void fetchUser(){
    print("hello world");
  }
}
```
==> iss me ye hoga k jo fetchUser ka function hy oss ko hum ne onpressed pr call kiya howa hy.

## Add Http package 
ye package aap ko pub.dev k site se miljayega waha se aap iss ko add kr sakty hy.
iss http k dependency ko cupertino icon k niche rakh dena hy.
```bash 
cupertino_icons: ^1.0.2
http: ^1.2.2
```
or phir flutter pub get ki command run krni hy.

wra aap iss below command ko direct b run kr sakty hy ye aap k pass khud ba khud sub kuch set krdega etc.

```bash    
dart pub add http
 ```
phir iss ko apne home k file me import krdena hy jaha pr b aap apna api use krna chahtay hy etc.

```bash 
import 'package:http/http.dart' as http;
```

the best practice is that k aap apne application ko restart kare.

### ab iss se hamare pass console me fetc is complete jub print hoga tho iss ka matlab hy k hamare pass data api se fetch ho rha hy.
```bash
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = []; // bhai yaha pr api ka data hum list me call krwaynge.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Call"),
      ),
      // body: ,
      //floating acetion button for api on click calling. matlab aik function k click hone pr etc.
     floatingActionButton: FloatingActionButton(onPressed: fetchUser),
      
    );
  }
  void fetchUser()async{
    print("hello world");
    const url = 'https://randomuser.me/api/?results=10'; // yaha pr apne api ko paste krdena hy jo b ho aap k pass.
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
```

## ab iss data ko ui me in list me show krwana hy.
below is the complete verson of api calling

```bash
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = []; // bhai yaha pr api ka data hum list me call krwaynge.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Call"),
      ),
      body:ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
        final user = users[index];
        final email = user['email']; // jo b cheez aap ko chaye hy oss ko iss trha pehly yaha pe access krna hy or phir call krna hy jaise title etc. 
        final name = user['name']['first'];
        //agr key na hogi jaise email etc tho pir ye aap ko error throw karega tho api k andar jo key hy oss k hisab se kaam kare.
        final imageUrl = user['picture']['thumbnail'];
        return ListTile(
          // leading: Text('${index+1}'), iss se indexing hoti hy.
          // leading: CircleAvatar(child: Text('${index+1}'),), // iss se aap ki indexing beautifully circular avatar me dikhengi.
          leading: CircleAvatar(child: Image.network(imageUrl)),
          title: Text(name),
          subtitle: Text(email),
        );
      }) ,
      //floating acetion button for api on click calling. matlab aik function k click hone pr etc.
     floatingActionButton: FloatingActionButton(onPressed: fetchUser),
      
    );
  }
  void fetchUser()async{
    print("hello world");
    const url = 'https://randomuser.me/api/?results=100'; // yaha pr apne api ko paste krdena hy jo b ho aap k pass.
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
```

# A.i Complete Explanation

Sure! Let's break down the provided Flutter code step by step. This code is designed to create a simple application that fetches user data from a public API and displays it in a list format.

## Overview of the Code

The code consists of a Flutter application with a single screen (HomePage) that fetches user data from the Random User Generator API and displays it in a list. The key components include:

1. **Imports**: The necessary packages for Flutter and HTTP requests.
2. **HomePage Class**: A stateful widget that represents the main screen.
3. **State Management**: The `_HomePageState` class manages the state of the HomePage, including fetching and displaying data.
4. **Fetching Data**: A method to call the API and update the UI with the fetched data.

### Detailed Breakdown

#### Imports

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
```

- `dart:convert`: This library is used for encoding and decoding JSON data.
- `flutter/material.dart`: This package provides Flutter's material design widgets.
- `http`: This package is used to make HTTP requests.

#### HomePage Class

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

- This class defines a stateful widget called `HomePage`. 
- It overrides the `createState` method to create an instance of `_HomePageState`.

#### _HomePageState Class

```dart
class _HomePageState extends State<HomePage> {
  List<dynamic> users = []; // List to hold user data from API.
```

- This class manages the state of `HomePage`.
- It initializes an empty list called `users` to store user data fetched from the API.

#### Building the UI

```dart
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
        final email = user['email'];
        final name = user['name']['first'];
        final imageUrl = user['picture']['thumbnail'];

        return ListTile(
          leading: CircleAvatar(child: Image.network(imageUrl)),
          title: Text(name),
          subtitle: Text(email),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(onPressed: fetchUser),
  );
}
```

- **Scaffold**: Provides a structure for the visual interface, including an AppBar and body.
- **AppBar**: Displays the title "Rest Api Call".
- **ListView.builder**: Creates a scrollable list of items based on the `users` list.
  - `itemCount`: Specifies how many items to display (length of `users`).
  - `itemBuilder`: Builds each item in the list:
    - It extracts user information (name, email, image URL) from each user object.
    - Displays each user's name and email in a `ListTile`, with their image shown in a circular avatar.
- **FloatingActionButton**: A button that triggers the `fetchUser` method when pressed.

#### Fetching User Data

```dart
void fetchUser() async {
  print("hello world");
  const url = 'https://randomuser.me/api/?results=100';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);

  setState(() {
    users = json['results'];
  });
  print("fetch is completed");
}
```

- **fetchUser()**: An asynchronous method that fetches user data from the API.
  - It prints "hello world" to indicate that the function has been called.
  - It specifies the API URL to fetch random users (100 results).
  - It sends a GET request using the `http.get` method and waits for the response.
  - The response body is decoded from JSON format into a Dart object.
  - The `setState` method updates the `users` list with the fetched data, triggering a rebuild of the UI.
  - Finally, it prints "fetch is completed" to indicate that fetching is done.

### Summary

This Flutter application demonstrates how to make an API call using HTTP, decode JSON data, and display it in a user-friendly format. When you press the floating action button, it fetches user data from an external API and updates the UI accordingly. 

You can enhance this application by adding error handling, loading indicators, or more detailed information for each user based on your requirements!










