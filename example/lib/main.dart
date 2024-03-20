import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_ticket_b68/pos_ticket_b68.dart';

bool canPrint = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        home: HomePrinterView()),
  );
}

class HomePrinterView extends StatefulWidget {
  @override
  State<HomePrinterView> createState() => _HomePrinterViewState();
}

class _HomePrinterViewState extends State<HomePrinterView> {
  @override
  void initState() {
    // Check có phải b68 không?
    if (Platform.isAndroid) {
      try {
        PosTicket.initPrinter().then((value) {
          print(value);
          canPrint = value ?? false;
        });
      } catch (e) {
        canPrint = false;
      }
    }
    super.initState();
  }

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
                  await PosTicket.initPrinter();
                  await PosTicket.printLine(3);
                  await PosTicket.printText(
                    text: AppConst.nameCompany,
                    posFormatText: PosFormatText(
                      textStyle: PosTextStyle.BOLD,
                    ),
                  );
                  await PosTicket.printText(
                    text: AppConst.addressConpany,
                    posFormatText: PosFormatText(
                      textSize: 18,
                    ),
                  );
                  await PosTicket.printText(
                    text: "${AppConst.taxCodeName} ${AppConst.taxCodeCustomer}",
                  );
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                    text: AppConst.nameTicket,
                    posFormatText: PosFormatText(
                      textSize: 27,
                      alignment: PosAlignment.ALIGN_CENTER,
                    ),
                  );
                  await PosTicket.printText(
                    text: "BKS: 12346",
                    posFormatText: PosFormatText(
                      textSize: 30,
                      alignment: PosAlignment.ALIGN_CENTER,
                      lineSpacing: 0.5,
                    ),
                  );
                  await PosTicket.printText(
                    text: "${AppConst.fareTicket} ${AppConst.moneyTicket} đồng",
                    posFormatText: PosFormatText(
                      textSize: 25,
                      alignment: PosAlignment.ALIGN_CENTER,
                    ),
                  );
                  //giờ vào
                  await PosTicket.printText(
                    text:
                        "${AppConst.ticketStartingDateHP} ${DateTime.now().hour} h ${DateTime.now().minute} p",
                    posFormatText: PosFormatText(
                      alignment: PosAlignment.ALIGN_CENTER,
                    ),
                  );
                  await PosTicket.setAlignment(1);
                  await PosTicket.printText(
                    text:
                        "${AppConst.day} ${DateTime.now().day} ${AppConst.month} ${DateTime.now().month} ${AppConst.year} ${DateTime.now().year}",
                    posFormatText: PosFormatText(
                      alignment: PosAlignment.ALIGN_OPPOSITE,
                    ),
                  );

                  await PosTicket.printText(
                    text:
                        "${AppConst.ncc} ${AppConst.nameCompanyNCC}-${AppConst.nameTaxCode} ${AppConst.taxCode}-${AppConst.custommerService} ${AppConst.phoneCustomerService}",
                    posFormatText: PosFormatText(
                      textSize: 17,
                      alignment: PosAlignment.ALIGN_CENTER,
                    ),
                  );

                  await PosTicket.cutPaper();
                },
                child: const Text("In vé"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String status = await PosTicket.printStatus();

                  await PosTicket.printText(
                    text: "Status:  $status",
                    posFormatText: PosFormatText(
                      textSize: 17,
                      alignment: PosAlignment.ALIGN_CENTER,
                    ),
                  );
                },
                child: const Text("Status"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.initPrinter();

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
                  await PosTicket.initPrinter();
                  await PosTicket.startPrinterExam();
                },
                child: const Text("Ví dụ"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.initPrinter();

                  await PosTicket.printText(
                    text: "DEFAULT",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.DEFAULT,
                    ),
                  );
                  await PosTicket.printText(
                    text: "DEFAULT_BOLD",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.DEFAULT_BOLD,
                    ),
                  );
                  await PosTicket.printText(
                    text: "MONOSPACE",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.MONOSPACE,
                    ),
                  );
                  await PosTicket.printText(
                    text: "SANS_SERIF",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.SANS_SERIF,
                    ),
                  );
                  await PosTicket.printText(
                    text: "SERIF",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.SERIF,
                    ),
                  );
                  await PosTicket.printText(
                    text: "CUSTOM",
                    posFormatText: PosFormatText(
                      textFont: PosTextFont.CUSTOM,
                    ),
                  );
                  await PosTicket.printLine(3);
                },
                child: const Text("Text Font "),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await PosTicket.initPrinter();

                  await PosTicket.setAlignment(1);
                  await PosTicket.printQr(
                    dataQRCode: "https://github.com/HVLoc",
                    modulesize: 15,
                    align: PosAlignment.ALIGN_CENTER,
                  );
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

                  await PosTicket.printImage(byte, PosAlignment.ALIGN_CENTER);
                  await PosTicket.printLine(3);
                  await PosTicket.printText(text: ' ');
                  await PosTicket.cutPaper();
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
  static const String nameCompany = "GIẢI PHÁP QUẢN LÝ CHỢ THÔNG MINH";
  static const String addressConpany =
      "Số 1212 Ngõ 4 Láng Hạ, Hoàng Mai, Hà Nội";
  static const String nameTicket = "VÉ TRÔNG GIỮ XE Ô TÔ";
  static const String fareTicket = "Giá vé: ";
  static const String ticketStartingDateHP = "Giờ xe vào:";
  static const String day = "Ngày";
  static const String month = "tháng";
  static const String year = "năm";
  static const String ncc = "NCC";
  static const String nameTaxCode = "MST: ";
  static const String taxCode = "1342543566";
  static const String nameCompanyNCC = "LocHV";
  static const String custommerService = "CSKH: ";
  static const String moneyTicket = "50,000";
  static const String phoneCustomerService = "0123456580";
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
