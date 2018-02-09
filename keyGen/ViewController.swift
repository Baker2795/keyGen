//
//  ViewController.swift
//  keyGen
//
//  Created by John Baker on 2/5/18.
//  Copyright © 2018 B4k3R. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIGestureRecognizerDelegate {
	
	

//--Default Values--//
	//key length (default 18)
	var userLength = 18
	//key type (default both)
	var userType = 2
	//is capital? (default on)
	var userCapital = true
	//key type
	var letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	
//--On View Load--//
    override func viewDidLoad() {
        super.viewDidLoad()
		let screenSize = UIScreen.main.bounds.size
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		generateKeyButtonOutlet.layer.cornerRadius = 4.0
		
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
		textViewOutlet.addGestureRecognizer(tap)
		textViewOutlet.isUserInteractionEnabled = true
		
		
		
		
		
		//UiBar for keyboard
		numberToolbar.barStyle = UIBarStyle.default
		numberToolbar.items=[
			UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.cancelBar)),
			UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.doneBar))
		]
		numberToolbar.sizeToFit()
		characterInputOutlet.inputAccessoryView = numberToolbar
		
		//Dismiss Keyboard
		let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
		view.addGestureRecognizer(dismiss)
		numberToolbar.backgroundColor = UIColor(red:0.13, green:0.75, blue:0.96, alpha:1.0)
    }
	
	
//--KEYBAORD SETTINGS--//
	let numberToolbar: UIToolbar = UIToolbar()
	
	//Dismiss Keyboard
	@objc func DismissKeyboard(){
		view.endEditing(true)
	}
	@objc func doneBar () {
		characterInputOutlet.resignFirstResponder()
	}
	@objc func cancelBar () {
		characterInputOutlet.text=""
		userLength = 0
		characterInputOutlet.resignFirstResponder()
	}

	@objc func handleTap(_ sender: UITapGestureRecognizer) {
		print("Hello World")
		UIPasteboard.general.string = textViewOutlet.text
		print(textViewOutlet.text)
	}
	
//--Select key length (UP TO 50,000 CHAR)--//
	@IBOutlet weak var characterInputOutlet: UITextField!
	@IBAction func characterInputAction(_ sender: Any) {
		if isStringAnInt(string: characterInputOutlet.text!) {
			userLength = Int(characterInputOutlet.text!)!
			print(userLength)
		}
		else {
			print("input is not integer")
		}
	}
	
	func isStringAnInt(string: String) -> Bool {
		return Int(string) != nil
	}
	
//--Select key type (NUMBERS/LETTERS/BOTH)--//
	@IBOutlet weak var keyTypeOutlet: UISegmentedControl!
	@IBAction func keyTypeAction(_ sender: Any) {
		switch keyTypeOutlet.selectedSegmentIndex {
		case 0:
			userType = 0
		case 1:
			userType = 1
		case 2:
			userType = 2
		default:
			userType = 2
		}
	}
	
//--Switch for user (CAPITAL/NO CAPITAL)--//
	@IBOutlet weak var isCapitalOutlet: UISwitch!
	@IBAction func isCapitalAction(_ sender: Any) {
		if isCapitalOutlet.isOn == true {
			userCapital = true
		}
		else {
			userCapital = false
		}
	}
	
//--Generate key button--//
	@IBOutlet weak var generateKeyButtonOutlet: UIButton!
	@IBAction func generateKeyButtonAction(_ sender: Any) {
		generateKey(keyLength: userLength, keyType: userType)
	}
	
//--View for key (CLICK TO COPY)--//
	@IBOutlet weak var textViewOutlet: UITextView!
	
	
	
	
	func generateKey(keyLength: Int, keyType: Int){
		//--Key Type Letters--//
		if keyType == 0 {
			letters = "0123456789"
			randomString(length: keyLength)
		}
		//--Key Type Number--//
		else if keyType == 1 {
			if userCapital == true {
				letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
			}
			else {
				letters = "abcdefghijklmnopqrstuvwxyz"
			}
			randomString(length: keyLength)
		}
		//--Key Type Both--//
		else {
			if userCapital == true {
				letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
			}
			else {
				letters = "abcdefghijklmnopqrstuvwxyz0123456789"
			}
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

