//
//  ViewState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

protocol ViewState {}

protocol StateTransition : ViewState { }

class IdleState:ViewState{}
