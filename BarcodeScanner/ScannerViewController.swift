//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by Omar Abdulrahman on 11/11/2023.
//

import UIKit
import AVFoundation

enum CameraError: String, Error, CaseIterable {
    case permissionDenied = "Camera permission denied."
    case cameraUnavailable = "Camera is not available."
    case unableToCaptureImage = "Unable to capture image."
    case unableToRecordVideo = "Unable to record video."
    case autofocusFailure = "Autofocus failed."
    case flashUnavailable = "Flash is not available."
    case invalidCameraInput = "Invalid camera input."
    case focusOutOfRange = "Focus is out of range."
    case captureSessionError = "Capture session error."

}

protocol ScannerViewControllerDelegate: AnyObject {
    func didFindBarCode(barcode: String)
    func didSurfacedError(error: CameraError)
}

final class ScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerViewControllerDelegate?
    
    init(scannerDelegate: ScannerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = self.previewLayer else {
            scannerDelegate?.didSurfacedError(error: .permissionDenied)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    func setupCaptureSession() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            self.scannerDelegate?.didSurfacedError(error: .cameraUnavailable)
            return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            self.scannerDelegate?.didSurfacedError(error: .invalidCameraInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.codabar, .ean8, .ean13, .face]
        } else {
            self.scannerDelegate?.didSurfacedError(error: .unableToCaptureImage)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        startScanning()
    }
    
    fileprivate func startScanning() {
        captureSession.startRunning()
    }

    fileprivate func stopScanning() {
        captureSession.stopRunning()
    }

}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else { return }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else { return }
        
        guard let barcode = machineReadableObject.stringValue else { return }
        
        self.scannerDelegate?.didFindBarCode(barcode: barcode)
        
        stopScanning()
    }
}
