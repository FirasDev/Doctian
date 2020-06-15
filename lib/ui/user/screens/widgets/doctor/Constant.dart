

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;



bool get isIos =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

class AppColor{

    static var pagingIndicatorColor = Colors.red;
    static var themeColor = HexToColor("#7193e8");
    // static var themeColor = HexToColor("#79CABD");
    // static var themeColor = HexToColor("#f2bd68");
    // static var themeColor = HexToColor("#9468f2");
    // static var themeColor = HexToColor("#f268b4");
    // static var themeColor = HexToColor("#f26868");
    
    
}

class HexToColor extends Color{
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }
  HexToColor(final String code) : super(_hexToColor(code));
}


class AppString{
static var onBoard1Descript =  "onBoard1Descript";
static var onBoard2Descript =  "onBoard2Descript";
static var onBoard3Descript =  "onBoard3Descript";
static var onBoardTitle1 =  "onBoardTitle1";
static var onBoardTitle2 =  "onBoardTitle2";
static var onBoardTitle3 =  "onBoardTitle3";
static var onBoardSkip =  "onBoardSkip";
}

class AppImage{
  static var onBoardImg1 = "assets/Onboarding/doctor.png";
  static var onBoardImg2 = "assets/Onboarding/medication.png";
  static var onBoardImg3 = "assets/Onboarding/appointment.png";
  static var appLogo = "assets/Login/Logo.png";
  static var doctorList = "assets/images/chokri_hammouda.png";
  static var doctorProfileMessage = "assets/DoctorProfile/message.png";
  static var doctorProfilePhone = "assets/DoctorProfile/phone.png";
  static var doctorProfile = "assets/images/chokri_hammouda.png";
  static var drugImage = "assets/DrugsList/drugImage.png";
  static var paymentCard = "assets/Checkout/Card.png";
  static var paymentCod = "assets/Checkout/Cod.png";
  static var paymentPaypal = "assets/Checkout/paypal.png";
  static var paymentSuccess = "assets/Checkout/success.png";
  static var blogFoodImage = "assets/Blogs/food.jpeg";
  static var drProfile2 = "assets/DoctorList/doctor2.jpg";
  static var drProfile3 = "assets/DoctorList/doctor3.png";
  static var drProfile4 = "assets/DoctorList/doctor4.png";
  static var drProfile5 = "assets/DoctorList/doctor5.png";
  static var drProfile6 = "assets/DoctorList/doctor6.png";
  static var drProfile7 = "assets/DoctorList/doctor7.png";
  static var drProfile8 = "assets/DoctorList/doctor8.png";
  static var hispital = "assets/Hospital/hospital1.png";
}

class AppTitle{
  //OnBoarding
  static var onBoardTitle1 = "onBoardTitle1";
  static var onBoardTitle2 = "onBoardTitle2";
  static var onBoardTitle3 = "onBoardTitle3";
  static var onBoardSkip = "onBoardSkip";
  static var getStarted = "onBoardGetStarted";

