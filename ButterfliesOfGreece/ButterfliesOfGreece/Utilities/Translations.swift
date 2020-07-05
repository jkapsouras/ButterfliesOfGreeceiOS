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
