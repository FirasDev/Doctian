import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/searchResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  List<SearchResult> _list = [];
  List<SearchResult> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    final response = await http.get(API_URL + "/patient/doctors/", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Result : " + jsonResponse.toString());
      setState(() {
        _list = (jsonResponse as List)
            .map((data) => new SearchResult.fromJson(data))
            .toList();
        loading = false;
      });
    }
  }

  TextEditingController searchController = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // || (f.distance < double.parse(text))
    _list.forEach((f) {
      print("------->" + text);
      if (f.doctor.specialty.contains(text) ||
          f.doctor.name.contains(text) ||
          f.doctor.lastName.contains(text)) {
        _search.add(f);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blueAccent,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: searchController,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        searchController.clear();
                        onSearch('');
                      }),
                ),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _search.length != 0 ||
                            searchController.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _search.length,
                            itemBuilder: (context, i) {
                              final b = _search[i];
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(b.doctor.lastName +
                                        " " +
                                        b.doctor.name),
                                    Text(b.distance.toString())
                                  ],
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, i) {
                              final a = _list[i];
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(a.doctor.lastName +
                                        " " +
                                        a.doctor.name),
                                    Text(a.distance.toString())
                                  ],
                                ),
                              );
                            },
                          ),
                  )
          ],
        ),
      ),
    );
  }
}
