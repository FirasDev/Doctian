import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'Constant.dart';
import 'SharedManager.dart';
// import 'package:health_care/Screens/AppointmentDetails/Appointmentdetails.dart';
// import 'package:health_care/Screens/CartList/CartList.dart';
import '_notificationList.Dart';


setHeaderTitle(String title,dynamic color){

  // return new Text(title,
  //     style: new TextStyle(
  //       color: color,
  //       fontWeight: FontWeight.w600,
  //       fontSize: 22,
  //     ),
  //     textAlign: TextAlign.center,
  // );
  
  return new AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: new TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

setCommonText(String title,dynamic color,dynamic fontSize,dynamic fontweight,dynamic noOfLine){

  //This is for the normal text.
  // return new Text(
  //   title,
  //   style: new TextStyle(
  //     color: color,
  //     fontSize: fontSize,
  //     fontWeight: fontweight,
  //   ),
  //   maxLines: noOfLine,
  //   overflow: TextOverflow.ellipsis,
  // );

  return new AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: new TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
  );
}


  setCommonTextFieldForFillTheDetails(String hinttext,dynamic myIcon){
      return new Container(
              height: 50,
              // color: Colors.teal,
              padding: new EdgeInsets.only(left: 12,right: 25,bottom: 4,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColor.themeColor)
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(myIcon,color: Colors.grey,size: 18,),
                  SizedBox(width: 5,),
                  new Expanded(
                    child: new TextFormField(
                      textDirection: SharedManager.shared.direction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hinttext,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                        ),
                      ),
                      style: new TextStyle(
                        color: Colors.black87,
                        fontSize: 16
                      ),
                    ),
                  )
                ],
              ),
            );
}

setWidgetsForList(String imgUrl,String name,String role,String distance,String review,bool isOnline){
    return new Container(
      height: 120,
      padding: new EdgeInsets.only(left:15,right: 15,top: 8,bottom: 8),
      child: new Material(
        // color: Colors.yellow,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5),
        child: new Padding(
          padding: new EdgeInsets.all(5),
          child: new Row(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: AppColor.themeColor
                      ),
                      image: DecorationImage(
                        image: AssetImage(imgUrl),
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                  new Positioned(
                    left: 65,
                    right: 5,
                    top: 10,
                    child: new Container(
                      height: 8,
                      width: 8,
                      child: new Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 12,),
              Expanded(
                flex: 4,
                child: new Container(
                  height: 120,
                  // color: Colors.red,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      setCommonText(name, Colors.black, 17.0, FontWeight.w600, 1),
                      SizedBox(height: 5,),
                      setCommonText(role, Colors.grey, 15.0, FontWeight.w500, 1),
                      SizedBox(height: 2,),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.place,
                          size: 18,
                          color: Colors.grey[400],
                          ),
                          setCommonText("$distance km away", Colors.grey[400], 15.0, FontWeight.w600, 1),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: new Container(
                  padding: new EdgeInsets.only(top: 8,right: 5),
                  height: 120,
                  // color: Colors.green,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.star_border,color:AppColor.themeColor,size: 20,),
                      SizedBox(width: 3,),
                      FittedBox(
                        child: setCommonText(review, Colors.black, 15.0, FontWeight.w600, 1),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
}


setAppointmentListView(int index,BuildContext context){
  return new InkWell(
    onTap: (){
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AppointmentDetails()));
    },
      child: new Container(
      padding: new EdgeInsets.only(top:7,bottom: 7),
      height: 100,
      child: new Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: new Padding(
            padding: new EdgeInsets.only(right: 10),
            child: new Row(
            children: <Widget>[
              new Container(
                color:AppColor.themeColor,
                height: 50,
                width: 2,
              ),
              SizedBox(width:8,),
              new Expanded(
                child: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("Periodic health check",Colors.black,16.0, FontWeight.w600,2),
                      SizedBox(height: 5,),
                      setCommonText("11AM - 3PM",Colors.grey,15.0, FontWeight.w600,2),
                    ],
                  ),
                ),
              ),
              new Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: AppColor.themeColor
                          ),
                          image: DecorationImage(
                            image: AssetImage(AppImage.doctorList),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
            ],
          ),
        ),
      ),
    ),
  );
}


setCommonCartNitificationView(BuildContext context){
  return <Widget>[
            new Container(
              height: 20,
              width: 30,
              child: new InkWell(
                        onTap: (){
                          // Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>CartList()));
                        },
                        child: new Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                        Icon(Icons.shopping_cart,color: Colors.white,size: 25,),
                          Positioned(
                            top: 8,
                            left:13,
                            child: Container(
                              height: 16,
                              width: 16,
                              child: new Material(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                                child: new Center(
                                  child: setCommonText(SharedManager.shared.count.toString(),Colors.black54, 12.0, FontWeight.w500, 1),
                                )
                              ),
                            )
                          )
                        ],
                      ),
              ),
            ),
            new Container(
              height: 20,
              width: 30,
              child: new InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationsScreen()));
                        },
                        child: new Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                        Icon(Icons.notifications,color: Colors.white,size: 25,),
                          Positioned(
                            top: 8,
                            left:13,
                            child: Container(
                              height: 16,
                              width: 16,
                              child: new Material(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                                child: new Center(
                                  child: setCommonText("7",Colors.black54, 12.0, FontWeight.w500, 1),
                                )
                              ),
                            )
                          )
                        ],
                      ),
              ),
            ),
            SizedBox(width: 20,)
          ];
}