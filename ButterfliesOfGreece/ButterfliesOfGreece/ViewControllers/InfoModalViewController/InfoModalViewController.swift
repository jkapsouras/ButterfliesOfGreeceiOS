//
//  InfoModalViewController.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 19/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit

class InfoModalViewController: UIViewController {
	@IBOutlet weak var TextContribute: UITextView!
	@IBOutlet weak var ButtonClose: UIButton!
	@IBOutlet weak var LabelTitle: UILabel!
	@IBOutlet weak var ViewHeader: UIView!
	override func viewDidLoad() {
        super.viewDidLoad()

		LabelTitle.textColor = Constants.Colors.contribute(darkMode: false).color
		ViewHeader.backgroundColor = Constants.Colors.contribute(darkMode: true).color
		ButtonClose.tintColor = Constants.Colors.contribute(darkMode: false).color
		view.backgroundColor = Constants.Colors.contribute(darkMode: false).color
		TextContribute.backgroundColor = UIColor.clear
		TextContribute.textColor = Constants.Colors.contribute(darkMode: true).color
		ButtonClose.setImage(UIImage(imageLiteralResourceName: "closeX"), for: .normal)
		ButtonClose.setTitle("", for: .normal)
		
		
		LabelTitle.setFont(size: Constants.Fonts.titleControllerSise)
		TextContribute.setFont(size: Constants.Fonts.titleControllerSise)
		
		LabelTitle.text = Translations.ContributionInstructionsTitle
		TextContribute.text = Translations.ContributionInstructionsMessage
    }
    

	@IBAction func CloseAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
