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

enum Key: String {
	case paperRect
	case printableRect
}

struct PdfManager{
	let pageWidth = 8.5 * 72.0
	let pageHeight = 11 * 72.0
	
	init(){
	}
	
	func createRecordsTable(html:String, printRenderer:UIPrintPageRenderer) -> Data{
		let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
		// adjust printableRect as you need, add padding or whatever
		printRenderer.setValue(NSValue(cgRect: pageRect), forKey: "paperRect")
		
		// Set the horizontal and vertical insets (that's optional).
		printRenderer.setValue(NSValue(cgRect: pageRect), forKey: "printableRect")
		return printRenderer.exportHTMLContentToPDF(HTMLContent: html)
	}
	
	func createPhotosBook(photos:[ButterflyPhoto], pdfArrange:PdfArrange) -> Data {
		// 1
		let pdfMetaData = [
			kCGPDFContextCreator: "Selected photos of Butterflies of Greece",
			kCGPDFContextAuthor: "Photos: Lazaros Pamperis, Code: Ioannis Kapsouras"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		
		let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
		
		// 3
		let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
		// 4
		
		switch pdfArrange{
		case .onePerPage:
			let data = renderer.pdfData { (context) in
				// 5
				// 6
				for photo in photos{
					let image = UIImage(named: "ThumbnailsBig/\(photo.source)", in: nil, compatibleWith: nil)
					if let image = image{
						context.beginPage()
						_ = addOneImageWithText(context: context, text: "\(photo.author)\n\(photo.specieName ?? "")", image: image, pageRect: pageRect, imageTop: 0)
					}
				}
				
			}
			return data
		case .twoPerPage:
			let data = renderer.pdfData { (context) in
				// 5
				// 6
				for i in stride(from: 0, to: photos.count, by: 2){
					if i >= photos.count{
						break
					}
					if i+1 >= photos.count{
						break
					}
					let image1 = UIImage(named: "ThumbnailsBig/\(photos[i].source)", in: nil, compatibleWith: nil)
					let image2 = UIImage(named: "ThumbnailsBig/\(photos[i+1].source)", in: nil, compatibleWith: nil)
					if let image1 = image1,
					   let image2 = image2{
						context.beginPage()
						_ = addTwoImagesWithText(context: context,
												 text1: "\(photos[i].author)\n\(photos[i].specieName ?? "")", image1: image1,
												 text2: "\(photos[i+1].author)\n\(photos[i+1].specieName ?? "")", image2: image2,
												 pageRect: pageRect, imageTop: 0)
					}
				}
				
			}
			return data
		case .fourPerPage:
			let data = renderer.pdfData { (context) in
				// 5
				// 6
				for i in stride(from: 0, to: photos.count, by: 4){
					if i >= photos.count{
						break
					}
					if i+1 >= photos.count{
						break
					}
					if i+2 >= photos.count{
						break
					}
					if i+3 >= photos.count{
						break
					}
					let image1 = UIImage(named: "ThumbnailsBig/\(photos[i].source)", in: nil, compatibleWith: nil)
					let image2 = UIImage(named: "ThumbnailsBig/\(photos[i+1].source)", in: nil, compatibleWith: nil)
					let image3 = UIImage(named: "ThumbnailsBig/\(photos[i+2].source)", in: nil, compatibleWith: nil)
					let image4 = UIImage(named: "ThumbnailsBig/\(photos[i+3].source)", in: nil, compatibleWith: nil)
					if let image1 = image1,
					   let image2 = image2,
					   let image3 = image3,
					   let image4 = image4{
						context.beginPage()
						_ = addFourImagesWithText(context: context, text1: "\(photos[i].author)\n\(photos[i].specieName ?? "")", image1: image1, text2:  "\(photos[i+1].author)\n\(photos[i+1].specieName ?? "")", image2: image2, text3: "\(photos[i+2].author)\n\(photos[i+2].specieName ?? "")", image3: image3, text4:  "\(photos[i+3].author)\n\(photos[i+3].specieName ?? "")", image4: image4, pageRect: pageRect, imageTop: 0)
					}
				}
				
			}
			return data
		case .sixPerPage:
			let data = renderer.pdfData { (context) in
				// 5
				// 6
				for i in stride(from: 0, to: photos.count, by: 6){
					if i >= photos.count{
						break
					}
					if i+1 >= photos.count{
						break
					}
					if i+2 >= photos.count{
						break
					}
					if i+3 >= photos.count{
						break
					}
					if i+4 >= photos.count{
						break
					}
					if i+5 >= photos.count{
						break
					}
					let image1 = UIImage(named: "ThumbnailsBig/\(photos[i].source)", in: nil, compatibleWith: nil)
					let image2 = UIImage(named: "ThumbnailsBig/\(photos[i+1].source)", in: nil, compatibleWith: nil)
					let image3 = UIImage(named: "ThumbnailsBig/\(photos[i+2].source)", in: nil, compatibleWith: nil)
					let image4 = UIImage(named: "ThumbnailsBig/\(photos[i+3].source)", in: nil, compatibleWith: nil)
					let image5 = UIImage(named: "ThumbnailsBig/\(photos[i+4].source)", in: nil, compatibleWith: nil)
					let image6 = UIImage(named: "ThumbnailsBig/\(photos[i+5].source)", in: nil, compatibleWith: nil)
					if let image1 = image1,
					   let image2 = image2,
					   let image3 = image3,
					   let image4 = image4,
					   let image5 = image5,
					   let image6 = image6{
						context.beginPage()
						_ = addSixImagesWithText(context: context,
												 text1: "\(photos[i].author)\n\(photos[i].specieName ?? "")", image1: image1,
												 text2: "\(photos[i+1].author)\n\(photos[i+1].specieName ?? "")", image2: image2,
												 text3: "\(photos[i+2].author)\n\(photos[i+2].specieName ?? "")", image3: image3,
												 text4: "\(photos[i+3].author)\n\(photos[i+3].specieName ?? "")", image4: image4,
												 text5: "\(photos[i+4].author)\n\(photos[i+4].specieName ?? "")", image5: image5,
												 text6: "\(photos[i+5].author)\n\(photos[i+5].specieName ?? "")", image6: image6,
												 pageRect: pageRect, imageTop: 0)
					}
				}
				
			}
			return data
		}
	}
	
	func addOneImageWithText(context:UIGraphicsPDFRendererContext, text: String, image:UIImage ,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
		let textFont = UIFont(name: Constants.Fonts.appFont, size: Constants.Fonts.fontHeaderSize) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontHeaderSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .natural
		paragraphStyle.lineBreakMode = .byWordWrapping
		paragraphStyle.minimumLineHeight = 20
		// 2
		let textAttributes = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: textFont,
			NSAttributedString.Key.backgroundColor: Constants.Colors.field(darkMode: false).color,
			NSAttributedString.Key.foregroundColor: Constants.Colors.field(darkMode: true).color
		]
		let attributedText = NSAttributedString(
			string: text,
			attributes: textAttributes
		)
		let size = attributedText.size()
		
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
		let textTop = imageRect.origin.y + imageRect.size.height + 4
		
		let textRect = CGRect(
			x: imageRect.origin.x + 4,
			y: textTop,
			width: scaledWidth - 4,
			height: size.height
		)
		
		let drawContext = context.cgContext
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: imageX, y: textTop - 4,width: imageRect.width,height: size.height+8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText.draw(in: textRect)
		
		return textRect.origin.y + textRect.height
	}
	
