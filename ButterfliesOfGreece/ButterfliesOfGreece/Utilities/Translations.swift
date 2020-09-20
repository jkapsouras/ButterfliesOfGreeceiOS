//
//  Translations.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

struct Translations {
	
	static var AppBundle:Bundle{
		get{FindLanguage()}
	}
	
	static var Field:String {
		get{
			"field_photos".Localise()
		}
	}
	
	static var Introduction:String {
		get{
			"introduction".Localise()
		}
	}
	
	static var About:String {
		get{
			"about".Localise()
		}
	}
	
	static var Contribute:String {
		get{
			"contribute".Localise()
		}
	}
	
	static var Legal:String {
		get{
			"legal".Localise()
		}
	}
	
	static var Recognition:String {
		get{
			"recognition".Localise()
		}
	}
	
	static var Endangered:String {
		get{
			"endangered".Localise()
		}
	}
	
	static var Done:String {
		get{
			"done".Localise()
		}
	}
	
	static var Families:String {
		get{
			"families".Localise()
		}
	}
	
	static var Photographer:String {
		get{
			"photographer".Localise()
		}
	}
	
	static var Images:String {
		get{
			"images".Localise()
		}
	}
	
	static var Page:String {
		get{
			"page".Localise()
		}
	}
	
	static var Photos:String {
		get{
			"photos".Localise()
		}
	}
	
	static var Select:String {
		get{
			"select".Localise()
		}
	}
	
	static var PhotoName:String {
		get{
			"photo_name".Localise()
		}
	}
	
	static var Date:String {
		get{
			"date".Localise()
		}
	}
	
	static var Altitude:String {
		get{
			"altitude".Localise()
		}
	}
	
	static var Place:String {
		get{
			"place".Localise()
		}
	}
	
	static var Longitude:String {
		get{
			"longitude".Localise()
		}
	}
	
	static var Latitude:String {
		get{
			"latitude".Localise()
		}
	}
	
	static var Stage:String {
		get{
			"stage".Localise()
		}
	}
	
	static var GenusSpecies:String {
		get{
			"genus_species".Localise()
		}
	}
	
	static var NameSpecies:String {
		get{
			"name_species".Localise()
		}
	}
	
	static var Comments:String {
		get{
			"comments".Localise()
		}
	}
	
	static var SendInfo:String {
		get{
			"send_info".Localise()
		}
	}
	
	static var LocationErrorTitle:String {
		get{
			"location_error_title".Localise()
		}
	}
	
	static var LocationErrorMessage:String {
		get{
			"location_error_message".Localise()
		}
	}
	
	static var Ok:String {
		get{
			"ok".Localise()
		}
	}
	
	static var NoLocationRights:String {
		get{
			"no_location_rights".Localise()
		}
	}
	
	static var NoLocationRightsMessage:String {
		get{
			"no_location_rights_message".Localise()
		}
	}
	
	static var OpenSettings:String {
		get{
			"open_settings".Localise()
		}
	}
	
	static var Contribution:String {
		get{
			"contribution".Localise()
		}
	}
	
	static var ContributionAdded:String {
		get{
			"contribution_added".Localise()
		}
	}
	
	static var ContributionNotAdded:String {
		get{
			"contribution_not_added".Localise()
		}
	}
	
	static var ContributionInstructionsMessage:String {
		get{
			"contribute_instructions_message".Localise()
		}
	}
	
	static var ContributionInstructionsTitle:String {
		get{
			"contribute_instructions_title".Localise()
		}
	}
	
	static var AboutTitle:String {
		get{
			"about_title".Localise()
		}
	}
	
	static var AboutSubtitle:String {
		get{
			"about_subtitle".Localise()
		}
	}
	
	static var AboutSecond:String {
		get{
			"about_second".Localise()
		}
	}
	
	static var AboutFirst:String {
		get{
			"about_first".Localise()
		}
	}
	
	static var AboutThird:String {
		get{
			"about_third".Localise()
		}
	}
	
	static var AboutThirdTitle:String {
		get{
			"about_third_title".Localise()
		}
	}
	
	static func FindLanguage(language:String? = nil)->Bundle
	{
		guard language != nil
			else{
				let locale =  NSLocale.autoupdatingCurrent.identifier.prefix(2)
				let path = Bundle.main.path(forResource: locale.base, ofType: "lproj")
				guard let myString = path, !myString.isEmpty else{
					return Bundle.main
				}
				return Bundle.init(path: path!)!
		}
		return Bundle.main
		//
		//            if (language.Equals(Greek))
		//                Language = Greek;
		//            else if (language.Equals(English))
		//                Language = English;
		//            else if (language.Equals(Spanish))
		//                Language = Spanish;
		//            else if (language.Equals(Chinese))
		//                Language = Chinese;
		//            else
		//                Language = German;
		//
		//            //new AccountManager().SaveLanguage(Language);
		//
		//            var path = NSBundle.MainBundle.PathForResource(language, "lproj");
		//            if (path == null)
		//                LanguageBundle = NSBundle.MainBundle;
		//            else
		//                LanguageBundle = NSBundle.FromPath(path);
		//            Xamarin.IQKeyboardManager.SharedManager.ToolbarDoneBarButtonItemText = Translations.Done;
	}
}
