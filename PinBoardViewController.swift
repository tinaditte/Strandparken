//
//  PinBoardViewController.swift
//  Strandparken
//
//  Created by Tina Thomsen on 29/05/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import UIKit

class PinBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	@IBOutlet weak var board: UICollectionView!
	
	private var newPinMode = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		board.delegate = self
		board.dataSource = self
		PinHandler.ListenforPins(collectionView: board)
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "addPinSegue" {
			newPinMode = true
			if let destination = segue.destination as? PinDetailViewController{
				destination.behaveAsNew = newPinMode
			}
		}
		if segue.identifier == "viewPinSegue" {
			if let destination = segue.destination as? PinDetailViewController{
				destination.rowNumber = board.indexPathsForSelectedItems?.first?.item as! Int
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print(PinHandler.getSize())
		return PinHandler.getSize()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = board.dequeueReusableCell(withReuseIdentifier: "pinCell", for: indexPath as IndexPath) as! CollectionViewCell
		
		let getPinsUID = PinHandler.getPinAt(Index: indexPath.row).Uid
		let pinsUser  = UserHandler.getCurrentUserInfo(uid: getPinsUID)
		
		cell.headline.text = PinHandler.getPinAt(Index: indexPath.row).headline
		cell.body.text = PinHandler.getPinAt(Index: indexPath.row).description
		cell.nameLabel.text = pinsUser.name
		cell.datelabel.text = PinHandler.getPinAt(Index: indexPath.row).date
		
		print(cell)
		return cell
	}
	
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
		print("You selected cell #\(indexPath.item)!")
	}
	

}
