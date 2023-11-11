//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
   
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController.init(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    

    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        
        let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        
        func didFindBarCode(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurfacedError(error: CameraError) {
            switch error {
            case .permissionDenied:
                scannerView.alertItem = AlertContext.permissionDenied
           
            case .cameraUnavailable:
                scannerView.alertItem = AlertContext.cameraUnavailable

            case .unableToCaptureImage:
                scannerView.alertItem = AlertContext.unableToCaptureImage

            case .unableToRecordVideo:
                scannerView.alertItem = AlertContext.unableToRecordVideo

            case .autofocusFailure:
                scannerView.alertItem = AlertContext.autofocusFailure

            case .flashUnavailable:
                scannerView.alertItem = AlertContext.flashUnavailable

            case .invalidCameraInput:
                scannerView.alertItem = AlertContext.invalidCameraInput

            case .focusOutOfRange:
                scannerView.alertItem = AlertContext.focusOutOfRange

            case .captureSessionError:
                scannerView.alertItem = AlertContext.captureSessionError

            }
        }
    }
}

