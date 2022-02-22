//
//  Walktrought1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Walktrought1ViewController: DSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = WalktroughtData()
        
        let space = DSSpaceVM(type: .custom(50))
        
        // Page control
        let pageControl = DSPageControlVM(type: .pages(data.getFashionPages().walkthroughPages()))
                
        show(content: [[space, pageControl].list().zeroLeftRightInset()])
        showBottom(content: buttonsSection())
    }
}

// MARK: - Terms and Privacy Section

extension Walktrought1ViewController {
    
    func buttonsSection() -> DSSection {
        
        let getStarted = DSButtonVM(title: "Get Started") { (btn) in
            self.dismiss()
        }
        
        let logIn = DSButtonVM(title: "Log In", type: .cleanWithBorder) { (btn) in
            self.dismiss()
        }
        
        var text = DSActiveTextVM(.subheadline, text: "By signing up, you agree to our\nTerms and Privacy", alignment: .center)
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        return [getStarted, logIn, text].list()
    }
}

// MARK: - Data

fileprivate class WalktroughtData {
    
    func getFashionPages() -> [WalkthroughPage] {
        
        return [.simple(getDiscoverPage()),
                .simple(getFindPage()),
                .simple(getDifferencePage())]
    }
    
    func getDiscoverPage() -> WalkthroughSimplePage {
        
        let title = "Order Food Around You"
        let subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vitae tincidunt semper."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .center),
                                     image: (content: .image(image: UIImage.named("Wt1")), style: .circle, height: 200))
    }
    
    func getFindPage() -> WalkthroughSimplePage {
        
        let title = "Fast Delivery"
        let subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vitae tincidunt semper."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .center),
                                     image: (content: .image(image: UIImage.named("Wt2")), style: .themeCornerRadius, height: 200))
    }
    
    func getDifferencePage() -> WalkthroughSimplePage {
        
        let title = "Safe Delivery"
        let subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vitae tincidunt semper."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .center),
                                     image: (content: .image(image: UIImage.named("Wt3")), style: .themeCornerRadius, height: 200))
    }
}


public struct WalkthroughSimplePage {
    
    public init(text: (title: String, description: String, alignment: NSTextAlignment),
                image: (content: DSImageContent, style: DSImageDisplayStyle, height: CGFloat)) {
        
        self.text = text
        self.image = image
    }
    
    let text: (title: String, description: String, alignment: NSTextAlignment)
    let image: (content: DSImageContent, style: DSImageDisplayStyle, height: CGFloat)
}

extension WalkthroughSimplePage {
    
    func viewModel() -> DSPageVM {
        
        let appearance = DSAppearance.shared.main
        
        // Image
        let image = DSImageVM(imageValue: self.image.content,
                              height: .absolute(self.image.height),
                              displayStyle: self.image.style)
        
        // Compose text
        let composer = DSTextComposer(alignment: self.text.alignment)
        let spacing = appearance.interItemSpacing
        
        // Title
        composer.add(type: .headlineWithSize(25), text: self.text.title, spacing: spacing, maximumLineHeight: 34)
        
        // Description
        composer.add(type: .subheadline, text: self.text.description, spacing: spacing)
        
        // Space
        let space = DSSpaceVM()
        
        // Page with view models
        var page = DSPageVM(viewModels: [image, space, composer.textViewModel()])
        page.contentInsets = appearance.margins.edgeInsets
        page.style.displayStyle = .default
        page.height = .absolute(380)
        
        return page
    }
}

fileprivate enum WalkthroughPage {
    case simple(WalkthroughSimplePage)
}

fileprivate extension Array where Element == WalkthroughPage {
    
    func walkthroughPages() -> [DSPageVM] {
        
        self.map { (type) -> DSPageVM in
            switch type {
            case.simple(let page):
                return page.viewModel()
            }
        }
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Walktrought1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Walktrought1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
