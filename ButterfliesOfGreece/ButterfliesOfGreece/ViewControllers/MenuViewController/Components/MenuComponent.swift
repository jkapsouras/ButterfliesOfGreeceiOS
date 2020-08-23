//
//  MenuComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MenuComponent : UiComponent
{
	var uiEvents: Observable<UiEvent>
    let FieldButton:UIButton
    
    init(field:UIButton) {
        FieldButton=field
        
        let fieldObs = FieldButton.rx.tap.map{tap in
			MenuEvent.fieldClicked as UiEvent}
        
        uiEvents = fieldObs
    }
    
    public func renderViewState(viewState: ViewState) {
        
    }
}
