//
//  PrintPhotosToPdfPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 13/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class PrintToPdfPresenterTests: XCTestCase {
	var presenter: PrintToPdfPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var mockCachManager: MockCacheManager!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		mockCachManager = MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 0))
		presenter = PrintToPdfPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), photosToPrintRepository: PhotosToPrintRepository(cacheManager: mockCachManager, storage: Storage()))
		self.disposeBag = DisposeBag()
	}
	
	func testShouldLoadZeroPhotosWhenNoPhotosAddedInCache(){
		
		let observer = scheduler.createObserver(ViewState.self)
		
		mockCachManager = MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 0))
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (PrintToPdfEvents.loadPhotos) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[0].value.element?.isTransition ?? false))
		XCTAssert(observer.events[0].value.element != nil &&
			observer.events[0].value.element is PrintToPdfViewStates)
		let viewState = observer.events[0].value.element as! PrintToPdfViewStates
		switch viewState {
		case .showPhotos(let photos):
			XCTAssert(photos.count == 0)//test json data
		}
	}
	
	func testShouldLoadNumberOfPhotosWhenNumberOfPhotosIsInCache(){
		
		let observer = scheduler.createObserver(ViewState.self)
		
		mockCachManager = MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 10))
		presenter = PrintToPdfPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), photosToPrintRepository: PhotosToPrintRepository(cacheManager: mockCachManager, storage: Storage()))
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (PrintToPdfEvents.loadPhotos) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[0].value.element?.isTransition ?? false))
		XCTAssert(observer.events[0].value.element != nil &&
			observer.events[0].value.element is PrintToPdfViewStates)
		let viewState = observer.events[0].value.element as! PrintToPdfViewStates
		switch viewState {
		case .showPhotos(let photos):
			XCTAssert(photos.count == 10)//test json data
		}
	}
}

//	func testShouldDeleteSelectedPhotos(){
//
//	}
//
//	func testShouldChangeArrangeInPdfCreation(){
//
//	}
//
//	func testShouldShowPrintedPdf(){
//
//	}
//}


