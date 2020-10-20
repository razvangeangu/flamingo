import UIKit
import PlaygroundSupport

class TextFieldViewController : UIViewController, UITextFieldDelegate {

    var label: UILabel!
    var textField: UITextField!
    var button: UIButton!

    override func viewDidLoad() {
        // UI

        let view = UIView()
        view.backgroundColor = .white
        
        button = UIButton(type: .system)
        button.setTitle("Run", for: .normal)
        button.tintColor = .blue
        button.addTarget(self,action: #selector(updateView), for: .touchUpInside)

        textField = UITextField()
        TypingDNARecorderMobile.addTarget(textField);
        
        textField.borderStyle = .roundedRect
        view.addSubview(textField)

        label = UILabel()
        view.addSubview(label)
        view.addSubview(button)

        self.view = view

        // Layout
        
        button.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            
            button.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            
            

        ])

        // Events

        textField.addTarget(self, action: #selector(updateLabel), for: UIControl.Event.editingChanged)

        updateLabel()
    }

    @objc func updateLabel() {
        self.label.text = textField.text!
    }
    
    @objc func updateView() {
        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, "Please", 0);
        print("Type 1: ", typingPattern);
    }

}

PlaygroundPage.current.liveView = TextFieldViewController()
