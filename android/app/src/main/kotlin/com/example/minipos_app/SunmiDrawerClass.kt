package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.api.CashDrawerApi

class SunmiDrawerClass(private val printer: Printer?) {

    private val cashDrawerApi: CashDrawerApi? = printer?.cashDrawerApi()

    fun openDrawer(): String {
        return if (cashDrawerApi != null) {
            cashDrawerApi.open(null)
            "OK"
        } else {
            "Drawer API not available"
        }
    }

    fun isDrawerOpen(): Boolean {
        return cashDrawerApi?.isOpen ?: false
    }
}
