//
//  MenuPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class MenuPresenterTests: XCTestCase {
    var presenter: MenuPresenter!
    var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
    var scheduler:TestScheduler!
    var disposeBag:DisposeBag!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		presenter = MenuPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler))
        self.disposeBag = DisposeBag()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldNavigateToFieldOnClick()
    {
        let observer = scheduler.createObserver(ViewState.self)
        
        scheduler
        .createHotObservable([
			Recorded.next(200, (MenuEvent.fieldClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
            .disposed(by: presenter!.disposeBag)
        
        presenter.state.bind(to: observer)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toField)
    }
	
	func testShouldNavigateToIntordutionOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.introductionClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toIntroduction)
	}
	
	func testShouldNavigateToAboutOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.aboutClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toAbout)
	}
	
	func testShouldNavigateToContributeOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.contributeClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toContribute)
	}
	
	func testShouldNavigateToEndangeredOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.endangeredSpeciesClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toEndangered)
	}
	
	func testShouldNavigateToLegalOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.legalClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toLegal)
	}
	
	func testShouldNavigateToOfflineRecognitionOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.offlineRecognitionClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toOfflineRecognition)
	}
	
	func testShouldNavigateToOnlineRecognitionOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (MenuEvent.onlineRecognitionClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element is MenuViewState)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is MenuViewState &&
			(observer.events.first!.value.element as! MenuViewState) == MenuViewState.toOnlineRecognition)
	}
    
    func testShouldNotReceiveTransitionStateOnUnexpectedEvent()
    {
        let observer = scheduler.createObserver(ViewState.self)
        
		scheduler
        .createHotObservable([
			Recorded.next(200, (GeneralEvents.idle) as UiEvent)
        ])
            .bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
            .disposed(by: presenter!.disposeBag)
        
        presenter.state.bind(to: observer)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
    }
}
