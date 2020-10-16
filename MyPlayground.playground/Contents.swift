import PlaygroundSupport
import UIKit
import SceneKit

var x = 2456.34

let mytext1 = "Total Balance:"
let mytext2 = "£1,234.56"
let mytext3 = "This Month"
let incomeStr = "Income"
let outcomeStr = "Outcome"
let income = "£\(x)"
let outcome = "£345.67"

let scene = SCNScene()
let view = SCNView(frame: CGRect(x: 0, y: 0, width: 438, height: 375))

let text1 = SCNText(string: mytext1, extrusionDepth: 0)
let text2 = SCNText(string: mytext2, extrusionDepth: 0)
let text3 = SCNText(string: mytext3, extrusionDepth: 0)
let incText = SCNText(string: incomeStr, extrusionDepth: 0)
let outText = SCNText(string: outcomeStr, extrusionDepth: 0)
let incomeText = SCNText(string: income, extrusionDepth: 0)
let outcomeText = SCNText(string: outcome, extrusionDepth: 0)

text1.flatness = 1
text2.flatness = 1
text3.flatness = 0
incText.flatness = 0
outText.flatness = 0
incomeText.flatness = 0
outcomeText.flatness = 0
text1.font = UIFont(name: "Helvetica", size: 24)
text2.font = UIFont(name: "Helvetica", size: 36)
text3.font = UIFont(name: "Helvetica", size: 24)
incText.font = UIFont(name: "Helvetica", size: 18)
outText.font = UIFont(name: "Helvetica", size: 18)
incomeText.font = UIFont(name: "Helvetica", size: 24)
outcomeText.font = UIFont(name: "Helvetica", size: 24)

let textNode1 = SCNNode (geometry: text1)
let textNode2 = SCNNode (geometry: text2)
let textNode3 = SCNNode (geometry: text3)
let textNode4 = SCNNode (geometry: incText)
let textNode5 = SCNNode (geometry: outText)
let textNode6 = SCNNode(geometry: incomeText)
let textNode7 = SCNNode(geometry: outcomeText)

textNode1.position = SCNVector3 (0, 302, 0)
textNode2.position = SCNVector3(0, 260, 0)
textNode3.position = SCNVector3(0, 190, 0)
textNode4.position = SCNVector3(0, 155, 0)
textNode5.position = SCNVector3(120, 155, 0)
textNode6.position = SCNVector3(0, 127, 0)
textNode7.position = SCNVector3(120, 127, 0)

scene.rootNode.addChildNode(textNode1)
scene.rootNode.addChildNode(textNode2)
scene.rootNode.addChildNode(textNode3)
scene.rootNode.addChildNode(textNode4)
scene.rootNode.addChildNode(textNode5)
scene.rootNode.addChildNode(textNode6)
scene.rootNode.addChildNode(textNode7)

view.scene = scene
view.backgroundColor = UIColor.systemGray
view.preferredFramesPerSecond = 5
//view.rendersContinuously = true

PlaygroundPage.current.liveView = view
