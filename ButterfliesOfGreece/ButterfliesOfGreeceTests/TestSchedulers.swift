//
//  TestSchedulers.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxTest

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
