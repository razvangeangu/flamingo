//
//  ContentView.swift
//  Flamingo
//
//  Created by Răzvan-Gabriel Geangu on 16/10/2020.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State var totalBalance: Float = 12345.0
    
    var body: some View {
        return ARViewContainer(totalBalance: $totalBalance).edgesIgnoringSafeArea(.all).onTapGesture {
            print("Tap ...")
            self.totalBalance = Float.random(in: 999...4999)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var totalBalance: Binding<Float>!
    
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
        
        textModelComponent.mesh = .generateText("\(self.totalBalance!.wrappedValue)",
                                                extrusionDepth: 0,
                                                font: .systemFont(ofSize: 0.1),
                                                containerFrame: CGRect.zero,
                                                alignment: .center,
                                                lineBreakMode: .byCharWrapping)
        cardAnchor.totalBalanceLabel!.children[0].children[0].components.set(textModelComponent)
        
        return cardAnchor
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
