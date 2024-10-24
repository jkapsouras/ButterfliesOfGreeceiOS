//
//  CVPixelBufferExtensions.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 28/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import Accelerate

extension CVPixelBuffer {
	
	/**
	Returns thumbnail by cropping pixel buffer to biggest square and scaling the cropped image to
	model dimensions.
	*/
	func centerThumbnail(ofSize size: CGSize ) -> CVPixelBuffer? {
		
		let imageWidth = CVPixelBufferGetWidth(self)
		let imageHeight = CVPixelBufferGetHeight(self)
		let pixelBufferType = CVPixelBufferGetPixelFormatType(self)
		
		assert(pixelBufferType == kCVPixelFormatType_32BGRA)
		
		let inputImageRowBytes = CVPixelBufferGetBytesPerRow(self)
		let imageChannels = 4
		
		let thumbnailSize = min(imageWidth, imageHeight)
		CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
		
		var originX = 0
		var originY = 0
		
		if imageWidth > imageHeight {
			originX = (imageWidth - imageHeight) / 2
		}
		else {
			originY = (imageHeight - imageWidth) / 2
		}
		
		// Finds the biggest square in the pixel buffer and advances rows based on it.
		guard let inputBaseAddress = CVPixelBufferGetBaseAddress(self)?.advanced(
				by: originY * inputImageRowBytes + originX * imageChannels) else {
			return nil
		}
		
		// Gets vImage Buffer from input image
		var inputVImageBuffer = vImage_Buffer(
			data: inputBaseAddress, height: UInt(thumbnailSize), width: UInt(thumbnailSize),
			rowBytes: inputImageRowBytes)
		
		let thumbnailRowBytes = Int(size.width) * imageChannels
		guard  let thumbnailBytes = malloc(Int(size.height) * thumbnailRowBytes) else {
			return nil
		}
		
		// Allocates a vImage buffer for thumbnail image.
		var thumbnailVImageBuffer = vImage_Buffer(data: thumbnailBytes, height: UInt(size.height), width: UInt(size.width), rowBytes: thumbnailRowBytes)
		
		// Performs the scale operation on input image buffer and stores it in thumbnail image buffer.
		let scaleError = vImageScale_ARGB8888(&inputVImageBuffer, &thumbnailVImageBuffer, nil, vImage_Flags(0))
		
		CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
		
		guard scaleError == kvImageNoError else {
			return nil
		}
		
		let releaseCallBack: CVPixelBufferReleaseBytesCallback = {mutablePointer, pointer in
			
			if let pointer = pointer {
				free(UnsafeMutableRawPointer(mutating: pointer))
			}
		}
		
		var thumbnailPixelBuffer: CVPixelBuffer?
		
		// Converts the thumbnail vImage buffer to CVPixelBuffer
		let conversionStatus = CVPixelBufferCreateWithBytes(
			nil, Int(size.width), Int(size.height), pixelBufferType, thumbnailBytes,
			thumbnailRowBytes, releaseCallBack, nil, nil, &thumbnailPixelBuffer)
		
		guard conversionStatus == kCVReturnSuccess else {
			
			free(thumbnailBytes)
			return nil
		}
		
		return thumbnailPixelBuffer
	}
	
	static func buffer(from image: UIImage) -> CVPixelBuffer? {
		let attrs = [
			kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
			kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
		] as CFDictionary
		
		var pixelBuffer: CVPixelBuffer?
		let status = CVPixelBufferCreate(kCFAllocatorDefault,
										 Int(image.size.width),
										 Int(image.size.height),
										 kCVPixelFormatType_32BGRA,
										 attrs,
										 &pixelBuffer)
		
		guard let buffer = pixelBuffer, status == kCVReturnSuccess else {
			return nil
		}
		
		CVPixelBufferLockBaseAddress(buffer, [])
		defer { CVPixelBufferUnlockBaseAddress(buffer, []) }
		let pixelData = CVPixelBufferGetBaseAddress(buffer)
		
		let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
		guard let context = CGContext(data: pixelData,
									  width: Int(image.size.width),
									  height: Int(image.size.height),
									  bitsPerComponent: 8,
									  bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
									  space: rgbColorSpace,
									  bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
			return nil
		}
		
		context.translateBy(x: 0, y: image.size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		
		UIGraphicsPushContext(context)
		image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
		UIGraphicsPopContext()
		
		return pixelBuffer
	}
	
	/// Returns thumbnail by cropping pixel buffer to biggest square and scaling the cropped image
	/// to model dimensions.
	func resized(to size: CGSize ) -> CVPixelBuffer? {
		
		let imageWidth = CVPixelBufferGetWidth(self)
		let imageHeight = CVPixelBufferGetHeight(self)
		
		let pixelBufferType = CVPixelBufferGetPixelFormatType(self)
		
		assert(pixelBufferType == kCVPixelFormatType_32BGRA ||
				pixelBufferType == kCVPixelFormatType_32ARGB)
		
		let inputImageRowBytes = CVPixelBufferGetBytesPerRow(self)
		let imageChannels = 4
		
		CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
		
		// Finds the biggest square in the pixel buffer and advances rows based on it.
		guard let inputBaseAddress = CVPixelBufferGetBaseAddress(self) else {
			return nil
		}
		
		// Gets vImage Buffer from input image
		var inputVImageBuffer = vImage_Buffer(data: inputBaseAddress, height: UInt(imageHeight), width: UInt(imageWidth), rowBytes: inputImageRowBytes)
		
		let scaledImageRowBytes = Int(size.width) * imageChannels
		guard  let scaledImageBytes = malloc(Int(size.height) * scaledImageRowBytes) else {
			return nil
		}
		
		// Allocates a vImage buffer for scaled image.
		var scaledVImageBuffer = vImage_Buffer(data: scaledImageBytes, height: UInt(size.height), width: UInt(size.width), rowBytes: scaledImageRowBytes)
		
		// Performs the scale operation on input image buffer and stores it in scaled image buffer.
		let scaleError = vImageScale_ARGB8888(&inputVImageBuffer, &scaledVImageBuffer, nil, vImage_Flags(0))
		
		CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
		
		guard scaleError == kvImageNoError else {
			return nil
		}
		
		let releaseCallBack: CVPixelBufferReleaseBytesCallback = {mutablePointer, pointer in
			
			if let pointer = pointer {
				free(UnsafeMutableRawPointer(mutating: pointer))
			}
		}
		
		var scaledPixelBuffer: CVPixelBuffer?
		
		// Converts the scaled vImage buffer to CVPixelBuffer
		let conversionStatus = CVPixelBufferCreateWithBytes(nil, Int(size.width), Int(size.height), pixelBufferType, scaledImageBytes, scaledImageRowBytes, releaseCallBack, nil, nil, &scaledPixelBuffer)
		
		guard conversionStatus == kCVReturnSuccess else {
			
			free(scaledImageBytes)
			return nil
		}
		
		return scaledPixelBuffer
	}
}
