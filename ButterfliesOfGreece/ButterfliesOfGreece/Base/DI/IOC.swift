//
//  IOC.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 24/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import RxSwift
import CoreLocation

protocol IOCInjectable
{
    static var container:Container? { get set }
    static func RegisterElements()->Container
    static func RegisterDataSources(container:Container)
	static func RegisterSchedulers(container:Container)
//    static func RegisterUseCases(container:Container)
    static func RegisterPresenters(container:Container)
}

struct IOC:IOCInjectable
{
     static func RegisterElements() -> Container {
        container=Container()
        
		RegisterDataSources(container: (container!))
        RegisterSchedulers(container: container!)
        RegisterRepositories(container: container!)
        RegisterPresenters(container: container!)
        return container!
    }
	
	static func RegisterSchedulers(container:Container){
		container.register(BackgroundThreadProtocol.self) { _ in BackgroundThreadScheduler(scheduler: ConcurrentDispatchQueueScheduler(qos: .background)) }.inObjectScope(.container)
        container.register(MainThreadProtocol.self) { _ in MainThreadScheduler(scheduler: MainScheduler.instance) }.inObjectScope(.container)
	}
    
     static func RegisterDataSources(container: Container) {
		container.autoregister(Storage.self, initializer: Storage.init).inObjectScope(.container)
		container.autoregister(LocationManager.self, initializer: LocationManager.init).inObjectScope(.container)
		container.register(CacheManagerProtocol.self) { _ in CacheManager(userDefaults: UserDefaults.standard)}.inObjectScope(.container)
		container.autoregister(CLLocationManager.self, initializer: CLLocationManager.init).inObjectScope(.container)
//		container.register(LocationProtocol.self) { _ in LocationManager(manager: CLLocationManager())}.inObjectScope(.container)
    }
    
     static func RegisterRepositories(container: Container) {
		container.autoregister(FamiliesRepository.self, initializer: FamiliesRepository.init)
		container.autoregister(SpeciesRepository.self, initializer: SpeciesRepository.init)
		container.autoregister(PhotosRepository.self, initializer: PhotosRepository.init)
		container.autoregister(NavigationRepository.self, initializer: NavigationRepository.init)
		container.autoregister(PhotosToPrintRepository.self, initializer: PhotosToPrintRepository.init)
		container.autoregister(ContributionRepository.self, initializer: ContributionRepository.init)
    }
    
     static func RegisterPresenters(container: Container) {
        container.autoregister(MenuPresenter.self, initializer: MenuPresenter.init)
        container.autoregister(FamiliesPresenter.self, initializer: FamiliesPresenter.init)
		container.autoregister(SpeciesPresenter.self, initializer: SpeciesPresenter.init)
		container.autoregister(PhotosPresenter.self, initializer: PhotosPresenter.init)
		container.autoregister(ModalPresenter.self, initializer: ModalPresenter.init)
		container.autoregister(SearchPresenter.self, initializer: SearchPresenter.init)
		container.autoregister(PrintToPdfPresenter.self, initializer: PrintToPdfPresenter.init)
		container.autoregister(PdfPreviewPresenter.self, initializer: PdfPreviewPresenter.init)
		container.autoregister(ContributePresenter.self, initializer: ContributePresenter.init)
    }
    
    public static var container: Container?
    
}
