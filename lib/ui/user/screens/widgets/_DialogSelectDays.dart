import 'package:flutter/material.dart';

class SelectWorkDay extends StatefulWidget {
  SelectWorkDay({
    this.days,
    this.selectedDays,
    this.onSelectedDaysListChanged,
  });

  final List<String> days;
  final List<String> selectedDays;
  final ValueChanged<List<String>> onSelectedDaysListChanged;

  @override
  SelectWorkDayState createState() => SelectWorkDayState();
}

class SelectWorkDayState extends State<SelectWorkDay> {
  List<String> _tempSelectedDays = [];

  @override
  void initState() {
    _tempSelectedDays = widget.selectedDays;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(196, 139, 198, 0.3),
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Days',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: RaisedButton(
                    child: Text('Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                        )),
                    color: Color.fromRGBO(110, 120, 247, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.days.length,
                itemBuilder: (BuildContext context, int index) {
                  final cityName = widget.days[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(cityName),
                        value: _tempSelectedDays.contains(cityName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedDays.contains(cityName)) {
                              setState(() {
                                _tempSelectedDays.add(cityName);
                              });
                            }
                          } else {
                            if (_tempSelectedDays.contains(cityName)) {
                              setState(() {
                                _tempSelectedDays.removeWhere(
                                    (String city) => city == cityName);
                              });
                            }
                          }
                          widget.onSelectedDaysListChanged(_tempSelectedDays);
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
