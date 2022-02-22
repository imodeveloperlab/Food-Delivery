//
//  LogInViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit

open class LogIn2ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        let composer = DSTextComposer()
        composer.add(sfSymbol: "flame.fill", style: .custom(size: 50, weight: .bold), tint: .brand, spacing: 50)
        
        composer.add(type: .headlineWithSize(38), text: "Welcome to\nPizza Corso Restaurant")
        composer.add(type: .body, text: "An exciting place for the whole\nfamily to eat")
        let text = composer.textViewModel()
        
        // Text section
        let section = [space1, text].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section)
    }
    
    func showBottomContent() {
        
        // Bottom button
        let icon = UIImage(named: "facebook", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        
        var signUp = DSButtonVM(title: "Login with Facebook",
                                icon: icon,
                                type: .facebook,
                                textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUp.imagePosition = .rightMargin
        signUp.height = .absolute(50)
        let description = DSLabelVM(.subheadline, text: "Use Facebook to authenticate", alignment: .left)
        
        let section = [description, signUp].list().doubleMarginLeftRightInsets()
        
        // Show bottom button
        showBottom(content: section)
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn2ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
