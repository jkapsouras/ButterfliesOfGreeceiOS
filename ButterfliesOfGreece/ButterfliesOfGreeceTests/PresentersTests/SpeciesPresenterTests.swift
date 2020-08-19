//
//  SpeciesPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Apprecot on 19/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class SpeciesPresenterTests: XCTestCase {
	var presenter: SpeciesPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		let mockCachManager = MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 0))
		presenter = SpeciesPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), speciesRepository: SpeciesRepository(storage: Storage()), photosToPrintRepository: PhotosToPrintRepository(cacheManager: mockCachManager, storage: Storage()))
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
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is SpeciesViewStates)
		let viewState = observer.events.first?.value.element as! SpeciesViewStates
		switch viewState {
			case .SwitchViewStyle(let currentArrange):
				XCTAssert(currentArrange == .list)
			default:
				XCTFail()
		}
	}
	
	func testShouldGetSpeciesData()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (SpeciesEvents.loadSpecies(familyId: 0)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is SpeciesViewStates)
		let viewState = observer.events.first?.value.element as! SpeciesViewStates
		switch viewState {
			case .ShowSpecies(let species):
				XCTAssert(species.count == 9)//test json data
			default:
				XCTFail()
		}
	}
	
	func testShouldNavigateToPhotosOnSpecieClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (SpeciesEvents.specieClicked(id: 1)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is SpeciesViewStates)
		let viewState = observer.events.first?.value.element as! SpeciesViewStates
		switch viewState {
			case .ToPhotos(let specieId):
				XCTAssert(specieId == 1)//test json data
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
				Recorded.next(200, (HeaderViewEvents.initState(arrange: .list)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
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
		}
		XCTAssert(observer.events[1].value.element != nil &&
			observer.events[1].value.element is SpeciesViewStates)
		let speciesViewState = observer.events[1].value.element as! SpeciesViewStates
		switch speciesViewState {
			case .SwitchViewStyle(let arrange):
				XCTAssert(arrange == .list)//test json data
			default:
				XCTFail()
		}
	}
	
	func testShouldGetCorrectNumberOfAddedPhotos()
	{
		let observer = scheduler.createObserver(ViewState.self)
		let photosPerSpecieInFamily = [2,4]

		presenter.headerState = presenter.headerState.with(arrange: .grid, photos: nil)

		scheduler
			.createHotObservable([
				Recorded.next(100, (SpeciesEvents.loadSpecies(familyId: 0)) as UiEvent),
				Recorded.next(200, (SpeciesEvents.addPhotosForPrintClicked(specieId: 0)) as UiEvent),
				Recorded.next(300, (SpeciesEvents.addPhotosForPrintClicked(specieId: 1)) as UiEvent)
//				Recorded.next(400, (FamiliesEvents.addPhotosForPrintClicked(familyId: 2)) as UiEvent),
//				Recorded.next(500, (FamiliesEvents.addPhotosForPrintClicked(familyId: 3)) as UiEvent),
//				Recorded.next(600, (FamiliesEvents.addPhotosForPrintClicked(familyId: 4)) as UiEvent),
//				Recorded.next(700, (FamiliesEvents.addPhotosForPrintClicked(familyId: 5)) as UiEvent),
//				Recorded.next(800, (FamiliesEvents.addPhotosForPrintClicked(familyId: 6)) as UiEvent),
//				Recorded.next(900, (FamiliesEvents.addPhotosForPrintClicked(familyId: 7)) as UiEvent),
//				Recorded.next(1000, (FamiliesEvents.addPhotosForPrintClicked(familyId: 8)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)

		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)

		scheduler.start()

		var sum = 0
		var index = -1
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
						sum += photosPerSpecieInFamily[index]
						print("sum: \(sum)")
						XCTAssert(numberOfPhotos == sum)
				}
				index += 1
			}
		})
		print("sum = \(sum)")
		print("reduce =  \(photosPerSpecieInFamily.reduce(0, +))")
	}
}
