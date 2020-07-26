//
//  MainThreadScheduler.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

protocol MainThreadProtocol
{
    var scheduler: SchedulerType { get }
}

class MainThreadScheduler: MainThreadProtocol {
	
    var scheduler: SchedulerType
	
    init(scheduler:SchedulerType) {
        self.scheduler=scheduler
    }
}
