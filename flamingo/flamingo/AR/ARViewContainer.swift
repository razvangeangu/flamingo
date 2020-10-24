//
//  ARViewContainer.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewControllerRepresentable {
    @Binding var totalBalance: Float
    
    typealias UIViewControllerType = CardIOViewController
    
    func makeUIViewController(context: Context) -> CardIOViewController {
        let mainVC = CardIOViewController()
        let arView = ARView(frame: mainVC.view.frame)
        arView.scene.anchors.append(makeBalanceLabel())
        
        mainVC.view.backgroundColor = .clear
//        mainVC.view.addSubview(arView)
        
        return mainVC
    }
    
    func updateUIViewController(_ uiViewController: CardIOViewController, context: Context) {
//        let arView = uiViewController.view.subviews[0] as! ARView
//        arView.scene.anchors.removeAll()
//        arView.scene.anchors.append(makeBalanceLabel())
    }
    
    private func makeBalanceLabel() -> Experience.Card {
        let cardAnchor = try! Experience.loadCard()
        var textModelComponent: ModelComponent = cardAnchor.totalBalanceLabel!.children[0].children[0].components[ModelComponent] as! ModelComponent
        
        textModelComponent.mesh = .generateText("\($totalBalance)",
                                                extrusionDepth: 0,
                                                font: .systemFont(ofSize: 0.1),
                                                containerFrame: CGRect.zero,
                                                alignment: .center,
                                                lineBreakMode: .byCharWrapping)
        cardAnchor.totalBalanceLabel!.children[0].children[0].components.set(textModelComponent)
        
        return cardAnchor
    }
}
