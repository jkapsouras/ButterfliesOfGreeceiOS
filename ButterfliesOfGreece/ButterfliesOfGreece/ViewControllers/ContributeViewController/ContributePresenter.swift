//
//  ContributePresenter.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit

class ContributePresenter:BasePresenter{
	let locationManager:LocationManager
	let contributionRepository:ContributionRepository
	var contributeState:ContributeState
	
	init(mainThread:MainThreadProtocol,backgroundThread:BackgroundThreadProtocol,
		 contributionRepository:ContributionRepository, locationManager:LocationManager)
	{
		self.contributionRepository = contributionRepository
		self.locationManager = locationManager
		contributeState = ContributeState(contributionItem: ContributionItem(), exportedHtml: "", pdfData: Data())
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
		locationManager.locationObs.observeOn(backgroundThreadScheduler.scheduler).subscribe(onNext: {locationState in
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
				contributionRepository.saveContributionItem(item: contributeState.contributionItem)
					.subscribeOn(backgroundThreadScheduler.scheduler)
					.subscribe(onNext: {done in
								self.state.onNext(done ? ContributeViewStates.showItemAdded : ContributeViewStates.showItemNotAdded)})
					.disposed(by: disposeBag!)
			case .exportClicked:
				contributionRepository.getContributionItems()
//					.subscribeOn(backgroundThreadScheduler.scheduler)
					.do(onNext: {items in
								self.contributeState = self.contributeState.prepareHtmlForExport(items: items)
				let pdfManager = PdfManager()
							self.contributeState = self.contributeState.with(pdfData:pdfManager.createRecordsTable(html: self.contributeState.exportedHtml, printRenderer: UIPrintPageRenderer()))
							self.state.onNext(ContributeViewStates.showExtractedPdf(pdfData: self.contributeState.pdfData ?? Data()))})
					.flatMap{_ in
						self.contributionRepository.delete()}
					.subscribe(onNext: {_ in print("all good")})
					.disposed(by: disposeBag!)
			case .sharePdf:
				state.onNext(ContributeViewStates.showShareDialog(pdfData: contributeState.pdfData ?? Data()))
			case .instructionsClicked:
				state.onNext(ContributeViewStates.showInstructions)
			case .closePdf:
				state.onNext(ContributeViewStates.closePdf)
			}
		default:
			state.onNext(GeneralViewState.idle)
		}
	}
}
