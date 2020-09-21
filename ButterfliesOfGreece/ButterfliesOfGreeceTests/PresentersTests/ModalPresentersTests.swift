//
//  ModalPresentersTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 26/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class ModalPresenterTests: XCTestCase {
	var presenter: ModalPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		presenter = ModalPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), photosRepository: PhotosRepository(storage: Storage()), navigationRepository: NavigationRepository(storage: Storage()))
		self.disposeBag = DisposeBag()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testShouldFindeIndexZeroForFirstSelectedPhoto()
	{
		let observer = scheduler.createObserver(ViewState.self)
		var storage = Storage()
		_ = storage.setFamilyId(familyId: 0)
		_ = storage.setSpecieId(specieId: 0)
		_ = storage.setPhotoId(photoId: 0)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (ModalEvents.loadPhotos(specieId: 0, photoId: 0)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: (presenter!.disposeBag)!)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is ModalViewStates)
		let viewState = observer.events.first?.value.element as! ModalViewStates
		switch viewState {
		case .ShowPhotosStartingWith(let index, _):
				XCTAssert(index == 0)
		}
	}
}
