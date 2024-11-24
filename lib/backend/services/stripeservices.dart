import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/data_store/book_vehicle_backend.dart';
import 'package:karconnect/features/dashboard/dashbord.dart';
import 'package:karconnect/utils/constants/api_constants.dart';

enum PaymentStatus { success, canceled, failed }

class PaymentResult {
  final PaymentStatus status;
  final String? message;

  PaymentResult({required this.status, this.message});
}

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();
  final Dio _dio = Dio();

  Future<PaymentResult> makePayment(
      {required int amount,
      required String email,
      required String VehicleID,
      required String startDate,
      required String startTime,
      required String endDate,
      required String endTime,
      String currency = "lkr"}) async {
    try {
      final paymentIntentClientSecret =
          await _createPaymentIntent(amount, currency);
      if (paymentIntentClientSecret == null) {
        return PaymentResult(
            status: PaymentStatus.failed,
            message: 'Failed to create payment intent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "KarConnect",
          style: ThemeMode.system,
        ),
      );

      await _processPayment();
      //______________________________________
      addRentedVehicle(VehicleID, startDate, endDate, startTime, endTime);
      RentedVehicleList(VehicleID, startDate, endDate, startTime, endTime);
      updateVehicleAvailability(VehicleID);

      // Only send email if payment was successful
      final emailSent = await _sendPaymentConfirmationEmail(
          amount: amount,
          currency: currency,
          email: email,
          vehicleId: VehicleID,
          pickupdate: startDate,
          dropoffdate: endDate);

      Get.to(() => dashboard());

      if (!emailSent) {
        print(
            'Warning: Payment successful but confirmation email failed to send');
      }

      return PaymentResult(status: PaymentStatus.success);
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return PaymentResult(
            status: PaymentStatus.canceled, message: 'Payment was canceled');
      }
      return PaymentResult(
          status: PaymentStatus.failed,
          message: 'Payment failed: ${e.error.localizedMessage}');
    } catch (e) {
      return PaymentResult(
          status: PaymentStatus.failed, message: 'Unexpected error: $e');
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final response = await _dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": _calculateAmount(amount),
          "currency": currency,
          "payment_method_types[]": "card"
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${APIConstants.stripesecreatkey}",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      return response.data["client_secret"];
    } catch (e) {
      print('Failed to create payment intent: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }

  Future<bool> _sendPaymentConfirmationEmail(
      {required String email,
      required int amount,
      required String vehicleId,
      required String pickupdate,
      required String dropoffdate,
      required String currency}) async {
    try {
      final emailData = {
        "personalizations": [
          {
            "to": [
              {"email": email}
            ],
            "subject": "Payment Confirmation - KarConnect"
          }
        ],
        "from": {"email": "artworkshop690@gmail.com", "name": "KarConnect"},
        "content": [
          {
            "type": "text/html",
            "value": """
            <!DOCTYPE html>
            <html>
            <head>
              <style>
                body {
                  font-family: Arial, sans-serif;
                  line-height: 1.6;
                  color: #333333;
                  margin: 0;
                  padding: 0;
                }
                .container {
                  max-width: 600px;
                  margin: 0 auto;
                  padding: 20px;
                }
                .header {
                  background-color: #2196F3;
                  color: white;
                  padding: 20px;
                  text-align: center;
                  border-radius: 8px 8px 0 0;
                }
                .content {
                  background-color: #ffffff;
                  padding: 30px;
                  border-radius: 0 0 8px 8px;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }
                .booking-details {
                  background-color: #f5f5f5;
                  padding: 20px;
                  border-radius: 8px;
                  margin: 20px 0;
                }
                .detail-row {
                  display: flex;
                  justify-content: space-between;
                  margin: 10px 0;
                  border-bottom: 1px solid #eeeeee;
                  padding-bottom: 5px;
                }
                .amount {
                  font-size: 24px;
                  color: #2196F3;
                  text-align: center;
                  margin: 20px 0;
                }
                .footer {
                  text-align: center;
                  margin-top: 30px;
                  padding-top: 20px;
                  border-top: 1px solid #eeeeee;
                  color: #666666;
                }
                .social-links {
                  margin: 15px 0;
                }
                .social-links a {
                  margin: 0 10px;
                  color: #2196F3;
                  text-decoration: none;
                }
                .support-text {
                  color: #888888;
                  font-size: 14px;
                }
              </style>
            </head>
            <body>
              <div class="container">
                <div class="header">
                  <h1>Booking Confirmed!</h1>
                </div>
                
                <div class="content">
                  <h2>Thank you for choosing KarConnect!</h2>
                  <p>Your vehicle booking has been successfully confirmed. Here are your booking details:</p>
                  
                  <div class="booking-details">
                    <div class="detail-row">
                      <strong>Booking ID : </strong>
                      <span>$vehicleId</span>
                    </div>
                    <div class="detail-row">
                      <strong>Booking Date : </strong>
                      <span>${DateTime.now()}</span>
                    </div>
                    <div class="detail-row">
                      <strong>Pickup date : </strong>
                      <span>$pickupdate</span>
                    </div>
                    <div class="detail-row">
                      <strong>Drop-off date:</strong>
                      <span>$dropoffdate</span>
                    </div>
                  </div>

                  <div class="amount">
                    <strong>Total Amount:</strong><br>
                    ${amount.toString()} ${currency.toUpperCase()}
                  </div>

                  <p class="support-text">
                    If you need to modify your booking or have any questions, please don't hesitate to contact our support team.
                  </p>

                  <div class="footer">
                    <strong>KarConnect</strong>
                    <p>Your Trusted Vehicle Rental Partner</p>
                    <p>123 Main Street, Nugegoda, Colombo</p>
                    <p>Phone: +94 112 45 2569</p>
                    <div class="social-links">
                      <a href="#">Facebook</a> |
                      <a href="#">Twitter</a> |
                      <a href="#">Instagram</a>
                    </div>
                    <p class="support-text">© ${DateTime.now().year} KarConnect. All rights reserved.</p>
                  </div>
                </div>
              </div>
            </body>
            </html>
            """
          }
        ]
      };

      final response = await _dio.post(
        "https://api.sendgrid.com/v3/mail/send",
        data: emailData,
        options: Options(
          headers: {
            "Authorization": "Bearer ${APIConstants.SENDGRID_API_KEY}",
            "Content-Type": "application/json",
          },
        ),
      );

      return response.statusCode == 202;
    } catch (e) {
      print("Failed to send email: $e");
      return false;
    }
  }
}
