//
//  ContributeState.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct ContributeState {
	var contributionItem: ContributionItem
	var exportedHtml: String
	var pdfData: Data?
	
	init(contributionItem:ContributionItem, exportedHtml:String, pdfData: Data?){
		self.contributionItem = contributionItem
		self.exportedHtml = exportedHtml
		self.pdfData = pdfData
	}
}

extension ContributeState{
	func with(pdfData:Data? = nil, name:String? = nil, date:String? = nil, altitude:String? = nil, place:String? = nil, longitude:String? = nil, latitude:String? = nil, stage:String? = nil, genusSpecies:String? = nil, nameSpecies:String? = nil, comments: String? = nil, exportedHtml: String? = nil) -> ContributeState{
		let item = self.contributionItem.with(name: name ?? self.contributionItem.name, date: date ?? self.contributionItem.date, altitude: altitude ?? self.contributionItem.altitude, place: place ?? self.contributionItem.place, longitude: longitude ?? self.contributionItem.longitude, latitude: latitude ?? self.contributionItem.latitude, stage: stage ?? self.contributionItem.stage, genusSpecies: genusSpecies ?? self.contributionItem.genusSpecies, nameSpecies: nameSpecies ?? self.contributionItem.nameSpecies, comments: comments ?? self.contributionItem.comments)
		return ContributeState(contributionItem: item, exportedHtml: exportedHtml ?? self.exportedHtml,pdfData: pdfData ?? self.pdfData)
	}
	
	func prepareHtmlForExport(items:[ContributionItem]) -> ContributeState{
		var xdatarows:String = ""
		let	xdata:String = "<html><head><style>table{border-collapse:collapse;width:100%}td,th{text-align:left;padding:8px;}tr:nth-child(even){background-color:#f2f2f2; -webkit-print-color-adjust: exact; }th{background-color:#4CAF50;color:#fff; -webkit-print-color-adjust: exact; }</style></head><body><table><tr><th>Photo Name</th><th>Date</th><th>Altitude</th><th>Place</th><th>Longtitude</th><th>Latitude</th><th>Stage</th><th>Genus Spieces</th><th>Name Spieces</th><th>Comments</th></tr>"
		//add the date field in table
		for item in items {
			xdatarows += "<tr><td>\(item.name ?? "")</td><td>\(item.date ?? "")</td><td>\(item.altitude ?? "")</td><td>\(item.place ?? "")</td><td>\(item.longitude ?? "")</td><td>\(item.latitude ?? "")</td><td>\(item.stage ?? "")</td><td>\(item.genusSpecies ?? "")</td><td>\(item.nameSpecies ?? "")</td><td>\(item.comments ?? "")</td></tr>"
		}
		let xdataend:String = "</table></body></html>";
		let xdatafinal = xdata + xdatarows + xdataend;
		return self.with(exportedHtml: xdatafinal)
	}
}
