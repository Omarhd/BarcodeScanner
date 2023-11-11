//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    static let permissionDenied = AlertItem(title: "Opps", message: "Camera permission denied.", dismissButton: .default(Text("OK")))
    static let cameraUnavailable = AlertItem(title: "Opps", message: "Camera is not available.", dismissButton: .default(Text("OK")))
    static let unableToCaptureImage = AlertItem(title: "Opps", message: "Unable to capture image.", dismissButton: .default(Text("OK")))
    static let unableToRecordVideo = AlertItem(title: "Opps", message: "Unable to record video.", dismissButton: .default(Text("OK")))
    static let autofocusFailure = AlertItem(title: "Opps", message: "Autofocus failed.", dismissButton: .default(Text("OK")))
    static let flashUnavailable = AlertItem(title: "Opps", message: "Flash is not available.", dismissButton: .default(Text("OK")))
    static let invalidCameraInput = AlertItem(title: "Opps", message: "Invalid camera input.", dismissButton: .default(Text("OK")))
    static let focusOutOfRange = AlertItem(title: "Opps", message: "Focus is out of range.", dismissButton: .default(Text("OK")))
    static let captureSessionError = AlertItem(title: "Opps", message: "Capture session error.", dismissButton: .default(Text("OK")))

}
