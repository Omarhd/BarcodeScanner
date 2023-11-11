//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    
    @Published var scannedCode: String = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not Scanned" : scannedCode
    }

    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }

}