	func addTwoImagesWithText(context:UIGraphicsPDFRendererContext, text1: String, image1:UIImage, text2:String, image2:UIImage ,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
		let textFont = UIFont(name: Constants.Fonts.appFont, size: Constants.Fonts.fontHeaderSize) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontHeaderSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .natural
		paragraphStyle.lineBreakMode = .byWordWrapping
		paragraphStyle.minimumLineHeight = 20
		// 2
		let textAttributes = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: textFont,
			NSAttributedString.Key.backgroundColor: Constants.Colors.field(darkMode: false).color,
			NSAttributedString.Key.foregroundColor: Constants.Colors.field(darkMode: true).color
		]
		let attributedText1 = NSAttributedString(
			string: text1,
			attributes: textAttributes
		)
		let attributedText2 = NSAttributedString(
			string: text2,
			attributes: textAttributes
		)
		let size1 = attributedText1.size()
		let size2 = attributedText2.size()
		
		// 1
		let maxHeight = ((pageRect.height*0.9)-(2*size1.height))/2
		let maxWidth = pageRect.width * 0.9
		// 2
		let aspectWidth1 = maxWidth / image1.size.width
		let aspectHeight1 = maxHeight / image1.size.height
		let aspectRatio1 = min(aspectWidth1, aspectHeight1)
		
