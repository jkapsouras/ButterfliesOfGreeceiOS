//
//  BasePresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//
import RxSwift
import Foundation

class BasePresenter{
    
	   let disposeBag:DisposeBag=DisposeBag()
		let backgroundThreadScheduler:BackgroundThreadProtocol
		let mainThreadScheduler:MainThreadProtocol
		let  state:PublishSubject<ViewState> = PublishSubject()

		init(backScheduler:BackgroundThreadProtocol,mainScheduler:MainThreadProtocol)
		{
			backgroundThreadScheduler=backScheduler
			mainThreadScheduler=mainScheduler
		}

		func HandleEvent(uiEvents:UiEvent)
		{

		}

		public func Subscribe(events:Observable<UiEvent>)->Observable<ViewState>
		{
			events
				.subscribe(onNext: { event in self.HandleEvent(uiEvents: event)})
				.disposed(by: disposeBag)

			return state.asObservable().observeOn(mainThreadScheduler.scheduler)
		}
}
