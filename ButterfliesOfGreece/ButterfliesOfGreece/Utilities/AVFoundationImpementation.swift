//
//  AVFoundationImpementation.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 30/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AVFoundationImplementation: NSObject{
	fileprivate lazy var captureSession: AVCaptureSession  = AVCaptureSession()
	fileprivate lazy var videoOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
	
	var rearCamera: AVCaptureDevice?
	var rearCameraInput: AVCaptureDeviceInput?
	
	var videoPreviewLayer: AVCaptureVideoPreviewLayer?
	let textLayer = CATextLayer()
	
	let owner:UIView
	let ownerSession:LiveSession
	var frameCount = 0
	
	init(owner:UIView, ownerSession:LiveSession){
		self.owner = owner
		self.ownerSession = ownerSession
	}
	
	func setupSession(){
		
		captureSession.beginConfiguration()
		
//		let camera = AVCaptureDevice.default(for: .video)
//		let input = try? AVCaptureDeviceInput(device: camera!)
//		captureSession?.addInput(input!)
		
		let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
		self.rearCamera = session.devices.first
		if let rearCamera = self.rearCamera {
			try? rearCamera.lockForConfiguration()
			rearCamera.focusMode = .autoFocus
			rearCamera.unlockForConfiguration()
		}

		if let rearCamera = self.rearCamera {

			// we try to create the input from the found camera
			self.rearCameraInput = try? AVCaptureDeviceInput(device: rearCamera)

			if let rearCameraInput = rearCameraInput{

				// always make sure the AVCaptureSession can accept the selected input
				if (captureSession.canAddInput(rearCameraInput)){

//					 add the input to the current session
					captureSession.addInput(rearCameraInput)
				}
			}
			
				// create the preview layer with the configuration you want
				self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
				self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
				self.videoPreviewLayer?.connection?.videoOrientation = .portrait
				
				// then add the layer to your current view
				owner.layer.insertSublayer(self.videoPreviewLayer!, at: 0)
				self.videoPreviewLayer?.frame = owner.frame
			
			self.videoOutput = AVCaptureVideoDataOutput()
			self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
			videoOutput.alwaysDiscardsLateVideoFrames = true
			videoOutput.videoSettings = [ String(kCVPixelBufferPixelFormatTypeKey) : kCMPixelFormat_32BGRA]
			// always make sure the AVCaptureSession can accept the selected output
			if captureSession.canAddOutput(self.videoOutput) {
				
				// add the output to the current session
				captureSession.addOutput(self.videoOutput)
				videoOutput.connection(with: .video)?.videoOrientation = .portrait
			}
		}
		captureSession.commitConfiguration()
	}
	
	func startSession(){
		captureSession.startRunning()
	}
	
	func stopSession(){
		captureSession.stopRunning()
	}
	
	func addText(){
		let shapeLayer = CAShapeLayer()
		shapeLayer.name = "rectLayer"
		shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: owner.frame.width*0.05, y: owner.frame.height*0.9, width: owner.frame.width*0.9, height: 40), cornerRadius: 10).cgPath
		shapeLayer.fillColor = Constants.Colors.recognition(darkMode: false).color.cgColor
		shapeLayer.opacity = 0.7
//		let roundedRect = CGRect(x: shapeLayer.path!.boundingBox.minX + 2, y: shapeLayer.path!.boundingBox.minY + 2, width: shapeLayer.path!.boundingBox.width - 4, height: shapeLayer.path!.boundingBox.height - 4)
//		let cornerRadius = 10;// roundedRect.Size.Height / 2.0f;
//		UIBezierPath path = UIBezierPath.FromRect(_shapeLayer.Path.BoundingBox);
//		UIBezierPath croppedPath = UIBezierPath.FromRoundedRect(roundedRect, cornerRadius);
//		path.AppendPath(croppedPath);
//		path.UsesEvenOddFillRule = true;
//		var mask = new CAShapeLayer();
//		mask.Path = path.CGPath;
//		mask.FillRule = CAShapeLayer.FillRuleEvenOdd;
//		_shapeLayer.Mask = mask;
		if owner.layer.sublayers?.first(where: {layer in layer.name == "rectLayer"})==nil{
			owner.layer.insertSublayer(shapeLayer, above: videoPreviewLayer!)
		}
		
		let borderLayer = CAShapeLayer()
		borderLayer.name = "borderLayer"
		borderLayer.path = shapeLayer.path
		borderLayer.lineWidth = 2
		borderLayer.strokeColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		borderLayer.fillColor = UIColor.clear.cgColor
		borderLayer.frame = owner.bounds
		if owner.layer.sublayers?.first(where: {layer in layer.name == "borderLayer"})==nil{
			owner.layer.insertSublayer(borderLayer, above: shapeLayer)
		}

		textLayer.string = "Capturing video!"
		textLayer.name = "textLayer"
		textLayer.foregroundColor = Constants.Colors.recognition(darkMode: true).color.cgColor
		textLayer.opacity = 0.8;
		textLayer.frame =  CGRect(x: shapeLayer.path!.boundingBox.minX + 2, y: shapeLayer.path!.boundingBox.minY + 20 - Constants.Fonts.fontMenuSize/2 + 1, width: shapeLayer.path!.boundingBox.width - 4, height: 40)
		textLayer.fontSize = Constants.Fonts.fontMenuSize
		textLayer.alignmentMode = .center
		textLayer.contentsScale = UIScreen.main.scale
		textLayer.font = UIFont(name: Constants.Fonts.appFont, size: Constants.Fonts.fontMenuSize)
		if owner.layer.sublayers?.first(where: {layer in layer.name == "textLayer"})==nil{
			owner.layer.insertSublayer(textLayer, above: borderLayer)
		}
		
	}
	
	func setText(text:String){
		textLayer.string = text
	}
}

extension AVFoundationImplementation: AVCaptureVideoDataOutputSampleBufferDelegate {
	
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		
		let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(sampleBuffer)
		
		guard let imagePixelBuffer = pixelBuffer else {
			return
		}
		
		guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return  }
		let ciImage = CIImage(cvPixelBuffer: imageBuffer)
		
		let context = CIContext()
		guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return  }
		
		let image = UIImage(cgImage: cgImage)
		
		// the final picture is here, we call the completion block
		frameCount += 1
		if frameCount == 25{
			frameCount = 0
			ownerSession.setImage(image: image, imagePixelBuffer: imagePixelBuffer)
		}
	}
	
}
