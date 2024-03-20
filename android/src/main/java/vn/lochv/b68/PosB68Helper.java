package vn.lochv.b68;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.RemoteException;
import android.text.Layout;
import android.text.Layout.Alignment;
import android.util.Log;
import android.widget.Toast;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.Printer;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.Sys;
import com.zcs.sdk.print.PrnStrFormat;
import com.zcs.sdk.print.PrnTextFont;
import com.zcs.sdk.print.PrnTextStyle;

import java.util.ArrayList;

/**
 * <pre>
 *      This class is used to demonstrate various printing effects
 *      Developers need to repackage themselves, for details please refer to
 *      http://-ota.oss-cn-hangzhou.aliyuncs.com/DOC/resource/re_cn/Sunmiprinter%E5%BC%80%E5%8F%91%E8%80%85%E6%96%87%E6%A1%A31.1.191128.pdf
 * </pre>
 *
 * @author kaltin
 * @since create at 2020-02-14
 */
public class PosB68Helper {

    private DriverManager mDriverManager;

    private Sys mSys;

    private Printer mPrinter;

    private PrnStrFormat formatPos = new PrnStrFormat();

    private Context _context;

    public PosB68Helper(Context context) {
        this._context = context;
    }

    private static final String TAG = "PrintB68";

    /**
     * init print service
     */
    public boolean initSdk() {
        if (!isEmulator()) {
            mDriverManager = DriverManager.getInstance();
            mPrinter = mDriverManager.getPrinter();
            mSys = mDriverManager.getBaseSysDevice();
            int status = mSys.sdkInit();
            if (status != SdkResult.SDK_OK) {
                mSys.sysPowerOn();
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            status = mSys.sdkInit();
            if (status != SdkResult.SDK_OK) {
                return false;
            }
            return true;
        }
        return false;
    }

    private boolean isEmulator() {
        return (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")) || Build.FINGERPRINT.startsWith("generic") || Build.FINGERPRINT.startsWith("unknown") || Build.HARDWARE.contains("goldfish") || Build.HARDWARE.contains("ranchu") || Build.MODEL.contains("google_sdk") || Build.MODEL.contains("Emulator") || Build.MODEL.contains("Android SDK built for x86") || Build.MANUFACTURER.contains("Genymotion") || Build.PRODUCT.contains("sdk_google") || Build.PRODUCT.contains("google_sdk") || Build.PRODUCT.contains("sdk") || Build.PRODUCT.contains("sdk_x86") || Build.PRODUCT.contains("vbox86p") || Build.PRODUCT.contains("emulator") || Build.PRODUCT.contains("simulator");
    }

    /**
     * Initialize the printer
     * All style settings will be restored to default
     */
    public void initPrinter() {
        try {
            mDriverManager = DriverManager.getInstance();
            mPrinter = mDriverManager.getPrinter();
        } catch (Exception e) {
            Log.d("Error", e.getMessage());
        }
    }

    /**
     * paper feed three lines
     * Not disabled when line spacing is set to 0
     */
    public void print3Line() {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }

        mPrinter.setPrintLine(3);

    }

    /**
     * Get printer serial number
     */
    // public String getPrinterSerialNo(){
    // if(mPrinter == null){
    // //TODO Service disconnection processing
    // return "";
    // }
    // try {
    // return mPrinter.getPrinterStatus();
    // } catch (RemoteException e) {
    // handleRemoteException(e);
    // return "";
    // }
    // }
    public void printLine(int line) {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }

        mPrinter.setPrintLine(line);
    }

