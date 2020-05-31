//
//  PinDetailViewController.swift
//  Strandparken
//
//  Created by Tina Thomsen on 31/05/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import UIKit

class PinDetailViewController: UIViewController {
	@IBOutlet weak var headlinetf: UITextField!
	@IBOutlet weak var bodyTV: UITextView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var AddressLabel: UILabel!
	@IBOutlet weak var DatoLabel: UILabel!
	
	var today = DateFormat.dateFormatter(Date: Date())
	var rowNumber = 0
	let uid = UserHandler.getCurrentUID()
	var behaveAsNew = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if behaveAsNew == false{
			showPin()
			if isAuthor() == true{
				headlinetf.isUserInteractionEnabled = true
				bodyTV.isEditable = true
			}
		}else if behaveAsNew == true{
			
			headlinetf.isUserInteractionEnabled = true
			bodyTV.isEditable = true
			nameLabel.text = UserHandler.getCurrentUserInfo(uid: uid).name
			AddressLabel.text = UserHandler.getCurrentUserInfo(uid: uid).address
			DatoLabel.text = today
		}
		
    }
	
	@IBAction func savePin(_ sender: Any) {
		let userupdate = UserHandler.getCurrentUserInfo(uid: uid)
		
		if behaveAsNew == true{
			PinHandler.CreatePin(headline: headlinetf.text!, descript: bodyTV.text!, date: today, userID: uid)
			Alert.Alerting(type: "Info", message: "Opslaget blev slået op.", vc: self)
		}else{
			PinHandler.UpdatePin(index: rowNumber, headline: headlinetf.text!, description: bodyTV.text!, date: today, uid: userupdate.uid)
			Alert.Alerting(type: "Info", message: "Opslaget blev opdateret.", vc: self)
		}
	}
	
	func showPin(){
		let pin = PinHandler.getPinAt(Index: rowNumber)
		let pinID = pin.id
		let headline = pin.headline
		let description = pin.description
		let date = pin.date
		let pinsuser = pin.Uid
		
		let userinfo = UserHandler.getCurrentUserInfo(uid: pinsuser)
		
		userinfo.name = nameLabel.text!
		userinfo.address = AddressLabel.text!
		pin.date = DatoLabel.text!
	}
	
	func getPinsUID()->String{
		let pin = PinHandler.getPinAt(Index: rowNumber)
		let pinsUID = pin.Uid
		
		return pinsUID
	}
	
	func isAuthor()-> Bool{
		let author = uid
		let pinuid = getPinsUID()
		
		if author == pinuid{
			return true
		}
		return false
	}
}
