//
//  PhotosTableSource.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 11/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhotosTableSource : NSObject, UITableViewDataSource, UITableViewDelegate
{
	var families:[Family] = []
	var species:[Specie] = []
	let emitter = PublishSubject<UiEvent>()
	var emitterObs:Observable<UiEvent> {get {return emitter.asObservable()}}
	var showingStep = ShowingStep.families
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.Key, for: indexPath) as! PhotosTableViewCell
		switch showingStep {
		case .families:
			cell.update(family: (families[indexPath.row]), emitter: emitter, showingStep: showingStep)
		case .species:
			cell.update(specie: (species[indexPath.row]), emitter: emitter, showingStep: showingStep)
		default:
			print("not implemented yet")
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let cell = cell as? PhotosTableViewCell{
			cell.addRecognizers()
		}
	}
	
	func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let cell = cell as? PhotosTableViewCell{
			cell.removeRecognizers()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch showingStep {
		case .families:
			emitter.onNext(FamiliesEvents.familyClicked(id: families[indexPath.row].id))
		case .species:
			emitter.onNext(SpeciesEvents.specieClicked(id: species[indexPath.row].id))
		default:
			print("not implemented yet")
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch showingStep {
		case .families:
			return families.count
		case .species:
			return species.count
		default:
			return 0
		}
	}
	
	func setFamilies(families: [Family]){
		self.families = families
	}
	
	func setSpecies(species: [Specie]){
		self.species = species
	}
	
	func setShowingStep(showingStep:ShowingStep){
		self.showingStep = showingStep
	}
}

