//
//  ARViewSessionDelegate.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 25/10/2020.
//

import Foundation
import ARKit
import RealityKit

let arDelegate = ARViewSessionDelegate()

final class ARViewSessionDelegate: NSObject, ARSessionDelegate {
    var arView: ARView!
    
    func set(arView: ARView) {
        self.arView = arView
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        anchors.compactMap { $0 as? ARImageAnchor }.forEach {
            let anchorEntity = AnchorEntity(anchor: $0)
            self.initCardExperience(on: anchorEntity, relativeTo: $0.referenceImage.physicalSize)
            
            self.arView.scene.addAnchor(anchorEntity)
            
        }
    }
    
    private func initCardExperience(on anchor: AnchorEntity, relativeTo size: CGSize) {
        cardExperienceEntities.forEach { (cardEntity) in
            let mesh: MeshResource = .generateText(cardEntity.text,
                                                   extrusionDepth: 0.000264,
                                                   font: .systemFont(ofSize: cardEntity.size),
                                                   containerFrame: CGRect.zero,
                                                   alignment: .left,
                                                   lineBreakMode: .byCharWrapping)
            let material = SimpleMaterial(color: .white, isMetallic: true)
            let entity = ModelEntity(mesh: mesh, materials: [material])
            entity.transform.rotation = simd_quatf(angle: -.pi / 2, axis: simd_float3(x: 1, y: 0, z: 0))
            entity.transform.translation = simd_float3(
                x: Float(size.width) / 1.75 + cardEntity.translation.x,
                y: cardEntity.translation.y,
                z: -Float(size.height) / 2.0 + cardEntity.translation.z
            )
            
            anchor.addChild(entity)
        }
    }
    
    /// `1` is totalBalanceValue; `4` is income; `6` is outcome
    public var cardExperienceEntities: [CardExperienceEntity] = [
        CardExperienceEntity(
            text: "Total balance",
            size: 0.005,
            translation: simd_float3(x: 0, y: 0, z: 0)
        ),
        CardExperienceEntity(
            text: 0000.currencyFormat,
            size: 0.012,
            translation: simd_float3(x: 0, y: 0, z: 0.015)
        ),
        CardExperienceEntity(
            text: "This month",
            size: 0.005,
            translation: simd_float3(x: 0, y: 0, z: 0.03)
        ),
        CardExperienceEntity(
            text: "Income",
            size: 0.003,
            translation: simd_float3(x: 0, y: 0, z: 0.04)
        ),
        CardExperienceEntity(
            text: "+\(0000.currencyFormat)",
            size: 0.005,
            translation: simd_float3(x: 0, y: 0, z: 0.047)
        ),
        CardExperienceEntity(
            text: "Outcome",
            size: 0.003,
            translation: simd_float3(x: 0.03, y: 0, z: 0.04)
        ),
        CardExperienceEntity(
            text: "-\(0000.currencyFormat)",
            size: 0.005,
            translation: simd_float3(x: 0.03, y: 0, z: 0.047)
        ),
    ]
}

struct CardExperienceEntity {
    var text: String
    var size: CGFloat
    var translation: SIMD3<Float>
}
