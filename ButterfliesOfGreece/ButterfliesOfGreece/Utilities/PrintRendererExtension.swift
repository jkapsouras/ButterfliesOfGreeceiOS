//
//  PrintRendererExtension.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

extension UIPrintPageRenderer {
	public func exportHTMLContentToPDF(HTMLContent: String) -> Data {
		let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
		self.addPrintFormatter(printFormatter, startingAtPageAt: 0)
	 
		let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: self)
	 
		return pdfData
	}
	
	func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> Data {
		let data = NSMutableData()

		   UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
		   printPageRenderer.prepare(forDrawingPages: NSMakeRange(0, printPageRenderer.numberOfPages))

		   let bounds = UIGraphicsGetPDFContextBounds()

		   for i in 0...(printPageRenderer.numberOfPages - 1) {
			   UIGraphicsBeginPDFPage()
			   printPageRenderer.drawPage(at: i, in: bounds)
		   }

		   UIGraphicsEndPDFContext();
		   return data as Data
	}
}
