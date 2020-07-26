//
//  UiComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift

protocol UiComponent
{
     var  uiEvents:Observable<UiEvent> {get}
     func renderViewState(viewState:ViewState)
}
