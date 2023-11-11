//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject private var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 80)
                
                Label("Scanned Text:", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding()
                
                Text(viewModel.statusText)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(viewModel.statusTextColor)
                    .padding()
            }
            .navigationTitle("Home Scanner")
            .alert(item: $viewModel.alertItem) { alert in
                Alert(title: Text(alert.title),
                      message: Text(alert.message),
                      dismissButton: alert.dismissButton)
            }
        }
    }
}

#Preview {
    BarcodeScannerView()
}
