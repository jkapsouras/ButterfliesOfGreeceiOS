//
//  ButterflyPhotoExtensionTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest

@testable import ButterfliesOfGreece

class ButterflyPhotoExtensionTests: XCTestCase {
	var photos: [ButterflyPhoto]?
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		photos = [
			ButterflyPhoto(id: 0, source: "001_001", title: "B1", author: "Pamperis", genre: .F, identified: true),
			ButterflyPhoto(id: 1, source: "001_002", title: "B2", author: "Pamperis", genre: .F, identified: true)
		]
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testShouldRemoveDuplicates()
	{
		let tmpPhotos = [
			ButterflyPhoto(id: 0, source: "001_001", title: "B1", author: "Pamperis", genre: .F, identified: true),
			ButterflyPhoto(id: 1, source: "001_002", title: "B2", author: "Pamperis", genre: .F, identified: true)
		]
		let finalPhotos = photos! + tmpPhotos
		let photosWithNoDuplicates = finalPhotos.uniques
		XCTAssert(photosWithNoDuplicates.count == 2)
	}
}
