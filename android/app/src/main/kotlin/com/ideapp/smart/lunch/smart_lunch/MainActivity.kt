package com.ideapp.smart.lunch.smart_lunch

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import mx.openpay.android.Openpay

class MainActivity: FlutterActivity() {

    private val _channel = "smart.lunch/openpay"
    private var _openPay: Openpay? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, _channel).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "initialize" -> {
                    val merchantId: String = call.arguments<Map<String, Any>>()?.get("merchantId") as String
                    val publicApiKey: String = call.arguments<Map<String, Any>>()?.get("publicApiKey") as String
                    val isProductionMode: Boolean = call.arguments<Map<String, Any>>()?.get("isProductionMode") as Boolean

                    initializeOpenPay(merchantId, publicApiKey, isProductionMode)
                    result.success(200)
                }
                "getDeviceSessionId" -> {
                    result.success(getDeviceSessionId())
                }
                else -> {

                }
            }
        }
    }

    private fun initializeOpenPay(merchantId: String, apiKey: String, isProductionMode: Boolean) {
        _openPay = Openpay(merchantId, apiKey, isProductionMode)
    }

    private fun getDeviceSessionId(): String {
        return _openPay?.deviceCollectorDefaultImpl?.setup(this.activity) ?: ""
    }

}
