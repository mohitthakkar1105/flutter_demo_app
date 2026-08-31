// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import '../core/constants/api_constants.dart';

// class RazorpayService {
//   //sab se pehle hum razorpay ka instance banate hai
//   late Razorpay _razorpay;

//   // ye banana zaruri hai
//   final Function(PaymentSuccessResponse) onSuccess;
//   final Function(PaymentFailureResponse) onError;
//   final Function(ExternalWalletResponse) onExternalWallet;
//   final Function()? onCancel;

//   RazorpayService({
//     required this.onSuccess,
//     required this.onError,
//     required this.onExternalWallet,
//     this.onCancel,
//   });

//   void init() {
//     //init hone pe instance me value daal di or 3 event handeler hai ye
//     // dhyan rakhna hamesha ye init state me hi hoga
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess); // success pe kya hoga uska function banana padega
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError); // errorme kya hoga uska uska function banana padega
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet); //
//   }

//   void _handleError(PaymentFailureResponse response) {
//     // ✅ PEHLE YE PRINT KARO — exact values dekho
//     print("❌ Payment Error Code: ${response.code}");
//     print("❌ Payment Error Message: ${response.message}");
//     print("❌ Payment Error: ${response.error}");

//     if (response.code == Razorpay.PAYMENT_CANCELLED ||
//         response.code == 0 ||
//         response.message?.toLowerCase().contains('cancel') == true) {
//       onCancel?.call();
//     } else {
//       onError(response);
//     }
//   }

//   void openCheckout({
//     required int    amount,    // API se: data['amount'] milega sab
//     required String orderId,   // API se: data['orderId'] ye bhi
//     String customerName  = '', // nats ke response ka model banake acces hoga
//     String customerPhone = '', // nats ke response ka model banake acces hoga
//     String customerEmail = '', //nats ke response ka model banake acces hoga
//   }) {
//     final options = {
//       'key'        : ApiConstants.RAZORPAY_KEY, // key milegi apan ko
//       'amount'     : amount,    //  addBalance API se , dynamic
//       'order_id'   : orderId,   //  addBalance API se , dynamic
//       'name'       : 'CabnCar',
//       'description': 'Wallet Recharge',
//       'prefill'    : {
//         'name'    : customerName,   //  ProfileProvider.profile.fullName , dynamic
//         'contact' : customerPhone,  //  ProfileProvider.profile.phone , dynamic
//         'email'   : customerEmail,  //  ProfileProvider.profile.email , dynamic
//       },
//       'theme' : {'color': '#34D399'},
//       'modal' : {'confirm_close': true},
//     };

//     try {
//       _razorpay.open(options); // sab sahi hua to open , ye bhot zaruri hai yahan se hi razor pay open hota hai
//     } catch (e) {
//       print("Razorpay open error: $e"); // warna exeption
//     }
//   }

//   void dispose() {
//     _razorpay.clear(); // bad ,me disponse kar diya
//   }
// }

// // screen pe
// // step 1
// //payment success pe kiya dikhna hai
// // void _onPaymentSuccess(PaymentSuccessResponse response) async {
// //   _showToast("Payment successful! 🎉", success: true);
// //   await context.read<WalletProvider>().onPaymentSuccess(); // ✅ balance refresh
// // }

// //error me kya dikhna hai
// // void _onPaymentError(PaymentFailureResponse response) {
// //   _showToast("Payment failed: ${response.message ?? 'Try again'}", success: false);
// // }
// //
// // void _onExternalWallet(ExternalWalletResponse response) {
// //   _showToast("Redirecting to ${response.walletName}...", success: true);
// // }

// //step 2
// // or jiss screen me callling uske liye ye karo  init me
// // razorpayService = RazorpayService(
// // onSuccess:       _onPaymentSuccess,
// // onError:         _onPaymentError,
// // onExternalWallet: _onExternalWallet,
// // onCancel: () => _showToast("Payment cancelled", success: false),
// // );
// // _razorpayService!.init();


// // step 3
// // or buttom pe ye karo
// //
// // void _launchRazorpay(Map<String, dynamic> order) {
// //   // ✅ ProfileProvider se name, phone, email
// //   final profile = context.read<ProfileProvider>().profile;
// //
// //   _razorpayService?.openCheckout(
// //     amount:        (order['amount'] as num).toInt(), // ✅ safe cast
// //     orderId:       order['orderId'] as String, // ✅ addBalance API se
// //     customerName:  profile?.fullName ?? '',    // ✅ ProfileProvider se
// //     customerPhone: profile?.phone    ?? '',    // ✅ ProfileProvider se
// //     customerEmail: profile?.email    ?? '',    // ✅ ProfileProvider se
// //   );
// // }