		let aspectWidth2 = maxWidth / image2.size.width
		let aspectHeight2 = maxHeight / image2.size.height
		let aspectRatio2 = min(aspectWidth2, aspectHeight2)
		// 3
		let scaledWidth1 = image1.size.width * aspectRatio1
		let scaledHeight1 = image1.size.height * aspectRatio1
		let scaledWidth2 = image2.size.width * aspectRatio2
		let scaledHeight2 = image2.size.height * aspectRatio2
		// 4
		let image1X = (pageRect.width - scaledWidth1) / 2.0
		let image2X = (pageRect.width - scaledWidth2) / 2.0
		let imageRect1 = CGRect(x: image1X, y: imageTop,
								width: scaledWidth1, height: scaledHeight1)
		// 5
		image1.draw(in: imageRect1)
		let textTop1 = imageRect1.origin.y + imageRect1.size.height + 4
		
		let textRect1 = CGRect(
			x: imageRect1.origin.x + 4,
			y: textTop1,
			width: scaledWidth1 - 4,
			height: size1.height
		)
		
		let drawContext = context.cgContext
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image1X, y: textTop1 - 4,width: imageRect1.width,height: size1.height+8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText1.draw(in: textRect1)
		
		let imageRect2 = CGRect(x: image2X, y: pageRect.height / 2,
								width: scaledWidth2, height: scaledHeight2)
		image2.draw(in: imageRect2)
		
		let textTop2 = (pageRect.height / 2) + imageRect2.height + 4
		
		let textRect2 = CGRect(
			x: imageRect2.origin.x + 4,
			y: textTop2,
			width: scaledWidth2 - 4,
			height: size2.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image2X, y: textTop2 - 4, width: imageRect2.width,height: size2.height+8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText1.draw(in: textRect2)
		
		return textRect1.origin.y + textRect1.height
	}
	
	func addFourImagesWithText(context:UIGraphicsPDFRendererContext, text1: String, image1:UIImage, text2:String, image2:UIImage ,text3: String, image3:UIImage, text4:String, image4:UIImage ,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
		let textFont = UIFont(name: Constants.Fonts.appFont, size: Constants.Fonts.fontHeaderSize) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontHeaderSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .natural
		paragraphStyle.lineBreakMode = .byWordWrapping
		paragraphStyle.minimumLineHeight = 20
		// 2
		let textAttributes = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: textFont,
			NSAttributedString.Key.backgroundColor: Constants.Colors.field(darkMode: false).color,
			NSAttributedString.Key.foregroundColor: Constants.Colors.field(darkMode: true).color
		]
		let attributedText1 = NSAttributedString(
			string: text1,
			attributes: textAttributes
		)
		let attributedText2 = NSAttributedString(
			string: text2,
			attributes: textAttributes
		)
		let attributedText3 = NSAttributedString(
			string: text3,
			attributes: textAttributes
		)
		let attributedText4 = NSAttributedString(
			string: text4,
			attributes: textAttributes
		)
		let size1 = attributedText1.size()
		let size2 = attributedText2.size()
		let size3 = attributedText3.size()
		let size4 = attributedText4.size()
		
