import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_ticket_b68/src.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        home: HomePrinterView()),
  );
  await PosTicket.bindPrinterService();
}

class HomePrinterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.bindPrinterService();

                  await PosTicket.printText(
                      text: AppConst.nameCompany, bold: true, size: 20);
                  await PosTicket.printText(
                      text: AppConst.addressConpany,
                      bold: false,
                      size: 18,
                      underLine: false);
                  await PosTicket.printText(
                      text:
                          "${AppConst.taxCodeName} ${AppConst.taxCodeCustomer}",
                      bold: false,
                      size: 20);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text: AppConst.nameTicket, bold: false, size: 27);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.fareTicket} ${AppConst.moneyTicket} đồng",
                      bold: false,
                      size: 25);
                  await PosTicket.setAlignment(1);
                  //giờ vào
                  await PosTicket.printText(
                      text:
                          "${AppConst.ticketStartingDateHP} ${DateTime.now().hour} h ${DateTime.now().minute} p",
                      bold: false,
                      size: 20);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.day} ${DateTime.now().day} ${AppConst.month} ${DateTime.now().month} ${AppConst.year} ${DateTime.now().year}",
                      bold: false,
                      size: 19);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.ncc} ${AppConst.nameCompanyNCC} - ${AppConst.nameTaxCode} ${AppConst.taxCode} \n \t ${AppConst.custommerService} ${AppConst.phoneCustomerService}",
                      bold: true,
                      size: 17);
                  await PosTicket.printLine(3);
                },
                child: const Text("In vé"),
              ),
            ),
            // Center(
            //   child: ElevatedButton(
            //     // in table
            //     onPressed: () async {
            //       await PosTicket.bindPrinterService();
            //
            //       await PosTicket.printTable(size: 21, cols: [
            //         ColumnMaker(text: 'Name', width: 10, align: 0),
            //         ColumnMaker(text: 'Qty', width: 6, align: 1),
            //         ColumnMaker(text: 'UN', width: 10, align: 2),
            //         ColumnMaker(text: 'TOT', width: 10, align: 2),
            //       ]);
            //       await PosTicket.printTable(cols: [
            //         ColumnMaker(text: 'Fries', width: 10, align: 0),
            //         ColumnMaker(text: '4x', width: 6, align: 1),
            //         ColumnMaker(text: '3.00', width: 10, align: 2),
            //         ColumnMaker(text: '12.00', width: 10, align: 2),
            //       ]);
            //       await PosTicket.printTable(cols: [
            //         ColumnMaker(text: 'Sản phẩm A', width: 10, align: 0),
            //         ColumnMaker(text: '4x', width: 6, align: 1),
            //         ColumnMaker(text: '30.00000', width: 10, align: 2),
            //         ColumnMaker(text: '120.00000', width: 10, align: 2),
            //       ]);
            //     },
            //     child: const Text("In bảng hoá đơn"),
            //   ),
            // ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.bindPrinterService();

                  await PosTicket.printText(
                      text: AppConst.nameCompany2, bold: true, size: 20);
                  await PosTicket.printText(
                      text: AppConst.addressConpany2,
                      bold: false,
                      size: 18,
                      underLine: false);
                  await PosTicket.printText(
                      text:
                          "${AppConst.taxCodeName} ${AppConst.taxCodeCustomer}",
                      bold: false,
                      size: 21);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text: AppConst.nameTicket2, bold: false, size: 30);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text: AppConst.location, bold: false, size: 27);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.fareTicket} ${AppConst.moneyTicket2} đồng",
                      bold: false,
                      size: 25);

                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.ticketStartingDate} ${DateTime.now().hour} h ${DateTime.now().minute} p ",
                      bold: false,
                      size: 20);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.day} ${DateTime.now().day} ${AppConst.month} ${DateTime.now().month} ${AppConst.year} ${DateTime.now().year}",
                      bold: false,
                      size: 19);
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                      text:
                          "${AppConst.ncc} ${AppConst.nameCompanyNCC} - ${AppConst.nameTaxCode} ${AppConst.taxCode} \n \t ${AppConst.custommerService} ${AppConst.phoneCustomerService}",
                      bold: true,
                      size: 17);

                  await PosTicket.printLine(3);
                },
                child: const Text("Bắc Ninh - Thanh Hoá"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.bindPrinterService();

                  await PosTicket.printBarCode(
                      dataBarCode: "0123648445",
                      symbology: 1,
                      height: 162,
                      width: 2,
                      textposition: 1);
                },
                child: const Text("Bar code"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.bindPrinterService();
                  await PosTicket.startPrinterExam();
                },
                child: const Text("Ví dụ"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.bindPrinterService();

                  await PosTicket.setAlignment(1);
                  await PosTicket.printQr(
                      dataQRCode: "https://github.com/hueht21",
                      modulesize: 5,
                      errorlevel: 2);
                  await PosTicket.printLine(3);
                },
                child: const Text("qr code"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Uint8List byte =
                      await _getImageFromAsset('assets/images/dash.jpg');
                  await PosTicket.setAlignment(1);

                  await PosTicket.printImage(byte);
                  await PosTicket.printLine(2);
                },
                child: Text("In ảnh"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }
}

class AppConst {
  static const String nameCompany = "CÔNG TY TNHH GIẢI PHÁP ĐÔ THỊ NAM HẢI";
  static const String addressConpany = "Số 33 Ngõ 151 Láng Hạ, Đống Đa, Hà Nội";
  static const String nameTicket = "VÉ TRÔNG GIỮ XE Ô TÔ";
  static const String fareTicket = "Giá vé: ";
  static const String ticketStartingDateHP = "Giờ xe vào:";
  static const String day = "ngày";
  static const String month = "tháng";
  static const String year = "năm";
  static const String ncc = "NCC";
  static const String nameTaxCode = "MST";
  static const String taxCode = "0105987432";
  static const String nameCompanyNCC = "Softdreams";
  static const String custommerService = "CSKH";
  static const String moneyTicket = "25,000";
  static const String phoneCustomerService = "19003369";
  static const String taxCodeName = "Mã số thuế:";
  static const String taxCodeCustomer = "12589654";

  static const String nameCompany2 = "CÔNG TY CPTVXDMT VÀ VT THÀNH AN";
  static const String addressConpany2 =
      "Thôn 7, X.Thọ Lộc, H.Thọ Xuân, Thanh Hoá";
  static const String nameTicket2 = "VÉ XE KHÁCH";
  static const String moneyTicket2 = "90,000";
  static const String ticketStartingDate = "Thời gian xuất  bến: ";
  static const String location = "Bắc Ninh - Thanh Hoá";
}

const String PATTERN_1 = "dd/MM/yyyy";
const String PATTERN_DD = "dd";
const String PATTERN_MM = "MM";
const String PATTERN_YY = "yyyy";
const String PATTERN_2 = "dd/MM";
const String PATTERN_3 = "yyyy-MM-dd'T'HHmmss";
const String PATTERN_4 = "h:mm a dd/MM";
const String PATTERN_5 = "yyyy-MM-dd HH:mm:ss";
const String PATTERN_6 = "dd/MM/yyyy HH:mm";
const String PATTERN_7 = "HH:mm dd/MM/yyyy";
const String PATTERN_8 = "yyyy-MM-ddTHH:mm:ss";
const String PATTERN_9 = "HH:mm - dd/MM/yyyy";
const String PATTERN_10 = "dd/MM/yyyy HH:mm:ss";
const String PATTERN_11 = "HH:mm";
const String PATTERN_DEFAULT = "yyyy-MM-dd";

String convertDateToString(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}
