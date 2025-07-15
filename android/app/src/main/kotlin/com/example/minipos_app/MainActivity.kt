
package com.example.minipos_app

import android.content.*
import android.os.*
import android.util.Log
import android.content.pm.PackageManager
import com.sunmi.peripheral.printer.SunmiPrinterService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var sunmiPrinterService: SunmiPrinterService? = null
    private var printerReady = false
    private var isBound = false
    private lateinit var methodChannel: MethodChannel

    // ServiceConnection for Sunmi printer
    private val connection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            sunmiPrinterService = SunmiPrinterService.Stub.asInterface(service)
            printerReady = true
            Log.d("Printer", "✅ Printer service connected!")
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            sunmiPrinterService = null
            printerReady = false
            Log.d("Printer", "❌ Printer service disconnected")
        } 
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = Intent("com.sunmi.peripheral.printer.InnerService")
        intent.setPackage("com.sunmi.peripheral.printer")

        try {
            packageManager.getPackageInfo("com.sunmi.peripheral.printer", 0)
            bindService(intent, connection, Context.BIND_AUTO_CREATE)
            isBound = true
            Log.d("Printer", "✅ Sunmi printer service bound")
        } catch (e: PackageManager.NameNotFoundException) {
            Log.w("Printer", "❌ Sunmi printer service not available")
        }

        val manufacturer =Build.MANUFACTURER
        val model= Build.MODEL
        Log.d("DEVICE_INFO", "manufacturer:$manufacturer,Model:$model")
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isBound) {
            unbindService(connection)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.minipos_app/printer")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getPrinterType" -> {
                    val printerType = detectPrinterType()
                    Log.d("Printer", "🔍 Detected printer type: $printerType")
                    result.success(printerType)
                }

                "printText" -> {
                    val text = call.argument<String>("text") ?: ""
                    val printerType = detectPrinterType()

                    when (printerType) {
                        "sunmi" -> {
                            if (!printerReady || sunmiPrinterService == null) {
                                result.error("SERVICE_NULL", "Sunmi printer not connected", null)
                                return@setMethodCallHandler
                            }
                            try {
                                sunmiPrinterService?.printText(text + "\n", null)
                                sunmiPrinterService?.lineWrap(3, null)
                                result.success(true)
                            } catch (e: Exception) {
                                result.error("PRINT_ERROR", e.message, null)
                            }
                        }

                        "z100c" -> {
                            sendZ100CIntentPrint(text)
                            result.success(true)
                        }

                        else -> {
                            result.error("UNSUPPORTED_PRINTER", "Generic printer not supported here", null)
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
    // ✅ Detect the printer type
    private fun detectPrinterType(): String {
        val pm = packageManager
        return try {
            pm.getPackageInfo("com.sunmi.peripheral.printer", 0)
            "sunmi"
        } catch (e: PackageManager.NameNotFoundException) {
            try {
                pm.getPackageInfo("com.zkc.print", 0) // TODO: Replace with correct package for your Z100C
                "z100c"
            } catch (e2: Exception) {
                "generic"
            }
        }
    }

    private fun sendZ100CIntentPrint(text: String) {
        Log.d("Printer", "📤 Sending Z100C print broadcast: $text")
        try {
            val intent = Intent()
            intent.action = "com.zkc.print.send"
            intent.putExtra("content", text)
            intent.putExtra("type", "text")
            sendBroadcast(intent)
            Log.d("Printer", "✅ Broadcast sent to Z100C printer")
        } catch (e: Exception) {
            Log.e("Printer", "❌ Print failed: ${e.message}")
        }
    }


}
