package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.api.QueryApi
import com.sunmi.printerx.enums.PrinterInfo

class SunmiConfigClass(private val printer: Printer?) {

    private val queryApi: QueryApi? = printer?.queryApi()

    fun getStatus(): String {
        return queryApi?.status?.toString() ?: "Unknown Status"
    }

    fun getVersion(): String {
        return queryApi?.getInfo(PrinterInfo.VERSION)?.toString() ?: "Unknown Version"
    }

    fun getPaper(): String {
        return queryApi?.getInfo(PrinterInfo.PAPER)?.toString() ?: "Unknown Paper Info"
    }

    fun getId(): String {
        return queryApi?.getInfo(PrinterInfo.ID)?.toString() ?: "Unknown ID"
    }

    fun getType(): String {
        return queryApi?.getInfo(PrinterInfo.TYPE)?.toString() ?: "Unknown Type"
    }
}
