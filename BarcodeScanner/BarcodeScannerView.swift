//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @State private var scannedCode: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $scannedCode)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 80)
                
                Label("Scanned Text:", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding()
                
                Text(scannedCode.isEmpty ? "Not Scanned" : scannedCode)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green)
                    .padding()
            }
            .navigationTitle("Home Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
