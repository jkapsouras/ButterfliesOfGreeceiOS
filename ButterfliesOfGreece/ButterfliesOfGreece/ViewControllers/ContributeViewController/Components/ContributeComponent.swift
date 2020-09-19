//
//  ContributeComponent.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 18/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import RxSwift
import PDFKit

class ContributeComponent : UiComponent
{
	let owner:UIViewController
	let view:ContributeView
	let navigationItem:UINavigationItem
	let uiEvents: Observable<UiEvent>
	let emitter:PublishSubject<UiEvent> = PublishSubject()
	let pdfView:PDFView
	var share:UIBarButtonItem?
	var close:UIBarButtonItem?
	var info:UIBarButtonItem
	
	init(view:ContributeView, navigationItem:UINavigationItem, parentView:UIView, owner:UIViewController) {
		self.owner = owner
		self.view = view
		self.navigationItem = navigationItem
		uiEvents = Observable.merge(self.view.UiEvents,emitter.asObservable())
		// Create the info button
		let infoButton = UIButton(type: .infoLight)
		infoButton.tintColor = Constants.Colors.contribute(darkMode: true).color
		
		if let pdf = parentView.subviews.first(where: {v in v is PDFView}){
			pdfView = pdf as! PDFView
		}
		else{
			pdfView = PDFView(frame: parentView.bounds)
			parentView.addSubview(pdfView)
		}
		pdfView.alpha = 0
		// You will need to configure the target action for the button itself, not the bar button itemr
		
		// Create a bar button item using the info button as its custom view
		info = UIBarButtonItem(customView: infoButton)
		infoButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
		
		// Use it as required
		self.navigationItem.setRightBarButton(info, animated: true)
		
		
	}
	
	@objc func infoTapped(){
		emitter.onNext(ContributeEvents.instructionsClicked)
	}
	
	@objc func shareTapped(){
		emitter.onNext(ContributeEvents.sharePdf)
	}
	
	@objc func closeTapped(){
		emitter.onNext(ContributeEvents.closePdf)
	}
	
	public func renderViewState(viewState: ViewState) {
		if let state = viewState as? ContributeViewStates{
			switch state {
			case .showDatePicker:
				view.showDatePicker()
			case .hideDatePicker:
				view.hideDatePicker()
			case .setDate(let date):
				view.setDate(date: date)
			case .showLocation(let latitude,let longitude):
				view.setLocation(latitude: latitude, longitude: longitude)
			case .showSettingsDialog:
				view.openPromptToSettingsDialog(controller: owner)
			case .showLocationError:
				view.locationError(controller: owner)
			case .showItemAdded:
				view.showItem(added: true, controller: owner)
			case .showItemNotAdded:
				view.showItem(added: false, controller: owner)
			case .showExtractedPdf(let data):
				pdfView.document = PDFDocument(data: data)
				pdfView.autoScales = true
				pdfView.alpha = 1
				share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
				let closeButton = UIButton()
				closeButton.setTitle("", for: .normal)
				closeButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
				closeButton.setImage(UIImage(imageLiteralResourceName: "closeX").withRenderingMode(.alwaysTemplate), for: .normal)
				closeButton.tintColor = Constants.Colors.contribute(darkMode: true).color
				closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
				close = UIBarButtonItem(customView: closeButton)
				navigationItem.setRightBarButtonItems([share!, close!], animated: true)
			case .showShareDialog(let pdfData):
				let vc = UIActivityViewController(
					activityItems: [pdfData],
					applicationActivities: []
				)
				owner.present(vc, animated: true, completion: nil)
			case .closePdf:
				pdfView.alpha = 0
				navigationItem.setRightBarButtonItems(nil, animated: true)
				navigationItem.setRightBarButton(info, animated: true)
			default:
				break
			}
		}
	}
}