		// 1
		let maxHeight = ((pageRect.height)-(2*size1.height))/2
		let maxWidth = (pageRect.width)/2
		// 2
		let aspectWidth1 = maxWidth / image1.size.width
		let aspectHeight1 = maxHeight / image1.size.height
		let aspectRatio1 = min(aspectWidth1, aspectHeight1)
		
		let aspectWidth2 = maxWidth / image2.size.width
		let aspectHeight2 = maxHeight / image2.size.height
		let aspectRatio2 = min(aspectWidth2, aspectHeight2)
		
		let aspectWidth3 = maxWidth / image3.size.width
		let aspectHeight3 = maxHeight / image3.size.height
		let aspectRatio3 = min(aspectWidth3, aspectHeight3)
		
		let aspectWidth4 = maxWidth / image4.size.width
		let aspectHeight4 = maxHeight / image4.size.height
		let aspectRatio4 = min(aspectWidth4, aspectHeight4)
		// 3
		let scaledWidth1 = image1.size.width * aspectRatio1
		let scaledHeight1 = image1.size.height * aspectRatio1
		let scaledWidth2 = image2.size.width * aspectRatio2
		let scaledHeight2 = image2.size.height * aspectRatio2
		let scaledWidth3 = image3.size.width * aspectRatio3
		let scaledHeight3 = image3.size.height * aspectRatio3
		let scaledWidth4 = image4.size.width * aspectRatio4
		let scaledHeight4 = image4.size.height * aspectRatio4
		// 4
		let image1X = CGFloat(0)
		let imageRect1 = CGRect(x: image1X, y: imageTop,
								width: scaledWidth1, height: scaledHeight1)
		// 5
		image1.draw(in: imageRect1)
		let textTop1 = imageRect1.origin.y + imageRect1.size.height + 4
		
		let textRect1 = CGRect(
			x: imageRect1.origin.x + 4,
			y: textTop1,
			width: scaledWidth1 - 4,
			height: size1.height
		)
		
