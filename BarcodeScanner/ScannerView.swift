//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
   
    @Binding var scannedCode: String
    
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
            print(error.rawValue)
        }
        
        
    }
}

#Preview {
    ScannerView(scannedCode: .constant("22223322"))
}
