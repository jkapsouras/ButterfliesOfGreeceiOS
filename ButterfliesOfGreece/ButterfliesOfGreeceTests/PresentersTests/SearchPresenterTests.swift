//
//  SearchPresenterTests.swift
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

class SearchPresenterTests: XCTestCase {
	var presenter: SearchPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		presenter = SearchPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), speciesRepository: SpeciesRepository(storage: Storage()), navigationRepository: NavigationRepository(storage: Storage()))
		self.disposeBag = DisposeBag()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	func testShouldGetSpeciesFromSearchTerm()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (SearchEvents.searchWith(term: "Iphiclides podalirius")) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[0].value.element?.isTransition ?? false))
		XCTAssert(observer.events[0].value.element != nil &&
			observer.events[0].value.element is SearchViewStates)
		let viewState = observer.events[0].value.element as! SearchViewStates
		switch viewState {
		case .ShowResult(let species, _):
			XCTAssert(species.count == 1)//test json data
		default:
			XCTFail()
		}
	}
	
	func testShouldNavigateToPhotosOnSpecieClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (SearchEvents.specieClicked(specie: Specie(id: 1, familyId: 1, name: "test", imageTitle: "teset", photos: [ButterflyPhoto]()))) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is SearchViewStates)
		let viewState = observer.events.first?.value.element as! SearchViewStates
		switch viewState {
		case .ToSpecie:
			XCTAssert(Storage.specieId == 1)//test json data
		default:
			XCTFail()
		}
	}
	
	func testShouldInitSearchPresenterWithNoSpecies()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (SearchEvents.searchWith(term: "")) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events[0].value.element?.isTransition ?? false))
		XCTAssert(observer.events[0].value.element != nil &&
			observer.events[0].value.element is SearchViewStates)
		let viewState = observer.events[0].value.element as! SearchViewStates
		switch viewState {
		case .ShowResult(let result, _):
			XCTAssert(result.count == 0)//test json data
		default:
			XCTFail()
		}
	}
}
