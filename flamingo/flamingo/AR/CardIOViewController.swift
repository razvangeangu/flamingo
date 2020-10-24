//
//  CardNumberIdentifier.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import Foundation
import AVFoundation

class CardIOViewController: UIViewController, CardIOViewDelegate {
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.canReadCardWithCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CardIOUtilities.preloadCardIO()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        prepareCameraBackground()
        
        let cardIOView = CardIOView(frame: self.view.frame)
        cardIOView.delegate = self
        self.view.addSubview(cardIOView)
    }
    
    func prepareCameraBackground() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        guard let input = try? AVCaptureDeviceInput(device: backCamera) else {
            print("Error Unable to initialize back camera")
            return
        }
        
        stillImageOutput = AVCapturePhotoOutput()
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
            captureSession.addInput(input)
            captureSession.addOutput(stillImageOutput)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            self.view.layer.addSublayer(videoPreviewLayer)
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            blurView.frame = self.view.bounds
            self.view.addSubview(blurView)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.view.bounds
            }
        }
    }
    
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        print(cardInfo.cardNumber ?? "")
    }
}

// Get the video buffer from ARView and identify the credit card number
