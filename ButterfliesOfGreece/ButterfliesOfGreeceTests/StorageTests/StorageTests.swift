//
//  StorageTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 1/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class StorageTests: XCTestCase {
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }
	
	func testShouldGetAllImagesFromFamilies(){
		var storage = Storage()
		let families = storage.families;
		let photos = families.flatMap{$0.species}.flatMap{$0.photos}
		assert(photos.count == 489)
	}
	
	func testShouldGetAllSpeciesFromSearchTerm(){
		var storage = Storage()
		let species = storage.searchSpeciesBy(term: "Iphiclides podalirius")
		XCTAssert(species.count == 1)
	}
	
	func testShouldGetAllNoSpeciesFromEmptyTerm(){
		var storage = Storage()
		let species = storage.searchSpeciesBy(term: "")
		XCTAssert(species.count == 0)
	}
}
