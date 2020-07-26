//
//  BackgroundThreadScheduler.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

protocol BackgroundThreadProtocol
{
	var scheduler: SchedulerType { get }
}

struct BackgroundThreadScheduler: BackgroundThreadProtocol {
	
    var scheduler: SchedulerType
	
    init(scheduler:SchedulerType) {
        self.scheduler=scheduler
    }
}
