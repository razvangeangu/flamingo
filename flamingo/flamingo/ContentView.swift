//
//  ContentView.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State var totalBalance: Float = 12345.0
    @State var password: String = ""
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(totalBalance: $totalBalance)
                .overlay(Blur())
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    print("Tap ...")
                    self.totalBalance = Float.random(in: 999...4999)
                }
            TextField("Mama", text: $password)
                .keyboardType(.numberPad)
                .border(Color.gray, width: 1)
        })
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
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
