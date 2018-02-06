//
//  ViewController.swift
//  keyGen
//
//  Created by John Baker on 2/5/18.
//  Copyright © 2018 B4k3R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//--Default Values--//
	//key length
	var userLength = 1
	//key type
	var letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	
//--On View Load--//
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		let screenSize = UIScreen.main.bounds.size
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		generateKeyButtonOutlet.layer.cornerRadius = 4.0
		
	//TEST
		//change the 10 & the 0 to get different key types & lengths)
		//see below for key type to number value
		//once UI is set up we can change it to take user input instead of 10
		//& assign numbers to the segmented control choice, then take that number here instead of 0
		generateKey(keyLength: 10, keyType: 0)
    }
	
	@IBOutlet weak var characterInputOutlet: UITextField!
	@IBAction func characterInputAction(_ sender: Any) {
		
	}
	
	
	
	@IBOutlet weak var keyTypeOutlet: UISegmentedControl!
	@IBAction func keyTypeAction(_ sender: Any) {
		
	}
	
	
	
	@IBOutlet weak var isCapitalOutlet: UISwitch!
	@IBAction func isCapitalAction(_ sender: Any) {
		
	}
	
	
	
	@IBOutlet weak var generateKeyButtonOutlet: UIButton!
	@IBAction func generateKeyButtonAction(_ sender: Any) {
		generateKey(keyLength: 10, keyType: 0)
		
	}
	
	
	
	@IBOutlet weak var textViewOutlet: UITextView!
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	func generateKey(keyLength: Int, keyType: Int){
		//--Key Type Letters--//
		if keyType == 0 {
			letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
			randomString(length: keyLength)
		}
		//--Key Type Number--//
		else if keyType == 1 {
			letters = "0123456789"
			randomString(length: keyLength)
		}
		//--Key Type Both--//
		else {
			letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
			randomString(length: keyLength)
		}
	}
	
//--Key Generator Function--//
	func randomString(length: Int) -> String {
		let len = UInt32(letters.length)
		var randomString = ""
		for _ in 0 ..< length {
			let rand = arc4random_uniform(len)
			var nextChar = letters.character(at: Int(rand))
			randomString += NSString(characters: &nextChar, length: 1) as String
		}
		print(randomString)
		textViewOutlet.text = randomString
		return randomString
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
}

