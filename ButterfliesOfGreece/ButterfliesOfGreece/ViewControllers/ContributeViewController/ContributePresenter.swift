//
//  ContributePresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

class ContributePresenter:BasePresenter{
	let locationManager:LocationManager
	var contributeState:ContributeState
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 locationManager:LocationManager)
	{
		self.locationManager = locationManager
		contributeState = ContributeState(contributionItem: ContributionItem())
		super.init(backScheduler: backgroundThread, mainScheduler: mainThread)
	}
	
	override func setupEvents() {
		locationManager.getPermissionStatus().subscribe(onNext: {state in
			switch state{
			case .askLocation:
				self.locationManager.askForLocation()
			case .askPermission:
				self.locationManager.askForPermissions()
			case .showSettings:
				self.state.onNext(ContributeViewStates.showSettingsDialog)
			default:
				break
			}
		}).disposed(by: disposeBag!)
		locationManager.locationObs.subscribe(onNext: {locationState in
			switch locationState{
			case .showLocation(let location):
				self.emitter.onNext(ContributeEvents.locationFetched(location: location))
			case .locationErrored:
				self.state.onNext(ContributeViewStates.showLocationError)
			default:
				break
			}
			
		}).disposed(by: disposeBag!)
	}
	
	override func HandleEvent(uiEvents: UiEvent) {
		switch uiEvents {
		case let contributeEvents as ContributeEvents:
			switch contributeEvents {
			case .textDateClicked:
				state.onNext(ContributeViewStates.showDatePicker)
			case .buttonDoneClicked(let date):
				state.onNext(ContributeViewStates.hideDatePicker)
				let formatter:DateFormatter = DateFormatter()
				formatter.dateFormat = "dd/MM/yyyy"
				let dateStr = formatter.string(from: date)
				contributeState = contributeState.with(date: dateStr)
				state.onNext(ContributeViewStates.setDate(date: dateStr))
			case .locationFetched(let location):
				contributeState = contributeState.with(longitude: String(location.longitude), latitude: String(location.latitude))
				state.onNext(ContributeViewStates.showLocation(latitude: contributeState.contributionItem.latitude ?? "", longitude: contributeState.contributionItem.longitude ?? ""))
			case .textNameSet(let name):
				contributeState = contributeState.with(name: name)
			case .textAltitudeSet(altitude: let altitude):
				contributeState = contributeState.with(altitude: altitude)
			case .textPlaceSet(place: let place):
				contributeState = contributeState.with(place: place)
			case .textStateSet(stage: let stage):
				contributeState = contributeState.with(stage: stage)
			case .textGenusSpeciesSet(genusSpecies: let genusSpecies):
				contributeState = contributeState.with(genusSpecies: genusSpecies)
			case .textNameSpeciesSet(nameSpecies: let nameSpecies):
				contributeState = contributeState.with(nameSpecies: nameSpecies)
			case .textCommentsSet(comments: let comments):
				contributeState = contributeState.with(comments: comments)
			case .textLatitudeSet(latitude: let latitude):
				contributeState = contributeState.with(latitude: latitude)
			case .textLongitudeSet(longitude: let longitude):
				contributeState = contributeState.with(longitude: longitude)
			case .addClicked:
				break
			case .exportClicked:
				break 
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
