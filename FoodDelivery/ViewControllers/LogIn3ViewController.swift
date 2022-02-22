//
//  LogIn3ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit

open class LogIn3ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        showContent()
        showBottomContent()
    }
    
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        let composer = DSTextComposer(alignment: .center)
        
        composer.add(sfSymbol: "flame.fill",
                     style: .custom(size: 50, weight: .bold),
                     tint: .brand,
                     spacing: 50)
        
        composer.add(type: .body, text: "Welcome to Fresh, Hot and Delicious. 23 Dishes of Pizza, 5 Salads and 9 Snacks The BOXVegetarian dishes. Fast delivery. 9 Potatoes & Wings. Vegan dishes.", lineSpacing: 6)
        
        let text = composer.textViewModel()
        
        // Text section
        let section = [space1, text].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section)
    }
    
    func showBottomContent() {
        
        let socialNetworksLabel = DSLabelVM(.subheadline,
                                            text: "Login with social networks",
                                            alignment: .center)
        
        let emailLabel = DSLabelVM(.subheadline,
                                   text: "or sign up with Email",
                                   alignment: .center)
        
        // Facebook
        var facebook = DSButtonVM(title: "Facebook",
                                  icon: UIImage.named("facebook"),
                                  type: .facebook,
                                  textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        facebook.imagePosition = .rightMargin
        
        // Twitter
        var twitter = DSButtonVM(title: "Twitter",
                                 icon: UIImage.named("twitter"),
                                 type: .twitter,
                                 textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        twitter.imagePosition = .rightMargin
        
        // Sign up
        var signUpEmail = DSButtonVM(title: "Sign Up",
                                     icon: UIImage(systemName: "envelope.fill"),
                                     type: .secondaryView,
                                     textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        // Log in with email
        let logInWithEmail = DSButtonVM(title: "Log in with Email",
                                        type: .link,
                                        textAlignment: .center) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUpEmail.imagePosition = .rightMargin
        
        // Show bottom button
        showBottom(content: [[socialNetworksLabel].list(),
                             [facebook, twitter].grid().doubleMarginLeftRightInsets(),
                             [emailLabel].list(),
                             [signUpEmail].list().doubleMarginLeftRightInsets(),
                             [logInWithEmail].list()])
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn3ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn3ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
