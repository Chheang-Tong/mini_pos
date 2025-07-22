package com.example.minipos_app
//package br.com.brasizza.sunmi_printer_plus

import android.graphics.Bitmap
import android.util.Log
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.SdkException
import com.sunmi.printerx.enums.Align
import com.sunmi.printerx.enums.DividingLine
import com.sunmi.printerx.enums.ErrorLevel
import com.sunmi.printerx.enums.HumanReadable
import com.sunmi.printerx.enums.ImageAlgorithm
import com.sunmi.printerx.enums.Symbology
import com.sunmi.printerx.style.BarcodeStyle
import com.sunmi.printerx.style.BaseStyle
import com.sunmi.printerx.style.BitmapStyle
import com.sunmi.printerx.style.QrStyle
import com.sunmi.printerx.style.TextStyle


class SunmiPrinterClass(private val printer: Printer?) {

    private val lineApi = printer?.lineApi()

    fun printText(printerArgument: Map<String, Any>?): String {
        if (printerArgument == null) return "No arguments provided"
        return try {
            val text = printerArgument["text"] as? String ?: return "No text provided to print"
            val textStyle = buildTextStyle(printerArgument)
            val align = getAlignment(printerArgument["align"] as? String)
            lineApi?.initLine(BaseStyle.getStyle().setAlign(align))
            lineApi?.printText(text, textStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e(TAG, "Error while printing text: ${e.message}", e)
            "error"
        }
    }

    fun printQrcode(qrcodeArgument: Map<String, Any>?): String {
        if (qrcodeArgument == null) return "No arguments provided"
        return try {
            val qrStyle = QrStyle.getStyle().apply {
                setDot(qrcodeArgument["qrcodeSize"] as? Int ?: 4)
                setErrorLevel(getErrorLevel(qrcodeArgument["errorLevel"] as? String))
                setAlign(getAlignment(qrcodeArgument["align"] as? String))
            }
            val qrText = qrcodeArgument["text"] as? String ?: return "No text provided for QR code"
            lineApi?.printQrCode(qrText, qrStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e(TAG, "Error while printing QR code: ${e.message}", e)
            "error"
        }
    }

    fun printBarcode(barcodeArgument: Map<String, Any>?): String {
        if (barcodeArgument == null) return "No arguments provided"
        return try {
            val barcodeStyle = BarcodeStyle.getStyle().apply {
                setDotWidth(barcodeArgument["size"] as? Int ?: 0)
                setBarHeight(barcodeArgument["height"] as? Int ?: 0)
                setReadable(getTextPosition(barcodeArgument["textPos"] as? String))
                setAlign(getAlignment(barcodeArgument["align"] as? String))
                setSymbology(getSymbology(barcodeArgument["type"] as? String))
            }
            val barcodeText = barcodeArgument["text"] as? String ?: return "No text provided for barcode"
            lineApi?.printBarCode(barcodeText, barcodeStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e(TAG, "Error while printing barcode: ${e.message}", e)
            "error"
        }
    }

    fun printLine(lineType: String?): String {
        val divider = when (lineType?.uppercase()) {
            "SOLID" -> DividingLine.SOLID
            "DOTTED" -> DividingLine.DOTTED
            else -> DividingLine.EMPTY
        }
        lineApi?.printDividingLine(divider, 1)
        return "ok"
    }

    fun lineWrap(times: Int): String {
        lineApi?.printDividingLine(DividingLine.EMPTY, times)
        return "ok"
    }

    fun cutPaper(): String {
        lineApi?.autoOut()
        return "ok"
    }

    fun printImage(bitmap: Bitmap?, align: String?): String {
        if (bitmap == null) return "No image provided"
        lineApi?.initLine(BaseStyle.getStyle().setAlign(getAlignment(align)))
        lineApi?.printBitmap(bitmap, BitmapStyle.getStyle().setAlgorithm(ImageAlgorithm.DITHERING))
        return "ok"
    }

    fun addText(printerArgument: Map<String, Any>?): String {
        if (printerArgument == null) return "No arguments provided"
        return try {
            val textStyle = buildTextStyle(printerArgument)
            val text = printerArgument["text"] as? String ?: return "No text provided to print"
            lineApi?.addText(text, textStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e(TAG, "Error while adding text: ${e.message}", e)
            "error"
        }
    }

    fun printRow(rowArguments: Map<String, Any>): String {
        return try {
            val widths = (rowArguments["width"] as? List<*>)?.filterIsInstance<Int>() ?: emptyList()
            val styles = (rowArguments["style"] as? List<*>)?.map { it as? Map<String, Any?> } ?: emptyList()
            val texts = (rowArguments["text"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()

            val textStyles = styles.map { style ->
                if (style == null) TextStyle.getStyle()
                else buildTextStyle(style.filterValues { it != null }.mapValues { it.value!! })
            }

            lineApi?.printTexts(
                texts.toTypedArray(),
                widths.toIntArray(),
                textStyles.toTypedArray()
            )
            "ok"
        } catch (e: SdkException) {
            Log.e(TAG, "Error while printing row: ${e.message}", e)
            "error"
        }
    }

    private fun buildTextStyle(args: Map<String, Any>): TextStyle {
        return TextStyle.getStyle().apply {
            setAlign(getAlignment(args["align"] as? String))
            setTextSize(args["fontSize"] as? Int ?: 24)
            enableBold(args["bold"] as? Boolean ?: false)
            enableUnderline(args["underline"] as? Boolean ?: false)
            enableStrikethrough(args["strikethrough"] as? Boolean ?: false)
            enableItalics(args["italic"] as? Boolean ?: false)
            enableAntiColor(args["reverse"] as? Boolean ?: false)
        }
    }

    private fun getAlignment(align: String?): Align {
        return when (align?.uppercase()) {
            "CENTER" -> Align.CENTER
            "LEFT" -> Align.LEFT
            "RIGHT" -> Align.RIGHT
            else -> Align.DEFAULT
        }
    }

    private fun getErrorLevel(level: String?): ErrorLevel {
        return when (level?.uppercase()) {
            "LEVEL_H" -> ErrorLevel.H
            "LEVEL_M" -> ErrorLevel.M
            "LEVEL_Q" -> ErrorLevel.Q
            else -> ErrorLevel.L
        }
    }

    private fun getTextPosition(position: String?): HumanReadable {
        return when (position?.uppercase()) {
            "NO_TEXT" -> HumanReadable.HIDE
            "TEXT_ABOVE" -> HumanReadable.POS_ONE
            "TEXT_UNDER" -> HumanReadable.POS_TWO
            "BOTH" -> HumanReadable.POS_THREE
            else -> HumanReadable.HIDE
        }
    }

    private fun getSymbology(type: String?): Symbology {
        return when (type?.uppercase()) {
            "UPCA" -> Symbology.UPCA
            "UPCE" -> Symbology.UPCE
            "JAN13" -> Symbology.EAN13
            "JAN8" -> Symbology.EAN8
            "CODE39" -> Symbology.CODE39
            "ITF" -> Symbology.ITF
            "CODABAR" -> Symbology.CODABAR
            "CODE93" -> Symbology.CODE93
            "CODE128" -> Symbology.CODE128
            else -> Symbology.CODE128
        }
    }

    companion object {
        private const val TAG = "sunmi_printer_plus"
    }
}
