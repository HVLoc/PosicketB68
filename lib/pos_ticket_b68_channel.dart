import 'package:flutter/services.dart';
import 'package:get_radio_version_plugin/get_radio_version_plugin.dart';
import 'package:pos_ticket_b68/pos_ticket_b68.dart';

class PosTicket {
  static const platform = MethodChannel('posTicketB68/method_channel');

  static Future<bool?> bindPrinterService() async {
    // Khởi tạo máy in
    final bool? status = await platform.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> initPrinter() async {
    // start máy in
    String radioVersion = '';
    try {
      radioVersion =
          await GetRadioVersionPlugin.radioVersion ?? 'Unknown radio version';
    } on PlatformException {
      radioVersion = 'Failed to get radio version.';
      return false;
    }

    if (!(radioVersion == '1.0.0.0' || radioVersion == '')) {
      try {
        final bool? status = await platform.invokeMethod('INIT_PRINTER');
        return status;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  ///*resetFontSize*
  ///
  ///This method will reset the font size to the medium (default) size
  static Future<void> resetFontSize() async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": 24};
    await platform.invokeMethod("FONT_SIZE", arguments);
  }

  static Future<void> startPrinterExam() async {
    // in ví dụ
    await platform.invokeMethod('PRINTER_EXAMPLE');
  }

  static Future<void> cutPaper() async {
    // cắt giấy
    await platform.invokeMethod('CUT_PAPER');
  }

  static Future<void> printLine(int line) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": line};
    await platform.invokeMethod('LINE_WRAP', arguments);
  }

  ///*line*
  ///
  ///With this method you can draw a line to divide sections.
  static Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    resetFontSize();
    await printText(
        text: List.filled(len, ch[0]).join(), posFormatText: PosFormatText());
  }

  ///*line*
  ///
  ///With this method you can draw a line to divide sections.
  static Future<void> lineDash({
    String ch = '- ',
    int len = 18,
  }) async {
    resetFontSize();
    await printText(
        text: List.filled(len, ch).join(), posFormatText: PosFormatText());
  }

  static Future<void> printText({
    required String text,
    PosFormatText? posFormatText,
  }) async {
    if (posFormatText == null) {
      posFormatText = PosFormatText();
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "text": '$text\n',
      "size": posFormatText.textSize,
      "style": posFormatText.textStyle,
      "underLine": posFormatText.isUnderline,
      "textScaleX": posFormatText.textScaleX,
      "letterSpacing": posFormatText.letterSpacing,
      "lineSpacing": posFormatText.lineSpacing,
      "alignment": posFormatText.alignment,
      "font": posFormatText.textFont,
    };
    await platform.invokeMethod("PRINT_TEXT", arguments);
  }

  static Future<void> setAlignment(int value) async {
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await platform.invokeMethod("SET_ALIGNMENT", arguments);
  }

  static Future<String> getPrinterVersion() async {
    return await platform.invokeMethod("PRINTER_VERSION");
  }

  static Future<void> printImage(Uint8List img, int alignment) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    arguments.addAll({"alignment": alignment});
    await platform.invokeMethod("PRINT_IMAGE", arguments);
  }

  static Future<String> getPrinterSerialNo() async {
    return await platform.invokeMethod("PRINTER_SERIALNO");
  }

  static Future<void> printDrawRow() async {
    await platform.invokeMethod("PRINT_DRAW_ROW");
  }

  static Future<void> printBarCode(
      {required String dataBarCode,
      required int symbology,
      required int height,
      required int width,
      required int textposition}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": dataBarCode,
      "symbology": symbology,
      "height": height,
      "width": width,
      "textposition": textposition
    };
    await platform.invokeMethod("PRINT_BARCODE", arguments);
  }

  static Future<void> printQr(
      {required String dataQRCode,
      required int modulesize,
      required int align}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": dataQRCode,
      "height": modulesize * 10,
      "width": modulesize * 10,
      "align": align
    };
    await platform.invokeMethod("PRINT_QRCODE", arguments);
  }

  static Future<String> printStatus() async {
    return await platform.invokeMethod("PRINT_STATUS");
  }

  static Future<String> getPrintPaper() async {
    return await platform.invokeMethod("PRINT_PAPER");
  }

  // static Future<void> feedPaper() async {
  //   await platform.invokeMethod("FEED_PAPER");
  // }

  static Future<bool> getBackLabelMode() async {
    return await platform.invokeMethod("BACK_LABEL_MODE");
  }

  static Future<bool> getLabelModel() async {
    return await platform.invokeMethod("LABEL_MODEL");
  }

  static Future<void> printTrans() async {
    await platform.invokeMethod("PRINT_TRANS");
  }

  static Future<void> controlLCD(int flag) async {
    Map<String, dynamic> arguments = <String, dynamic>{"flag": flag};
    await platform.invokeMethod("CONTROL_LCD", arguments);
  }

  static Future<void> sentTextLCD() async {
    await platform.invokeMethod("SEND_TEXT_TOLCD");
  }

  static Future<void> sentTextsLCD() async {
    await platform.invokeMethod("SEND_TEXTS_TOLCD");
  }

  static Future<void> printMultiLabel(int num) async {
    Map<String, dynamic> arguments = <String, dynamic>{"num": num};
    await platform.invokeMethod("PRINT_MULTILABEL", arguments);
  }

  static Future<void> printeHead() async {
    await platform.invokeMethod("PRINTE_HEAD");
  }

  static Future<void> printeDistance() async {
    await platform.invokeMethod("PRINTE_DISTANCE");
  }
}

// class ColumnMaker {
//   String text;
//   int width;
//   int align;
//   ColumnMaker({
//     this.text = '',
//     this.width = 2,
//     this.align = 0,
//   });
//   //Convert to json
//   Map<String, String> toJson() {
//     int value = 0;
//     switch (align) {
//       case 0:
//         value = 0;
//         break;
//       case 1:
//         value = 1;
//         break;
//       case 2:
//         value = 2;
//         break;
//       default:
//         value = 0;
//     }
//     return {
//       "text": text,
//       "width": width.toString(),
//       "align": value.toString(),
//     };
//   }
// }
