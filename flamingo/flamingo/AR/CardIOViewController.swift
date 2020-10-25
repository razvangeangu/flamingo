//
//  CardNumberIdentifier.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import Foundation
import AVFoundation

protocol CardIOViewControllerDelegate {
    /// Called when a card information has been recognised.
    func cardIOView(didScanCard cardInfo: CardIOCreditCardInfo!) -> Void
}

class CardIOViewController: UIViewController, CardIOViewDelegate {
    public var delegate: CardIOViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.canReadCardWithCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CardIOUtilities.preloadCardIO()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cardIOView = CardIOView(frame: self.view.frame)
        cardIOView.delegate = self
        cardIOView.tag = 69
        self.view.addSubview(cardIOView)
    }
    
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        /// Once the card has been recognised, remove the scanner view
        if let viewWithTag = self.view.viewWithTag(69) {
            viewWithTag.removeFromSuperview()
        }
        
        /// Announce the delegate of recognition
        self.delegate.cardIOView(didScanCard: cardInfo)
    }
}
