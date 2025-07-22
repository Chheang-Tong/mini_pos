package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.util.Log
import com.sunmi.printerx.PrinterSdk
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.PrinterSdk.PrinterListen
import com.sunmi.printerx.SdkException

class SunmiInitClass(private val context: Context) {

    var selectedPrinter: Printer? = null

    fun initPrinter(callback: (Printer?) -> Unit) {
        Log.d(TAG, "Initializing Sunmi Printer")

        try {
            PrinterSdk.getInstance().getPrinter(context, object : PrinterListen {

                override fun onDefPrinter(printer: Printer) {
                    selectedPrinter = printer
                    Log.d(TAG, "Default printer found: $printer")
                    callback(printer)
                }

                override fun onPrinters(printers: List<Printer>) {
                    Log.d(TAG, "Available printers count: ${printers.size}")
                    // Optional: You can allow manual selection if more than one printer is available
                }
            })
        } catch (e: SdkException) {
            Log.e(TAG, "Printer initialization failed: ${e.message}", e)
            callback(null)
        }
    }

    companion object {
        private const val TAG = "SunmiInit"
    }
}
