//
//  ARViewContainer.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var totalBalance: Float
    
    func makeUIView(context: Context) -> ARView {
        let uiView = ARView(frame: .zero)
        
        uiView.scene.anchors.append(makeBalanceLabel())
        
        return uiView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()
        uiView.scene.anchors.append(makeBalanceLabel())
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
