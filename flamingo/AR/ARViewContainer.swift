//
//  ARViewContainer.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewControllerRepresentable, CardIOViewControllerDelegate {
    typealias UIViewControllerType = CardIOViewController
    
    /// Card number recognised by the CardIO API
    @State var cardNumber: String?

    // MARK: - Delegated action
    
    var onCardInfoReceivedAction: ((_ cardNumber: String) -> Void)?

    public func onCardInfoReceived(perform action: @escaping (_ cardNumber: String) -> Void ) -> Self {
        var this = self
        this.onCardInfoReceivedAction = action
        return this
    }
    
    // MARK: - Make view
    
    func makeUIViewController(context: Context) -> CardIOViewController {
        let mainVC = CardIOViewController()
        mainVC.delegate = self
        mainVC.view.backgroundColor = .clear
        
        // NOTE: to test only AR
        // self.initARView(mainVC)
        
        return mainVC
    }
    
    func updateUIViewController(_ uiViewController: CardIOViewController, context: Context) {
        if cardNumber != nil {
            self.initARView(uiViewController)
        }
        
        if let arView = uiViewController.view.viewWithTag(420) as? ARView {
            self.initTracking(in: arView)
        }
    }
    
    // MARK: - Make AR Experience
    
    private func initARView(_ uiViewController: CardIOViewController) {
        let arView = ARView(frame: uiViewController.view.frame)
        arView.tag = 420
        arView.session.delegate = arDelegate
        arDelegate.set(arView: arView)
        self.initTracking(in: arView)

        uiViewController.view.addSubview(arView)
    }
    
    func initTracking(in arView: ARView) {
        /// Update label values
        arDelegate.cardExperienceEntities[1].text = 10832.55.currencyFormat
        arDelegate.cardExperienceEntities[4].text = "+\(6232.currencyFormat)"
        arDelegate.cardExperienceEntities[6].text = "-\(3200.currencyFormat)"

        /// Clear scene
        arView.scene.anchors.removeAll()

        /// Dynamically load stored card images
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = loadDynamicImageReferences()
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - CardIO information handler
    
    func cardIOView(didScanCard cardInfo: CardIOCreditCardInfo!) {
        self.cardNumber = cardInfo.cardNumber
        saveImage(image: cardInfo.cardImage, name: cardInfo.cardNumber.final(characters: 8))
        if let onCardInfoReceivedAction = onCardInfoReceivedAction {
            onCardInfoReceivedAction(self.cardNumber!)
        }
    }
}
