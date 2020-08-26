//
//  PhotosPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 23/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class PhotosPresenterTests: XCTestCase {
	var presenter: PhotosPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		let mockCachManager = MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 0))
		presenter = PhotosPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), photosRepository: PhotosRepository(storage: Storage()), navigationRepository: NavigationRepository(storage: Storage()), photosToPrintRepository: PhotosToPrintRepository(cacheManager: mockCachManager, storage: Storage()))
		self.disposeBag = DisposeBag()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testShouldChangeArrangeStyleOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (HeaderViewEvents.switchViewStyleClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter?.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is PhotosViewStates)
		let viewState = observer.events.first?.value.element as! PhotosViewStates
		switch viewState {
			case .SwitchViewStyle(let currentArrange):
				XCTAssert(currentArrange == .list)
			default:
				XCTFail()
		}
	}
	
	func testShouldGetPhotosData()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		var storage = Storage()
		
		_ = storage.setFamilyId(familyId: 0)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (PhotosEvents.loadPhotos(specieId: 0)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[1].value.element?.isTransition ?? false))
		XCTAssert(observer.events[1].value.element != nil &&
			observer.events[1].value.element is PhotosViewStates)
		let viewState = observer.events[1].value.element as! PhotosViewStates
		switch viewState {
			case .ShowPhotos(let photos):
				print("photos.count = \(photos.count)")
				XCTAssert(photos.count == 2)//test json data
			default:
				XCTFail()
		}
	}
	
	func testShouldNavigateToPhotoOnPhotoClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (PhotosEvents.photoClicked(id: 1)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is PhotosViewStates)
		let viewState = observer.events.first?.value.element as! PhotosViewStates
		switch viewState {
			case .ToPhoto(let photoId):
				XCTAssert(photoId == 1)//test json data
			default:
				XCTFail()
		}
	}
	
	func testShouldInitHeaderStateWithProperArrangeAndZeroPhotosToPrint()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (HeaderViewEvents.initState(currentArrange: .list)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[0].value.element?.isTransition ?? false))
		XCTAssert(!(observer.events[1].value.element?.isTransition ?? false))
		XCTAssert(observer.events[0].value.element != nil &&
			observer.events[0].value.element is HeaderViewViewStates)
		let viewState = observer.events[0].value.element as! HeaderViewViewStates
		switch viewState {
			case .updateFolderIcon(let numberOfPhotos):
				XCTAssert(numberOfPhotos == 0)//test json data
			default:
			print("not interested")
		}
		XCTAssert(observer.events[1].value.element != nil &&
			observer.events[1].value.element is PhotosViewStates)
		let photosViewState = observer.events[1].value.element as! PhotosViewStates
		switch photosViewState {
			case .SwitchViewStyle(let arrange):
				XCTAssert(arrange == .list)//test json data
			default:
				XCTFail()
		}
	}
	
	func testShouldGetCorrectNumberOfAddedPhotos()
	{
		let observer = scheduler.createObserver(ViewState.self)
		let addedPhotos = [1,1]

		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)
		var storage = Storage()
		_ = storage.setFamilyId(familyId: 0)

		scheduler
			.createHotObservable([
				Recorded.next(100, (PhotosEvents.loadPhotos(specieId: 0)) as UiEvent),
				Recorded.next(200, (PhotosEvents.addPhotoForPrintClicked(photoId: 0)) as UiEvent),
				Recorded.next(300, (PhotosEvents.addPhotoForPrintClicked(photoId: 1)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)

		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)

		scheduler.start()

		var sum = 0
		var index = -2
		observer.events.forEach({(vs) in
			if index < 0{
				index += 1
			}
			else{
				XCTAssert(!(vs.value.element?.isTransition ?? false))
				XCTAssert(vs.value.element != nil &&
					vs.value.element is HeaderViewViewStates)
				let viewState = vs.value.element as! HeaderViewViewStates
				switch viewState {
					case .updateFolderIcon(let numberOfPhotos):
						print("Number of photos \(numberOfPhotos)")
						sum += addedPhotos[index]
						print("sum: \(sum)")
						XCTAssert(numberOfPhotos == sum)
					default:
					print("not interested")
				}
				index += 1
			}
		})
		print("sum = \(sum)")
		print("reduce =  \(addedPhotos.reduce(0, +))")
	}
}
