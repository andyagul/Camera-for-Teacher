//
//  Camera.swift
//  JustACamera
//
//  Created by Chen Weiru on 2018/6/2.
//  Copyright © 2018 ChenWeiru. All rights reserved.
//

import UIKit
import AVFoundation

class Camera: NSObject {
  
    private let captureSession = AVCaptureSession()
    private var videoCaptureDevice:AVCaptureDevice?
    private var photoOutput = AVCapturePhotoOutput()

    var previewLayer:AVCaptureVideoPreviewLayer?
    var previewView = UIView()
    var isRunning:Bool{
        get{
            return captureSession.isRunning
        }
        set{
            if newValue == true{
                captureSession.startRunning()
            }else{
                captureSession.stopRunning()
            }
        }
    }
    
    
    
    override init() {
        super.init()
        captureSession.sessionPreset = .high
        let discovery = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified) as AVCaptureDevice.DiscoverySession
        
        for device in discovery.devices as [AVCaptureDevice] {
            if device.hasMediaType(AVMediaType.video) {
                if device.position == AVCaptureDevice.Position.back {
                    videoCaptureDevice = device
                }
            }
        }
        
        if videoCaptureDevice != nil {
            do {
                try self.captureSession.addInput(AVCaptureDeviceInput(device: videoCaptureDevice!))
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                captureSession.addOutput(photoOutput)
            } catch {
                print(error)
            }
        }
        
    }
    
    func setupCameraLayerAndFrame(){
        previewView.layer.addSublayer(previewLayer!)
        previewLayer!.frame = previewView.frame
        
    }
    
    
}
