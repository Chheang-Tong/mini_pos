package com.example.minipos_app

import android.util.Log
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.api.CommandApi

class SunmiCommandPrinter(private val printer: Printer?) {

    private val commandApi: CommandApi? = printer?.commandApi()

    fun printEscPos(escArgument: ByteArray?): String {
        if (escArgument == null || commandApi == null) {
            Log.e("SunmiCommandPrinter", "ESC command failed: null argument or API")
            return "error"
        }
        commandApi.sendEscCommand(escArgument)
        return "ok"
    }

    fun printTSPL(tsplArgument: ByteArray?): String {
        if (tsplArgument == null || commandApi == null) {
            Log.e("SunmiCommandPrinter", "TSPL command failed: null argument or API")
            return "error"
        }
        commandApi.sendTsplCommand(tsplArgument)
        return "ok"
    }
}
