//
//  PdfManager.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 16/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

struct PdfManager{
	
	init(){
	}
	
	func createFlyer(photos:[ButterflyPhoto], pdfArrange:PdfArrange) -> Data {
		// 1
		let pdfMetaData = [
			kCGPDFContextCreator: "Flyer Builder",
			kCGPDFContextAuthor: "raywenderlich.com"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		
		// 2
		let pageWidth = 8.5 * 72.0
		let pageHeight = 11 * 72.0
		let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
		
		// 3
		let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
		// 4
		let data = renderer.pdfData { (context) in
			// 5
			// 6
			let attributes = [
				NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
			]
			let text = "I'm a PDF!"
//			text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
			
			for photo in photos{
				let image = UIImage(named: "ThumbnailsBig/\(photo.source)", in: nil, compatibleWith: nil)
				if let image = image{
					context.beginPage()
					_ = addImage(image: image, pageRect: pageRect, imageTop: 8)
				}
			}
		}
		return data
	}
	
	func addImage(image:UIImage ,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
		// 1
		let maxHeight = pageRect.height * 0.9
		let maxWidth = pageRect.width * 0.9
		// 2
		let aspectWidth = maxWidth / image.size.width
		let aspectHeight = maxHeight / image.size.height
		let aspectRatio = min(aspectWidth, aspectHeight)
		// 3
		let scaledWidth = image.size.width * aspectRatio
		let scaledHeight = image.size.height * aspectRatio
		// 4
		let imageX = (pageRect.width - scaledWidth) / 2.0
		let imageRect = CGRect(x: imageX, y: imageTop,
							   width: scaledWidth, height: scaledHeight)
		// 5
		image.draw(in: imageRect)
		return imageRect.origin.y + imageRect.size.height
	}
}
