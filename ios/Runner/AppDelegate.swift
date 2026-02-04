import UIKit
import Flutter
import UserNotifications
import OpenpayKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    private let CHANNEL = "smart.lunch/openpay"
    var openpay: Openpay!
    var openpaySessionID: String = ""
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        
        // Configuración del MethodChannel para Openpay
        if let flutterViewController = window?.rootViewController as? FlutterViewController {
            let methodChannel = FlutterMethodChannel(
                name: CHANNEL,
                binaryMessenger: flutterViewController.binaryMessenger
            )
            
            methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
                switch call.method {
                case "initialize":
                    if let arguments = call.arguments as? [String: Any],
                       let merchantId = arguments["merchantId"] as? String,
                       let publicApiKey = arguments["publicApiKey"] as? String,
                       let isProductionMode = arguments["isProductionMode"] as? Bool {
                        
                        self?.initializeOpenPay(
                            merchantId: merchantId,
                            apiKey: publicApiKey,
                            isProductionMode: isProductionMode
                        )
                        result("200")
                    }
                    
                case "getDeviceSessionId":
                    let data = self?.getDeviceSessionId()
                    result(data)
                    
                default:
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        
        // Solicitar permisos de notificaciones (solo iOS)
        registerForPushNotifications()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - Push Notifications
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                print("Permission granted: \(granted)")
            }
    }
    
    // MARK: - Openpay Methods
    
    private func initializeOpenPay(merchantId: String, apiKey: String, isProductionMode: Bool) {
        openpay = Openpay(
            withMerchantId: merchantId,
            andApiKey: apiKey,
            isProductionMode: isProductionMode,
            isDebug: !isProductionMode,
            countryCode: "MX"
        )
    }
    
    private func getDeviceSessionId() -> String {
        openpay.createDeviceSessionId(successFunction: successSessionID, failureFunction: failSessionID)
        return openpaySessionID
    }
    
    private func successSessionID(sessionID: String) {
        openpaySessionID = sessionID
    }
    
    private func failSessionID(error: NSError) {
        openpaySessionID = "Error"
    }
}
