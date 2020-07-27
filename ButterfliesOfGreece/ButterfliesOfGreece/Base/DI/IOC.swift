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
        
//		RegisterDataSources(container: (container!))
        RegisterSchedulers(container: container!)
//        RegisterUseCases(container: container!)
        RegisterPresenters(container: container!)
        return container!
    }
	
	static func RegisterSchedulers(container:Container){
		container.register(BackgroundThreadProtocol.self) { _ in BackgroundThreadScheduler(scheduler: ConcurrentDispatchQueueScheduler(qos: .background)) }.inObjectScope(.container)
        container.register(MainThreadProtocol.self) { _ in MainThreadScheduler(scheduler: MainScheduler.instance) }.inObjectScope(.container)
	}
    
     static func RegisterDataSources(container: Container) {
//		container.autoregister(AccountManagerProtocol.self, initializer: AccountManager.init).inObjectScope(.container)
//		container.register(AccountManagerProtocol.self) { _ in AccountManager(prefs: UserDefaults.standard)}.inObjectScope(.container)
    }
    
//     static func RegisterUseCases(container: Container) {
//        container.autoregister(GenericLoginUseCase<String,LoginAsync>.self, initializer: FakeLoginUseCase.init)
//		container.autoregister(GenericTestUrlUseCase<String,TestURLAsync>.self, initializer: FakeTestUrlUseCase.init)
//        container.autoregister(GenericSaveUrlUseCase<String,Bool>.self, initializer: SaveUrlUseCase.init)
//    }
    
     static func RegisterPresenters(container: Container) {
        container.autoregister(MenuPresenter.self, initializer: MenuPresenter.init)
        container.autoregister(FamiliesPresenter.self, initializer: FamiliesPresenter.init)
    }
    
    public static var container: Container?
    
}
