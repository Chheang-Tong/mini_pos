package com.example.minipos_app

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


/** SunmiPrinterPlusPlugin */
class SunmiPrinterPlusPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var sunmiPrinter: SunmiPrinterClass? = null
    private var sunmiInit: SunmiInitClass? = null
    private var configPrinter: SunmiConfigClass? = null
    private var printerCommand: SunmiCommandPrinter? = null
    private var sunmiLCD: SunmiLCDClass? = null
    private var sunmiDrawer: SunmiDrawerClass? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val context: Context = flutterPluginBinding.getApplicationContext()
        sunmiInit = SunmiInitClass(context);
        sunmiInit.initPrinter { selectPrinter ->
            if (selectPrinter != null) {
                configPrinter = SunmiConfigClass(selectPrinter)
                sunmiPrinter = SunmiPrinterClass(selectPrinter)
                printerCommand = SunmiCommandPrinter(selectPrinter)
                sunmiLCD = SunmiLCDClass(selectPrinter)
                sunmiDrawer = SunmiDrawerClass(selectPrinter)
            } else {
                Log.e("SunmiPrinterPlusPlugin", "No Sunmi printer found or failed to initialize.")
            }
        }
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_printer_plus")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${Build.VERSION.RELEASE}")
            }
            "printerReady" -> {
                result.success(sunmiPrinter != null && configPrinter != null)
            }

            "getStatus" -> {
                if (!ensurePrinterReady(result)) return
                result.success(configPrinter.getStatus())
            }

            "getVersion" -> {
                result.success(configPrinter.getVersion())
            }

            "getPaper" -> {
                result.success(configPrinter.getPaper())
            }

            "getId" -> {
                result.success(configPrinter.getId())
            }

            "getType" -> result.success(configPrinter.getType())

            "printText" -> {
                val printerArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.printText(printerArgument))
            }

            "printQrcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.printQrcode(qrcodeArgument))
            }

            "printBarcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.printBarcode(qrcodeArgument))
            }

            "printLine" -> {
                val lineArgument: String? = call.argument("data")
                result.success(sunmiPrinter.printLine(lineArgument))
            }

            "lineWrap" -> {
                val wrapArgument: Int = call.argument("times")?: 1
                result.success(sunmiPrinter.lineWrap(wrapArgument))
            }


            "cutPaper" -> {
                result.success(sunmiPrinter.cutPaper())
            }

            "printImage" -> {
                val bytes: ByteArray? = call.argument("image")
                val alignArgument: String? = call.argument("align")
                if(bytes != null){
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success(sunmiPrinter.printImage(bitmap,alignArgument))
                }else{
                    result.success("invalid")
                }
            }


            "addText" -> {
                val printerArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.addText(printerArgument))
            }

            "printEscPos" -> {
//                val escArgument: ByteArray = call.argument<List<Int>>("data")!!
//                    .map { it.toByte() }
//                    .toByteArray()
                val escList: List<Int>? = call.argument("data")
                if (escList == null) {
                    result.error("INVALID_ARGUMENT", "ESC data is missing", null)
                    return
                }
                val escArgument = escList.map { it.toByte() }.toByteArray()
                result.success(printerCommand.printEscPos(escArgument))
            }

            "printTSPL" -> {
                val tsplArgument: ByteArray = call.argument<String>("data")!!.toByteArray(Charsets.US_ASCII)
                result.success(printerCommand.printTSPL(tsplArgument))
            }


            "printRow" -> {
                val rowArguments: Map<String, Any> = call.argument("data")!!
                result.success(sunmiPrinter.printRow(rowArguments))
            }



            "configLCD" -> {
                val lcdStatus: String? = call.argument("status")
                result.success(sunmiLCD.configLCD(lcdStatus))
            }


            "sendTextLCD" -> {
                val textData: String = call.argument("text")?: ""
                val textSize: Int = call.argument("size")?: 32
                val textFill: Boolean = call.argument("fill")?: false
                result.success(sunmiLCD.sendTextLCD(textData,textSize,textFill))
            }

            "showDigital" -> {
                val digitalData: String = call.argument("digital")?: ""

                result.success(sunmiLCD.showDigital(digitalData))
            }

            "sendImageLCD" -> {
                val bytes: ByteArray? = call.argument("image")
                if(bytes != null) {
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success( sunmiLCD.sendImageLCD(bitmap))
                } else {
                    result.error("INVALID_IMAGE", "Image bytes are missing", null)
                }
            }

            "openDrawer" -> {
                result.success(sunmiDrawer.openDrawer())
            }

            "isDrawerOpen" -> {
                result.success(sunmiDrawer.isDrawerOpen())
            }


            else -> {
                result.notImplemented()
            }
        }

    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun ensurePrinterReady(result: MethodChannel.Result): Boolean {
        if (!::sunmiPrinter.isInitialized || !::configPrinter.isInitialized) {
            result.error("PRINTER_NOT_READY", "Printer is not initialized yet", null)
            return false
        }
        return true
    }

}