//
//  FamiliesPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class FamiliesPresenterTests: XCTestCase {
	var presenter: FamiliesPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		presenter = FamiliesPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler))
		self.disposeBag = DisposeBag()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testShouldChangeArrangeStyleOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.familiesState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.switchViewStyle) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .SwitchViewStyle(let currentArrange):
			XCTAssert(currentArrange == .list)
		default:
			XCTFail()
		}
	}
	
	func testShouldReadJsonData()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.loadFamilies) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .ShowFamilies(let families):
			XCTAssert(families.count == 1)//test json data
		default:
			XCTFail()
		}
	}
	
	func testShouldNavigateToSpeciesOnFamilyClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.familiesState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.familyClicked(id: 1)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .ToSpecies(let selectedFamilyId):
			XCTAssert(selectedFamilyId == 1)//test json data
		default:
			XCTFail()
		}
	}
}
