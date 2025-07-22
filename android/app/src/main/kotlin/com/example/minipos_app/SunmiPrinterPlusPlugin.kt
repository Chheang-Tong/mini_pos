package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class SunmiPrinterPlusPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var sunmiPrinter: SunmiPrinterClass? = null
    private var configPrinter: SunmiConfigClass? = null
    private var printerCommand: SunmiCommandPrinter? = null
    private var sunmiLCD: SunmiLCDClass? = null
    private var sunmiDrawer: SunmiDrawerClass? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_printer_plus")
        channel.setMethodCallHandler(this)

        val context: Context = flutterPluginBinding.applicationContext
        val sunmiInit = SunmiInitClass(context)

        sunmiInit?.initPrinter { selectPrinter ->
            if (selectPrinter != null) {
                configPrinter = SunmiConfigClass(selectPrinter)
                sunmiPrinter = SunmiPrinterClass(selectPrinter)
                printerCommand = SunmiCommandPrinter(selectPrinter)
                sunmiLCD = SunmiLCDClass(selectPrinter)
                sunmiDrawer = SunmiDrawerClass(selectPrinter)
                Log.d("SunmiPlugin", "Printer configured.")
                Log.i("SunmiPrinterPlusPlugin", "Sunmi printer initialized.")
            } else {
                Log.e("SunmiPrinterPlusPlugin", "No Sunmi printer found or failed to initialize.")
            }
        }

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_printer_plus")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        if (!ensurePrinterReady(result)) return
        if(sunmiPrinter==null||configPrinter==null){
            result.error("PRINTER_NOT_READY","Printer is not initialized yet", null)
        }

        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
            "getStatus" -> result.success(configPrinter?.getStatus())
            "getVersion" -> result.success(configPrinter?.getVersion())
            "getPaper" -> result.success(configPrinter?.getPaper())
            "getId" -> result.success(configPrinter?.getId())
            "getType" -> result.success(configPrinter?.getType())

            "printText" -> {
                val args: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter?.printText(args))
            }

            "printQrcode" -> {
                val args: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter?.printQrcode(args))
            }

            "printBarcode" -> {
                val args: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter?.printBarcode(args))
            }

            "printLine" -> {
                val lineArg: String? = call.argument("data")
                result.success(sunmiPrinter?.printLine(lineArg))
            }

            "lineWrap" -> {
                val times: Int = call.argument("times") ?: 1
                result.success(sunmiPrinter?.lineWrap(times))
            }

            "cutPaper" -> {
                result.success(sunmiPrinter?.cutPaper())
            }

            "printImage" -> {
                val bytes: ByteArray? = call.argument("image")
                val align: String? = call.argument("align")
                if (bytes != null) {
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success(sunmiPrinter?.printImage(bitmap, align))
                } else {
                    result.error("INVALID_IMAGE", "Image bytes missing", null)
                }
            }

            "addText" -> {
                val args: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter?.addText(args))
            }

            "printRow" -> {
                val args: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter?.printRow(args ?: emptyMap()))
            }

            "printEscPos" -> {
                val escList: List<Int>? = call.argument("data")
                if (escList == null) {
                    result.error("INVALID_ARGUMENT", "ESC data missing", null)
                    return
                }
                val escBytes = escList.map { it.toByte() }.toByteArray()
                result.success(printerCommand?.printEscPos(escBytes))
            }

            "printTSPL" -> {
                val tsplString: String? = call.argument("data")
                if (tsplString == null) {
                    result.error("INVALID_ARGUMENT", "TSPL string missing", null)
                    return
                }
                val tsplBytes = tsplString.toByteArray(Charsets.US_ASCII)
                result.success(printerCommand?.printTSPL(tsplBytes))
            }

            "configLCD" -> {
                val status: String? = call.argument("status")
                result.success(sunmiLCD?.configLCD(status))
            }

            "sendTextLCD" -> {
                val text: String = call.argument("text") ?: ""
                val size: Int = call.argument("size") ?: 32
                val fill: Boolean = call.argument("fill") ?: false
                result.success(sunmiLCD?.sendTextLCD(text, size, fill))
            }

            "showDigital" -> {
                val digital: String = call.argument("digital") ?: ""
                result.success(sunmiLCD?.showDigital(digital))
            }

            "sendImageLCD" -> {
                val bytes: ByteArray? = call.argument("image")
                if (bytes != null) {
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success(sunmiLCD?.sendImageLCD(bitmap))
                } else {
                    result.error("INVALID_IMAGE", "LCD image bytes missing", null)
                }
            }

            "openDrawer" -> result.success(sunmiDrawer?.openDrawer())
            "isDrawerOpen" -> result.success(sunmiDrawer?.isDrawerOpen())
//            "printerReady" -> {
//                result.success(::configPrinter.isInitialized && ::sunmiPrinter.isInitialized)
//            }
            "printerReady" -> {
                result.success(sunmiPrinter != null && configPrinter != null)
            }


            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun ensurePrinterReady(result: MethodChannel.Result): Boolean {
        if (sunmiPrinter == null || configPrinter == null) {
            result.error("PRINTER_NOT_READY", "Printer is not initialized yet", null)
            return false
        }
        return true
    }
}
