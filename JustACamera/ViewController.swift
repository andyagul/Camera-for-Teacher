//
//  ViewController.swift
//  JustACamera
//
//  Created by Chen Weiru on 2018/6/1.
//  Copyright © 2018 ChenWeiru. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    var camera:Camera!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera = Camera()
        camera.previewView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        camera.setupCameraLayerAndFrame()
        view.addSubview(camera.previewView)
        setVideoOrientation()
        camera.isRunning = true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if camera.isRunning == false{
            camera.isRunning = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        camera.isRunning = false
    }
    

    override func viewWillLayoutSubviews() {
        setVideoOrientation()
    }
    

    func setVideoOrientation() {
        if let connection = camera.previewLayer?.connection {
            if connection.isVideoOrientationSupported {
                connection.videoOrientation = videoOrientation()
                camera.previewLayer?.frame = view.bounds
                
            }
        }
    }
  
    func videoOrientation() -> AVCaptureVideoOrientation {
        
        var videoOrientation:AVCaptureVideoOrientation!
        
        let orientation:UIDeviceOrientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait:
            videoOrientation = .portrait
        case .landscapeRight:
            videoOrientation = .landscapeLeft
        case .landscapeLeft:
            videoOrientation = .landscapeRight
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        default:
            videoOrientation = .portrait
        }
        
        return videoOrientation
        
    }
    


}