		let drawContext = context.cgContext
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image1X, y: textTop1 - 4,width: imageRect1.width,height: size1.height + 12))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText1.draw(in: textRect1)
		
		let image2X = imageRect1.origin.x + imageRect1.width
		let imageRect2 = CGRect(x: image2X, y: imageRect1.origin.y,
								width: scaledWidth2, height: scaledHeight2)
		image2.draw(in: imageRect2)
		
		let textTop2 = imageRect2.origin.y + imageRect2.size.height + 4
		
		let textRect2 = CGRect(
			x: imageRect2.origin.x + 4,
			y: textTop2,
			width: scaledWidth2 - 4,
			height: size2.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image2X, y: textTop2 - 4,width: imageRect2.width,height: size2.height + 12))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText2.draw(in: textRect2)
		
		let image3X = imageRect1.origin.x// + imageRect1.width
		let imageRect3 = CGRect(x: image3X, y: (pageRect.height / 2),
								width: scaledWidth3, height: scaledHeight3)
		image3.draw(in: imageRect3)
		
		let textTop3 = imageRect3.origin.y +  imageRect3.height + 4
		
		let textRect3 = CGRect(
			x: imageRect3.origin.x + 4,
			y: textTop3,
			width: scaledWidth3 - 4,
			height: size3.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image3X, y: textTop3 - 4, width: imageRect3.width,height: size3.height+8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText3.draw(in: textRect3)
		
		let image4X = imageRect1.origin.x + imageRect1.width
		let imageRect4 = CGRect(x: image4X, y: (pageRect.height / 2),
								width: scaledWidth4, height: scaledHeight4)
		image4.draw(in: imageRect4)
		
		let textTop4 = (pageRect.height / 2) + imageRect4.height + 4
		
		let textRect4 = CGRect(
			x: imageRect4.origin.x + 4,
			y: textTop4,
			width: scaledWidth4 - 4,
			height: size4.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image4X, y: textTop4 - 4,width: imageRect4.width,height: size4.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText4.draw(in: textRect4)
		
		return textRect1.origin.y + textRect1.height
	}
	
	func addSixImagesWithText(context:UIGraphicsPDFRendererContext, text1: String, image1:UIImage,
							  text2:String, image2:UIImage,
							  text3: String, image3:UIImage,
							  text4:String, image4:UIImage,
							  text5: String, image5:UIImage,
							  text6:String, image6:UIImage,
							  pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
		let textFont = UIFont(name: Constants.Fonts.appFont, size: Constants.Fonts.fontHeaderSize) ?? UIFont.systemFont(ofSize: Constants.Fonts.fontHeaderSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .natural
		paragraphStyle.lineBreakMode = .byWordWrapping
		paragraphStyle.minimumLineHeight = 20
		// 2
		let textAttributes = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: textFont,
			NSAttributedString.Key.backgroundColor: Constants.Colors.field(darkMode: false).color,
			NSAttributedString.Key.foregroundColor: Constants.Colors.field(darkMode: true).color
		]
		let attributedText1 = NSAttributedString(
			string: text1,
			attributes: textAttributes
		)
		let attributedText2 = NSAttributedString(
			string: text2,
			attributes: textAttributes
		)
		let attributedText3 = NSAttributedString(
			string: text3,
			attributes: textAttributes
		)
		let attributedText4 = NSAttributedString(
			string: text4,
			attributes: textAttributes
		)
		let attributedText5 = NSAttributedString(
			string: text5,
			attributes: textAttributes
		)
		let attributedText6 = NSAttributedString(
			string: text6,
			attributes: textAttributes
		)
		let size1 = attributedText1.size()
		let size2 = attributedText2.size()
		let size3 = attributedText3.size()
		let size4 = attributedText4.size()
		let size5 = attributedText5.size()
		let size6 = attributedText6.size()
		
		// 1
		let maxHeight = ((pageRect.height)-(2*size1.height))/2
		let maxWidth = (pageRect.width)/3
		// 2
		let aspectWidth1 = maxWidth / image1.size.width
		let aspectHeight1 = maxHeight / image1.size.height
		let aspectRatio1 = min(aspectWidth1, aspectHeight1)
		
		let aspectWidth2 = maxWidth / image2.size.width
		let aspectHeight2 = maxHeight / image2.size.height
		let aspectRatio2 = min(aspectWidth2, aspectHeight2)
		
		let aspectWidth3 = maxWidth / image3.size.width
		let aspectHeight3 = maxHeight / image3.size.height
		let aspectRatio3 = min(aspectWidth3, aspectHeight3)
		
		let aspectWidth4 = maxWidth / image4.size.width
		let aspectHeight4 = maxHeight / image4.size.height
		let aspectRatio4 = min(aspectWidth4, aspectHeight4)
		
		let aspectWidth5 = maxWidth / image5.size.width
		let aspectHeight5 = maxHeight / image5.size.height
		let aspectRatio5 = min(aspectWidth5, aspectHeight5)
		
		let aspectWidth6 = maxWidth / image6.size.width
		let aspectHeight6 = maxHeight / image6.size.height
		let aspectRatio6 = min(aspectWidth6, aspectHeight6)
		// 3
		let scaledWidth1 = image1.size.width * aspectRatio1
		let scaledHeight1 = image1.size.height * aspectRatio1
		let scaledWidth2 = image2.size.width * aspectRatio2
		let scaledHeight2 = image2.size.height * aspectRatio2
		let scaledWidth3 = image3.size.width * aspectRatio3
		let scaledHeight3 = image3.size.height * aspectRatio3
		let scaledWidth4 = image4.size.width * aspectRatio4
		let scaledHeight4 = image4.size.height * aspectRatio4
		let scaledWidth5 = image5.size.width * aspectRatio5
		let scaledHeight5 = image5.size.height * aspectRatio5
		let scaledWidth6 = image6.size.width * aspectRatio6
		let scaledHeight6 = image6.size.height * aspectRatio6
		// 4
		let image1X = CGFloat(0)
		let imageRect1 = CGRect(x: image1X, y: imageTop,
								width: scaledWidth1, height: scaledHeight1)
		// 5
		image1.draw(in: imageRect1)
		let textTop1 = imageRect1.origin.y + imageRect1.size.height + 4
		
		let textRect1 = CGRect(
			x: imageRect1.origin.x + 4,
			y: textTop1,
			width: scaledWidth1 - 4,
			height: size1.height
		)
		
		let drawContext = context.cgContext
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image1X, y: textTop1 - 4,width: imageRect1.width,height: size1.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText1.draw(in: textRect1)
		
		let image2X = imageRect1.origin.x + imageRect1.width
		let imageRect2 = CGRect(x: image2X, y: imageRect1.origin.y	,
								width: scaledWidth2, height: scaledHeight2)
		image2.draw(in: imageRect2)
		
		let textTop2 = imageRect2.origin.y + imageRect2.height + 4
		
		let textRect2 = CGRect(
			x: imageRect2.origin.x + 4,
			y: textTop2,
			width: scaledWidth2 - 4,
			height: size2.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image2X, y: textTop2 - 4,width: imageRect2.width,height: size2.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText2.draw(in: textRect2)
		
		let image3X = imageRect1.origin.x + imageRect1.width + imageRect2.width
		let imageRect3 = CGRect(x: image3X, y: imageRect1.origin.y,
								width: scaledWidth3, height: scaledHeight3)
		image3.draw(in: imageRect3)
		
		let textTop3 = imageRect3.origin.y + imageRect3.height + 4
		
		let textRect3 = CGRect(
			x: imageRect3.origin.x + 4,
			y: textTop3,
			width: scaledWidth3 - 4,
			height: size3.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image3X, y: textTop3 - 4,width: imageRect3.width,height: size3.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText3.draw(in: textRect3)
		
		let image4X = imageRect1.origin.x
		let imageRect4 = CGRect(x: image4X, y: (pageRect.height / 2),
								width: scaledWidth4, height: scaledHeight4)
		image4.draw(in: imageRect4)
		
		let textTop4 =   (pageRect.height / 2) + imageRect4.height + 4
		
		let textRect4 = CGRect(
			x: imageRect4.origin.x + 4,
			y: textTop4,
			width: scaledWidth4 - 4,
			height: size4.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image4X, y: textTop4 - 4,width: imageRect4.width,height: size4.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText4.draw(in: textRect4)
		
		let image5X = imageRect2.origin.x
		let imageRect5 = CGRect(x: image5X, y: (pageRect.height/2),
								width: scaledWidth5, height: scaledHeight5)
		image5.draw(in: imageRect5)
		
		let textTop5 = (pageRect.height / 2) + imageRect5.height + 4
		
		let textRect5 = CGRect(
			x: imageRect5.origin.x + 4,
			y: textTop5,
			width: scaledWidth5 - 4,
			height: size5.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image5X, y: textTop5 - 4,width: imageRect5.width,height: size5.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText5.draw(in: textRect5)
		
		let image6X = imageRect3.origin.x
		let imageRect6 = CGRect(x: image6X, y: (pageRect.height/2),
								width: scaledWidth6, height: scaledHeight6)
		image6.draw(in: imageRect6)
		
		let textTop6 = (pageRect.height / 2) + imageRect6.height + 4
		
		let textRect6 = CGRect(
			x: imageRect6.origin.x + 4,
			y: textTop6,
			width: scaledWidth6 - 4,
			height: size6.height
		)
		drawContext.saveGState()
		// 3
		drawContext.setLineWidth(2.0)
		
		drawContext.setFillColor(Constants.Colors.field(darkMode: false).color.cgColor)
		drawContext.fill(CGRect(x: image6X, y: textTop6 - 4,width: imageRect6.width,height: size6.height + 8))
		drawContext.strokePath()
		drawContext.restoreGState()
		attributedText6.draw(in: textRect6)
		
		return textRect1.origin.y + textRect1.height
	}
}
