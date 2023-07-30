# pos_ticket_b68

# I have implemented a lot of other features described below, the typeface is bolder
# I have updated version 1.0.7 with more features
# Important:
**THIS PACKAGE WILL WORK ONLY IN ANDROID! POSB68**
- [x] Jump (n) lines
- [x] Bold mode on/off
- [x] Adjustable font size
- [x] Can print qrcode
- [x] Use SignikaNegative-Bold font as large font
- [x] Use OpenSans-Bold font as large font
- [x] Set font size 20 as center font size to separate two typefaces
- [x] Cut paper - Dedicated method just to cut the line

## Tested Devices

B68

## import packages
import 'package:pos_ticket_b68/pos_ticket_b68.dart.dart';
                
await PosTicket.bindPrinterService();// Initialize the printer

 ```
## Example of printing a parking ticket
    await PosTicket.bindPrinterService();/
    await PosTicket.printText(
       text: AppConst.addressConpany,
       posFormatText: PosFormatText(
        textSize: 18,
       ),
    );
    await PosTicket.printLine(3); // Jump (3) lines

## Example
    await PosTicket.bindPrinterService();
    await PosTicket.startPrinterExam();

## Example of printing qrcode
    await PosTicket.bindPrinterService();
    await PosTicket.setAlignment(1);
    await PosTicket.printQr(
      dataQRCode: "https://github.com/HVLoc",
      modulesize: 20,
      align: PosAlignment.ALIGN_CENTER,
    );
    await PosTicket.printLine(3);

## Set Font 
    await PosTicket.printText(
        text: "DEFAULT",
        posFormatText: PosFormatText(
            textFont: PosTextFont.DEFAULT,
        ),
    );
