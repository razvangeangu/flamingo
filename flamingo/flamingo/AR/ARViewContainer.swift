//
//  ARViewContainer.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewControllerRepresentable, CardIOViewControllerDelegate {
    typealias UIViewControllerType = CardIOViewController

    /// Total balance of the card that will be displayed in the AR Experience
    @Binding var totalBalance: Float
    
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
        
        return mainVC
    }
    
    func updateUIViewController(_ uiViewController: CardIOViewController, context: Context) {
        if cardNumber != nil {
            self.initARView(uiViewController)
        }
        
        if let arView = uiViewController.view.viewWithTag(420) as? ARView {
            arView.scene.anchors.removeAll()
            arView.scene.anchors.append(makeExperienceAnchor())
        }
    }
    
    // MARK: - Make AR Experience
    
    private func initARView(_ uiViewController: CardIOViewController) {
        let arView = ARView(frame: uiViewController.view.frame)
        arView.tag = 420
        arView.scene.anchors.append(makeExperienceAnchor())
        uiViewController.view.addSubview(arView)
    }
    
    private func makeExperienceAnchor() -> Experience.Card {
        let cardAnchor = try! Experience.loadCard()
        initLabels(anchor: cardAnchor)
        
        return cardAnchor
    }
    
    // MARK: - CardIO information handler
    
    func cardIOView(didScanCard cardInfo: CardIOCreditCardInfo!) {
        cardNumber = cardInfo.cardNumber
        if let onCardInfoReceivedAction = onCardInfoReceivedAction {
            onCardInfoReceivedAction(cardNumber!)
        }
    }
}

// MARK: - Prepare Experience
extension ARViewContainer {
    private func initLabels(anchor: Experience.Card) {
        generateText(model: anchor.totalBalanceLabel, size: 0.5, text: "Total balance")
        generateText(model: anchor.totalBalanceValue, size: 1.2, text: totalBalance.currencyFormat)
        
        generateText(model: anchor.thisMonthLabel, size: 0.5, text: "This month")
        
        generateText(model: anchor.incomeLabel, size: 0.3, text: "Income")
        generateText(model: anchor.incomeValue, size: 0.5, text: "+\(Float(6232).currencyFormat)") // TODO: change constant income value to binding
        
        generateText(model: anchor.outcomeLabel, size: 0.3, text: "Outcome")
        generateText(model: anchor.outcomeValue, size: 0.5, text: "-\(Float(3200).currencyFormat)") // TODO: change constant outcome value to binding
    }
    
    private func generateText(model: Entity?, size: Float, text: String) {
        if let model = model {
            var textModelComponent: ModelComponent = model.children[0].children[0].components[ModelComponent] as! ModelComponent
            
            /// Setup material
            var material = UnlitMaterial()
            material.baseColor = MaterialColorParameter.color(.white)
            textModelComponent.materials = [material]
            
            /// Setup mesh
            textModelComponent.mesh = .generateText(text,
                                                    extrusionDepth: 0.000264,
                                                    font: .systemFont(ofSize: CGFloat(size / 100.0)),
                                                    containerFrame: CGRect.zero,
                                                    alignment: .center,
                                                    lineBreakMode: .byCharWrapping)
            
            /// Setup the model component
            model.children[0].children[0].components.set(textModelComponent)
        }
    }
}
