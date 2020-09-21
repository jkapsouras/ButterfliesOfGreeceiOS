//
//  LocationManager.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationProtocol {
	var manager:CLLocationManager { get }
	var locationObs:Observable<LocationState> { get }
	
	func checkPermissions()
	func getPermissionStatus() -> Observable<LocationState>
	func askForPermissions()
	func askForLocation()
}

enum LocationState{
	case showLocation(location: CLLocationCoordinate2D)
	case showSettings
	case askLocation
	case askPermission
	case locationErrored
}

class LocationManager:NSObject, CLLocationManagerDelegate, LocationProtocol{
	var manager:CLLocationManager
	let emitter:PublishSubject<LocationState> = PublishSubject<LocationState>()
	var locationObs:Observable<LocationState> {get {return emitter.asObservable()}}
	
	init(manager:CLLocationManager){
		self.manager = manager
		super.init()
		manager.delegate = self
	}
	
	func checkPermissions(){
		manager.requestWhenInUseAuthorization()
	}
	
	func getPermissionStatus() -> Observable<LocationState>{
		var state:LocationState
		let status = CLLocationManager.authorizationStatus()
		switch status{
		case .authorizedWhenInUse,
			 .authorizedAlways:
			state = .askLocation
		case .notDetermined:
			state = .askPermission
		default:
			state = .showSettings
		}
		return Observable.from(optional: state)
	}
	
	func askForPermissions(){
		manager.requestWhenInUseAuthorization()
	}
	
	func askForLocation(){
		manager.requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
		print("locations = \(locValue.latitude) \(locValue.longitude)")
		emitter.onNext(LocationState.showLocation(location: locValue))
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		emitter.onNext(LocationState.locationErrored)
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedWhenInUse:
			askForLocation()
		default:
			break
		}
	}
}