    /**
     * Get paper specifications
     */
    public String getPrinterPaper() {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return "";
        }
        return mPrinter.is80MMPrinter() ? "80mm" : "58mm";
    }

    /**
     * Set printer alignment
     */
    public void setAlign(Layout.Alignment ali) {

        formatPos.setAli(ali);
    }

    /**
     * Set font size
     */
    public void setFontSize(int font) {

        formatPos.setTextSize(font);
    }

    public void printText(String content, PrnStrFormat format) {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }
        PrnStrFormat formatResult = format != null ? format : formatPos;
        mPrinter.setPrintAppendString(content, formatResult);
        mPrinter.setPrintStart();
    }

    /**
     * print Qr Code
     */
    public void printQr(String data, int height, int width, Layout.Alignment alignment) {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }

        int printStatus = mPrinter.getPrinterStatus();
        if (printStatus != SdkResult.SDK_PRN_STATUS_PAPEROUT) {
            mPrinter.setPrintAppendQRCode(data, width, height,
                    alignment != null ? alignment : Layout.Alignment.ALIGN_CENTER);
            printStatus = mPrinter.setPrintStart();
        }
    }

    // /**
    // * Print a row of a table
    // */
    // public void printTable(String[] txts, int[] width, int[] align, int size) {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // mPrinter.setFontName("OpenSans-Bold.ttf", null);
    // mPrinter.setFontSize(size, null);
    // mPrinter.printColumnsString(txts, width, align, null);
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    // }

    /**
     * Print pictures and text in the specified orde
     * After the picture is printed,
     * the line feed output needs to be called,
     * otherwise it will be saved in the cache
     * In this example, the image will be printed because the print text content is
     * added
     */
    public void printBitmap(Bitmap bitmap, Layout.Alignment alignment) {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }

        int printStatus = mPrinter.getPrinterStatus();
        if (printStatus != SdkResult.SDK_PRN_STATUS_PAPEROUT) {
            mPrinter.setPrintAppendBitmap(bitmap, alignment);
            printStatus = mPrinter.setPrintStart();
        }

    }

    // /**
    // * Gets whether the current printer is in black mark mode
    // */
    // public boolean isBlackLabelMode() {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return false;
    // }
    // try {
    // return mPrinter.getPrinterMode() == 1;
    // } catch (RemoteException e) {
    // return false;
    // }
    // }

    // /**
    // * Gets whether the current printer is in label-printing mode
    // */
    // public boolean isLabelMode() {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return false;
    // }
    // try {
    // return mPrinter.getPrinterMode() == 2;
    // } catch (RemoteException e) {
    // return false;
    // }
    // }

    /**
     * Transaction printing:
     * enter->print->exit(get result) or
     * enter->first print->commit(get result)->twice print->commit(get
     * result)->exit(don't care
     * result)
     */
    // public void printTrans(InnerResultCallback callbcak) {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // mPrinter.enterPrinterBuffer(true);
    // printExample();
    // mPrinter.exitPrinterBufferWithCallback(true, callbcak);
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    // }

    /**
     * Open cash box
     * This method can be used on devices with a cash drawer interface
     * If there is no cash box (such as V1、P1) or the call fails, an exception will
     * be thrown
     * <p>
     * Reference to
     * https://docs..com/general-function-modules/external-device-debug/cash-box-driver/}
     */
    public void openCashBox() {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }

        mPrinter.openBox();
    }

    /**
     * LCD screen control
     *
     * @param flag 1 —— Initialization
     *             2 —— Light up screen
     *             3 —— Extinguish screen
     *             4 —— Clear screen contents
     */
    // public void controlLcd(int flag) {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // mPrinter.sendLCDCommand(flag);
    // } catch (RemoteException e) {
    // handleRemoteException(e);
    // }
    // }

    /**
     * Display text ,font size is 16 and format is fill
     * sendLCDFillString(txt, size, fill, callback)
     * Since the screen pixel height is 40, the font should not exceed 40
     */
    // public void sendTextToLcd() {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // mPrinter.sendLCDFillString("", 16, true, new InnerLcdCallback() {
    // @Override
    // public void onRunResult(boolean show) throws RemoteException {
    // // TODO handle result
    // }
    // });
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    //
    // }

    /**
     * Display two lines and one empty line in the middle
     */
    // public void sendTextsToLcd() {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // String[] texts = {"", null, ""};
    // int[] align = {2, 1, 2};
    // mPrinter.sendLCDMultiString(texts, align, new InnerLcdCallback() {
    // @Override
    // public void onRunResult(boolean show) throws RemoteException {
    // // TODO handle result
    // }
    // });
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    //
    // }

    /**
     * Display one 128x40 pixels and opaque picture
     */
    // public void sendPicToLcd(Bitmap pic) {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    //
    // try {
    // mPrinter.sendLCDBitmap(pic, new InnerLcdCallback() {
    // @Override
    // public void onRunResult(boolean show) throws RemoteException {
    // // TODO handle result
    // }
    // });
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    //
    // }

    /**
     * Sample print receipt
     */
    public void printExample() {
        int printStatus = mPrinter.getPrinterStatus();
        if (printStatus == SdkResult.SDK_PRN_STATUS_PAPEROUT) {
            // out of paper
            Log.d(TAG, "Out of paper");
        } else {
            PrnStrFormat format = new PrnStrFormat();
            format.setTextSize(30);
            format.setAli(Layout.Alignment.ALIGN_CENTER);
            format.setStyle(PrnTextStyle.BOLD);
            // format.setFont(PrnTextFont.CUSTOM);
            // format.setPath(Environment.getExternalStorageDirectory() +
            // "/fonts/simsun.ttf");
            format.setFont(PrnTextFont.SANS_SERIF);
            mPrinter.setPrintAppendString("Phần mềm in vé", format);
            format.setTextSize(25);
            format.setStyle(PrnTextStyle.NORMAL);
            format.setAli(Layout.Alignment.ALIGN_NORMAL);
            mPrinter.setPrintAppendString(" ", format);
            mPrinter.setPrintAppendString("Thiết bị:" + " B68 ", format);
            mPrinter.setPrintAppendString("Smart Pos:" + "Máy in nhiệt có NFC ", format);
            mPrinter.setPrintAppendString("Căn cước công dân: ", format);
            format.setAli(Layout.Alignment.ALIGN_CENTER);
            format.setTextSize(30);
            format.setStyle(PrnTextStyle.BOLD);
            mPrinter.setPrintAppendString("6214 44** **** **** 7816", format);
            format.setAli(Layout.Alignment.ALIGN_NORMAL);
            format.setStyle(PrnTextStyle.NORMAL);
            format.setTextSize(25);
            mPrinter.setPrintAppendString(" -----------------------------", format);
            mPrinter.setPrintAppendString(" ", format);
            mPrinter.setPrintAppendString(" ", format);
            mPrinter.setPrintAppendString(" ", format);
            mPrinter.setPrintAppendString(" ", format);
            printStatus = mPrinter.setPrintStart();
        }
    }

    /**
     * Used to report the real-time query status of the printer, which can be used
     * before each
     * printing
     */
    public String showPrinterStatus() {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return "Chưa khởi tạo máy in";
        }
        String result = "Trạng thái không xác định";
        int res = mPrinter.getPrinterStatus();
        switch (res) {
            case SdkResult.SDK_PRN_STATUS_PRINTING:
                result = "Máy in đang xử lý";
                break;
            case SdkResult.SDK_PRN_STATUS_PAPEROUT:
                result = "Máy in hết giấy";
                break;
            case SdkResult.SDK_PAD_ERR_CANCEL:
                result = "Huỷ tiến trình in";
                break;
            case SdkResult.SDK_PAD_ERR_TIMEOUT:
                result = "Hết thời gian kết nối";
                break;
            case SdkResult.SDK_PAD_ERR_DUPLI_KEY:
                result = "Trùng mã in";
                break;
            case SdkResult.SDK_PAD_ERR_INVALID_INDEX:
                result = "Vị trí không hợp lệ";
                break;
            case SdkResult.SDK_INSTALL_SUCCESS:
                result = "Cài đặt thành công";
                break;
            case SdkResult.SDK_INSTALL_ERROR:
                result = "Cài đặt thất bại";
                break;
            case SdkResult.SDK_INSTALLING:
                result = "Đang cài đặt";
                break;
            case SdkResult.SDK_PRN_STATUS_FAULT:
                result = "Kết nối máy in lỗi";
                break;
            default:
                break;
        }
        Log.d(TAG, result);
        Toast.makeText(_context, result, Toast.LENGTH_LONG).show();
        return result;
    }

    /**
     * Demo printing a label
     * After printing one label, in order to facilitate the user to tear the paper,
     * call
     * labelOutput to push the label paper out of the paper hatch
     * 演示打印一张标签
     * 打印单张标签后为了方便用户撕纸可调用labelOutput,将标签纸推出纸舱口
     */
    public void cutPaper() {
        if (mPrinter == null) {
            // TODO Service disconnection processing
            return;
        }
        print3Line();
        print3Line();
        mPrinter.setPrintAppendString(" ", formatPos);
        mPrinter.setPrintAppendString(" ", formatPos);
        mPrinter.setPrintAppendString(" ", formatPos);
        mPrinter.setPrintStart();
    }

    /**
     * Demo printing multi label
     * <p>
     * After printing multiple labels, choose whether to push the label paper to the
     * paper hatch according to the needs
     * 演示打印多张标签
     * 打印多张标签后根据需求选择是否推出标签纸到纸舱口
     */
    // public void printMultiLabel(int num) {
    // if (mPrinter == null) {
    // // TODO Service disconnection processing
    // return;
    // }
    // try {
    // for (int i = 0; i < num; i++) {
    // mPrinter.labelLocate();
    // printLabelContent();
    // }
    // mPrinter.labelOutput();
    // } catch (RemoteException e) {
    // e.printStackTrace();
    // }
    // }

    /**
     * Custom label ticket content
     * In the example, not all labels can be applied. In actual use, please pay
     * attention to adapting the size of the label. You can adjust the font size and
     * content position.
     * 自定义的标签小票内容
     * 例子中并不能适用所有标签纸，实际使用时注意要自适配标签纸大小，可通过调节字体大小，内容位置等方式
     */
    // private void printLabelContent() throws RemoteException {
    // mPrinter.setPrinterStyle(WoyouConsts.ENABLE_BOLD, WoyouConsts.ENABLE);
    // mPrinter.lineWrap(1, null);
    // mPrinter.setAlignment(0, null);
    // mPrinter.printText("商品 豆浆\n", null);
    // mPrinter.printText("到期时间 12-13 14时\n", null);
    // mPrinter.printBarCode("{C1234567890123456", 8, 90, 2, 2, null);
    // mPrinter.lineWrap(1, null);
    // }

    // Convert Format
    public Alignment convertAli(int alignment) {
        switch (alignment) {
            case 1:
                return Alignment.ALIGN_OPPOSITE;
            case 2:
                return Alignment.ALIGN_CENTER;
            default:
                return Alignment.ALIGN_NORMAL;
        }
    }

    public PrnTextStyle convertTextStyle(int style) {
        switch (style) {
            case 1:
                return PrnTextStyle.BOLD;
            case 2:
                return PrnTextStyle.ITALIC;
            case 3:
                return PrnTextStyle.BOLD_ITALIC;
            default:
                return PrnTextStyle.NORMAL;
        }
    }

    public PrnTextFont convertTextFont(int style) {
        switch (style) {
            case 1:
                return PrnTextFont.DEFAULT;
            case 2:
                return PrnTextFont.DEFAULT_BOLD;
            case 3:
                return PrnTextFont.MONOSPACE;
            case 4:
                return PrnTextFont.SANS_SERIF;
            case 5:
                return PrnTextFont.SERIF;
            default:
                return PrnTextFont.CUSTOM;
        }
    }
}
