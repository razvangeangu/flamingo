//
//  ARViewContainer.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewControllerRepresentable, CardIOViewControllerDelegate {
    @Binding var totalBalance: Float
    @State var cardNumber: String?
    var action: ((_ cardNumber: String) -> Void)?
    
    typealias UIViewControllerType = CardIOViewController
    
    func makeUIViewController(context: Context) -> CardIOViewController {
        let mainVC = CardIOViewController()
        mainVC.delegate = self
        mainVC.view.backgroundColor = .clear
        
        return mainVC
    }
    
    func updateUIViewController(_ uiViewController: CardIOViewController, context: Context) {
        if cardNumber != nil {
            let arView = ARView(frame: uiViewController.view.frame)
            arView.tag = 420
            arView.scene.anchors.append(makeBalanceLabel())
            uiViewController.view.addSubview(arView)
        }
        
        if let arView = uiViewController.view.viewWithTag(420) as? ARView {
            arView.scene.anchors.removeAll()
            arView.scene.anchors.append(makeBalanceLabel())
        }
    }
    
    func cardIOView(didScanCard cardInfo: CardIOCreditCardInfo!) {
        cardNumber = cardInfo.cardNumber
        if let action = action {
            action(cardNumber!)
        }
    }
    
    private func makeBalanceLabel() -> Experience.Card {
        let cardAnchor = try! Experience.loadCard()
        var textModelComponent: ModelComponent = cardAnchor.totalBalanceLabel!.children[0].children[0].components[ModelComponent] as! ModelComponent
        
        textModelComponent.mesh = .generateText("\(totalBalance)",
                                                extrusionDepth: 0,
                                                font: .systemFont(ofSize: 0.1),
                                                containerFrame: CGRect.zero,
                                                alignment: .center,
                                                lineBreakMode: .byCharWrapping)
        cardAnchor.totalBalanceLabel!.children[0].children[0].components.set(textModelComponent)
        
        return cardAnchor
    }
}

extension ARViewContainer {
    public func onCardInfoReceived(perform action: @escaping (_ cardNumber: String) -> Void ) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