  //Login
  static var loginUserName = "loginUserName";
  static var password = "password";
  static var rememberMe = "rememberMe";
  static var loginSignIn = "loginSignIn";
  static var loginFbSignIn = "loginFbSignIn";
  static var loginForgetPass = "loginForgetPass";
  static var loginSignUp = "loginSignUp";
  static var loginDontHaveAccount = "loginDontHaveAccount";

//Forgot Password
static var forgetPassStr = "forgetPassStr";
static var forgotPassEmail = "forgotPassEmail";
static var forgotPassSendEmail = "forgotPassSendEmail";

//Sign Up
static var signUpConfirmPass = "signUpConfirmPass";
static var signUpNote = "signUpNote";

//Create Account

static var createAccountFullName = "createAccountFullName";
static var createAccountDOB = "createAccountDOB";
static var createAccountGender = "createAccountGender";
static var createAccountWeight = "createAccountWeight";
static var createAccountHeight = "createAccountHeight";
static var createAccountTitle = "createAccountTitle";


//Dashboard

static var dashbFindDoctor = "dashbFindDoctor";
static var dashbFindHospital = "dashbFindHospital";
static var dashbAppointment = "dashbAppointment";
static var dashbPriceServices = "dashbPriceServices";
static var appTitle = "appTitle";
static var doctorAvaliability = "doctorAvaliability";
static var hospitalAvaliability = "hospitalAvaliability";
static var appointmentAvaliability = "appointmentAvaliability";
static var priceServicesAvaliability = "priceServicesAvaliability";
static var dashbHello = "dashbHello";
static var dashbTitleNote = "dashbTitleNote";

//Drawer
static var drawerHome = "drawerHome";
static var drawerDoctors = "drawerDoctors";
static var drawerBlogs = "drawerBlogs";
static var drawerIndicators = "drawerIndicators";
static var drawerProfile = "drawerProfile";
static var drawerLogout = "drawerLogout";
static var drawerShare = "drawerShare";
static var drawerRateUs = "drawerRateUs";

//Blogs

static var blogFood = "blogFood";
static var blogFitness = "blogFitness";
static var blogLifestyle = "blogLifestyle";
static var blogDruge = "blogDruge";

//Indicators
static var indicatorDetails = "indicatorDetails";
static var indicatorGoal = "indicatorGoal";

//Profile
static var profileGoalSetting = "profileGoalSetting";
static var profileDoctorFav = "profileDoctorFav";
static var profileWeight = "profileWeight";
static var profileOrders = "profileOrders";

//Find Doctor
static var findDoChooseHospital = "findDoChooseHospital";
static var findDoctor = "findDoctor";
static var findDoctorDate = "findDoctorDate";
static var findDoctorTime = "findDoctorTime";
static var findDoctorBtnFind = "findDoctorBtnFind";

//Doctor's Profile

static var doctorsProfile = "doctorsProfile";
static var bookAppointment = "bookAppointment";
static var personalInfo = "personalInfo";
static var workAddress = "workAddress";
static var reviewer = "reviewer";
static var reviews = "reviews";

//Doctor Personal Informations
static var informations = "informations";
static var about = "about";
static var addressandTiming = "addressandTiming";
static var phone = "phone";
static var degree = "degree";
static var maps = "googleMap";
static var hospital = "hospital";
static var bookNow = "bookNow";
static var appointmentDetails = "appointmentDetails";
static var cancelAppointment = "cancelAppointment";
static var orderService = "orderService";
static var total = "total";

//Drug List and Shop
static var drugList = "drugList";
static var drugShop = "drugShop";

//IndicatorTest

static var insurance = "insurance";
static var enrollId = "enrollId";
static var dateEffective = "dateEffective";
static var group = "group";
static var plan = "plan";
static var basic = "basic";
static var premium = "premium";
static var indicatortest = "indicatortest";

//Indicator Details
static var progress = "progress";
static var min = "min";
static var max = "max";

//Add A weight
static var addWeight = "addWeight";

//Order List
static var orderList = "orderList";
static var orderNumber = "orderNumber";
static var orderDate = "orderDate";
static var paymentType = "paymentType";
static var shippingAdress = "shippingAdress";
static var pending = "pending";
static var details = "details";

//Order Details
static var orderDetails = "orderDetails";
static var totlaAmountTopay = "totlaAmountTopay";
static var deliveryAddress = "deliveryAddress";
static var contact = "contact";
static var deliveryArea = "deliveryArea";
static var orderAgain = "orderAgain";

//Cart List
static var cartList = "cartList";
static var checkOut = "checkOut";
static var itemNotFound = "itemNotFound";
static var itemDeleted = "itemDeleted";

//CheckOut
static var totalAmount = "totalAmount";
static var discountAmount = "discountAmount";
static var grandTotal = "grandTotal";
static var proceedToCheckOut = "proceedToCheckOut";

//Payment Success
static var thankYou = "thankYou";
static var successMsg = "successMsg";
static var haveAGreatDay = "haveAGreatDay";
static var checkOrder = "checkOrder";
static var notification = "notification";
static var reply = "reply";
static var typeHere = "typeHere";
static var calling = "calling";

//Appointment Details

static var overallExamition = "overallExamition";
static var bloodTest = "bloodTest";

//DrugDetails
static var whatIsAtomic = "whatIsAtomic";
static var importantInfo = "importantInfo";
static var sideEffets = "sideEffets";
static var buyNow = "buyNow";

}


class UserDefaultKeys{
  static var isOnboarding = "isFirstTime";
}

class TextFontHeight{
  static var large = 25;
  static var extraLarge = 30;
  static var medium = 17;
  static var small = 15;
}

class PersonalInfo{
  static var name = "Jems Anderson";
  static var email = "jems_anderson007@hotmail.com";
}



//AppTranslations.of(context).text(AppTitle.loginFbSignIn)



//AIzaSyD4NPvMOrW9BVCzPamcXnee7-1RQlY-OwY     IOS GOOGLE MAP API KEY
//AIzaSyAaYKc8uSif9QLBLk1v7x4SAuq4PFJJhkY      Android MAP API KEY