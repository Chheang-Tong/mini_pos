package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import android.graphics.Bitmap
import android.util.Log
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.SdkException
import com.sunmi.printerx.api.LcdApi
import com.sunmi.printerx.enums.Command

class SunmiLCDClass(private val printer: Printer?) {

    private val lcdApi: LcdApi? = printer?.lcdApi()

    fun configLCD(lcdStatus: String?): String {
        return try {
            val command = when (lcdStatus?.uppercase()) {
                "INIT" -> Command.INIT
                "WAKE" -> Command.WAKE
                "CLEAR" -> Command.CLEAR
                "SLEEP" -> Command.SLEEP
                else -> Command.CLEAR
            }
            lcdApi?.config(command)
            "OK"
        } catch (e: SdkException) {
            Log.e(TAG, "LCD config error: ${e.message}", e)
            "ERROR"
        }
    }

    fun sendTextLCD(textData: String, textSize: Int, textFill: Boolean): String {
        return try {
            lcdApi?.showText(textData, textSize, textFill)
            "OK"
        } catch (e: SdkException) {
            Log.e(TAG, "LCD text error: ${e.message}", e)
            "ERROR"
        }
    }

    fun showDigital(digitalData: String): String {
        return try {
            lcdApi?.showDigital(digitalData)
            "OK"
        } catch (e: SdkException) {
            Log.e(TAG, "LCD digital error: ${e.message}", e)
            "ERROR"
        }
    }

    fun sendImageLCD(bitmap: Bitmap): String {
        return try {
            lcdApi?.showBitmap(bitmap)
            "OK"
        } catch (e: SdkException) {
            Log.e(TAG, "LCD image error: ${e.message}", e)
            "ERROR"
        }
    }

    companion object {
        private const val TAG = "SunmiLCD"
    }
}
