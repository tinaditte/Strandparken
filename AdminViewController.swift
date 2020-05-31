//
//  AdminViewController.swift
//  Strandparken
//
//  Created by Tina Thomsen on 29/05/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
	@IBOutlet weak var containingView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let uid = UserHandler.getCurrentUID()
		print(uid)
		
		if UserHandler.value == 1{
			containingView.isHidden = false
		}else{
			containingView.isHidden = true
			Alert.Alerting(type: "Error", message: "Du har ikke admin rettigheder", vc: self)
			
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		UserHandler.getCurrentUserStatus()
		if UserHandler.value == 1{
			containingView.isHidden = false
		}
	}
	
}
