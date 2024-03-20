package vn.lochv.b68;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.Layout;
import android.util.Log;

import androidx.annotation.NonNull;

import vn.lochv.b68.PosB68Helper;

import org.json.JSONArray;
import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.Sys;
import com.zcs.sdk.print.PrnStrFormat;
import com.zcs.sdk.print.PrnTextFont;

public class PosPluginB68 implements FlutterPlugin, MethodCallHandler {
    private String CHANNEL = "posTicketB68/method_channel";

    PosB68Helper posB68Helper;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        final MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
        posB68Helper = new PosB68Helper(binding.getApplicationContext());

        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // super.configureFlutterEngine(flutterEngine);
        // GeneratedPluginRegistrant.registerWith(flutterEngine);
        // new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),
        // CHANNEL)
        // .setMethodCallHandler(
        // (call, result) -> {
        Log.d("POS", call.method);
        switch (call.method) {
            case "BIND_PRINTER_SERVICE":
                try {
                    posB68Helper.initPrinter();
                    result.success(true);
                } catch (Exception e) {
                    result.success(false);
                }
                break;
            // case "UNBIND_PRINTER_SERVICE":
            // mSys.
            // result.success(true);
            // break;
            case "PRINTER_EXAMPLE":
                posB68Helper.printExample();
                result.success(true);
                break;
            case "INIT_PRINTER":
                boolean connected = posB68Helper.initSdk();
                result.success(connected);
                break;
            // case "ENTER_PRINTER_BUFFER":
            // Boolean clearEnter = call.argument("clearEnter");
            // posB68Helper.exitPrinterBuffer(clearEnter);
            // result.success(true);
            // break;
            // case "EXIT_PRINTER_BUFFER":
            // Boolean clear = call.argument("clearExit");
            // posB68Helper.exitPrinterBuffer(clear);
            // result.success(true);
            // break;
            // case "COMMIT_PRINTER_BUFFER":
            // posB68Helper.commitPrinterBuffer();
            // result.success(true);
            // break;
            case "FONT_SIZE":
                int fontSize = call.argument("size");
                posB68Helper.setFontSize(fontSize);
                result.success(true);
                break;
            case "PRINT_TEXT":
                PrnStrFormat format = new PrnStrFormat();
                String text = call.argument("text");
                format.setStyle(posB68Helper.convertTextStyle(call.argument("style")));
                format.setUnderline(call.argument("underLine"));
                format.setTextScaleX(Float.parseFloat(call.argument("textScaleX").toString()));
                format.setLetterSpacing(Float.parseFloat(call.argument("letterSpacing").toString()));
                format.setLineSpacing(Float.parseFloat(call.argument("lineSpacing").toString()));
                format.setAli(posB68Helper.convertAli(call.argument("alignment")));
                format.setTextSize(call.argument("size"));
                format.setFont(posB68Helper.convertTextFont(call.argument("font")));
                posB68Helper.printText(text, format);
                result.success(true);
                break;
            case "PRINT_IMAGE":
                byte[] bytes = call.argument("bitmap");
                Layout.Alignment alignment = posB68Helper.convertAli(call.argument("alignment"));
                Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                posB68Helper.printBitmap(bitmap, alignment);
                result.success(true);
                break;

            case "CUT_PAPER":
                posB68Helper.cutPaper();
                result.success(true);
                break;
            case "SET_ALIGNMENT":
                Layout.Alignment align = posB68Helper.convertAli(call.argument("alignment"));

                posB68Helper.setAlign(align);
                result.success(true);
                break;
            case "LINE_WRAP":
                int lines = call.argument("lines");
                posB68Helper.printLine(lines);
                result.success(true);
                break;

            case "PRINTER_VERSION":
                String version = posB68Helper.getPrinterPaper();
                result.success(version);
                break;
            // case "PRINTER_SERIALNO":
            // String serialNo = posB68Helper.getPrinterSerialNo();
            // result.success(serialNo);
            // break;
            case "PRINT_QRCODE":
                String dataQRCode = call.argument("data");
                int heightQR = call.argument("height");
                int widthQR = call.argument("width");
                Layout.Alignment alignQR = posB68Helper.convertAli(call.argument("align"));
                posB68Helper.printQr(dataQRCode, heightQR, widthQR, alignQR);
                result.success(true);
                break;
            // case "PRINT_TABLE":
            // String colsStr = call.argument("cols");
            // int fontSizeT = call.argument("size");
            // try {
            // JSONArray cols = new JSONArray(colsStr);
            // String[] colsText = new String[cols.length()];
            // int[] colsWidth = new int[cols.length()];
            // int[] colsAlign = new int[cols.length()];
            // for (int i = 0; i < cols.length(); i++) {
            // JSONObject col = cols.getJSONObject(i);
            // String textColumn = col.getString("text");
            // int widthColumn = col.getInt("width");
            // int alignColumn = col.getInt("align");
            // colsText[i] = textColumn;
            // colsWidth[i] = widthColumn;
            // colsAlign[i] = alignColumn;
            // }
            //
            // posB68Helper.printTable(colsText, colsWidth, colsAlign, fontSizeT);
            // result.success(true);
            // } catch (Exception err) {
            // Log.d("SunmiPrinter", err.getMessage());
            // }
            // break;
            // case "PRINT_BITMAP":
            // Bitmap bitmap = call.argument("bitmap");
            // int orientation = call.argument("orientation");
            // sunmiPrintHelper.printBitmap(bitmap, orientation);
            // result.success(true);
            // break;
            case "PRINT_STATUS":
                String status = posB68Helper.showPrinterStatus();
                result.success(status);
                break;
            case "OPEN_CASH_BOX":
                posB68Helper.openCashBox();
                result.success(true);
                break;
            // case "SENT_RAW_DATA":
            // byte[] dataRaw = call.argument("data");
            // posB68Helper.sendRawData(dataRaw);
            // result.success(true);
            // break;
            // case "DEVICE_MODEL":
            // String deviceModel = posB68Helper.getDeviceModel();
            // result.success(deviceModel);
            // break;
            case "PRINT_PAPER":
                String getPrintPaper = posB68Helper.getPrinterPaper();
                result.success(getPrintPaper);
                break;
//            case "FEED_PAPER":
//                posB68Helper.feedPaper();
//                result.success(true);
//                break;
            // case "BACK_LABEL_MODE":
            // boolean isBackkLabel = posB68Helper.isBlackLabelMode();
            // result.success(isBackkLabel);
            // break;
            // case "LABEL_MODEL":
            // boolean isLabelMode = posB68Helper.isLabelMode();
            // result.success(isLabelMode);
            // break;
            // case "PRINT_TRANS":
            // posB68Helper.printTrans(null);
            // result.success(true);
            // break;
            // case "CONTROL_LCD":
            // int flag = call.argument("flag");
            // posB68Helper.controlLcd(flag);
            // result.success(true);
            // break;
            // case "SEND_TEXT_TOLCD":
            // posB68Helper.sendTextToLcd();
            // result.success(true);
            // break;
            // case "SEND_TEXTS_TOLCD":
            // posB68Helper.sendTextsToLcd();
            // result.success(true);
            // break;
            // case "SEND_PIC_TOLCD":
            // Bitmap pic = call.argument("pic");
            // posB68Helper.sendPicToLcd(pic);
            // result.success(true);
            // break;
            // case "PRINT_ONE_LABEL":
            // posB68Helper.printOneLabel();
            // result.success(true);
            // break;
            // case "PRINT_MULTILABEL":
            // int num = call.argument("num");
            // posB68Helper.printMultiLabel(num);
            // result.success(true);
            // break;
            // case "PRINTE_HEAD":
            // posB68Helper.getPrinterHead(null);
            // result.success(true);
            // break;
            // case "PRINTE_DISTANCE":
            // posB68Helper.getPrinterDistance(null);
            // result.success(true);
            // break;

        }
        // });
    }
}
