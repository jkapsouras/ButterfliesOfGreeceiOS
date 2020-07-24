//
//  UiComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

public protocol UiComponent
{
     var  UiEvents:Observable<UiEvent> {get}
     func RenderViewState(viewState:ViewState)
}
