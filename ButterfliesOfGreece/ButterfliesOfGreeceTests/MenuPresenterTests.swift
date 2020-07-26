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

class MockBackgroundThreadScheduler: BackgroundThreadProtocol {
    var scheduler: SchedulerType
	init(scheduler:TestScheduler) {
        self.scheduler=scheduler
    }
}

class MockMainThreadScheduler: MainThreadProtocol {
    var scheduler: SchedulerType
	init(scheduler:TestScheduler) {
		self.scheduler=scheduler
	}
}

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
            Recorded.next(200, (FieldClicked()) as UiEvent)
			])
            .bind(onNext: {event in self.presenter?.HandleEvent(uiEvent: event)})
            .disposed(by: presenter!.disposeBag)
        
        presenter.state.bind(to: observer)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
         XCTAssert(observer.events.first?.value.element is NavigateToField)
    }
    
    func testShouldNotReceiveTransitionStateOnUnexpectedEvent()
    {
        let observer = scheduler.createObserver(ViewState.self)
        
		scheduler
        .createHotObservable([
            Recorded.next(200, (Idle()) as UiEvent)
        ])
            .bind(onNext: {event in self.presenter?.HandleEvent(uiEvent: event)})
            .disposed(by: presenter!.disposeBag)
        
        presenter.state.bind(to: observer)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssert(!(observer.events.first?.value.element is StateTransition))
    }
}
