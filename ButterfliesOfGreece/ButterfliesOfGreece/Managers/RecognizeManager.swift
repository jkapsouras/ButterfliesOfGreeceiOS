//
//  RecognizeManager.swift
//  ButterfliesOfGreece
//
//  Created by Apprecot on 28/9/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation


class ModelDataHandler {
	lazy var labels: [String] = {
		if let filePath = Bundle.main.path(forResource: "labels_pt_last", ofType: "txt"),
		   let labels = try? String(contentsOfFile: filePath) {
			return labels.components(separatedBy: .newlines)
		} else {
			fatalError("Can't find the text file!")
		}
	}()
	
	lazy var module: TorchModule = {
		if let filePath = Bundle.main.path(forResource: "model-3", ofType: "pt"),
		   let module = TorchModule(fileAtPath: filePath) {
			return module
		} else {
			fatalError("Can't find the model file!")
		}
	}()
	
	
}
