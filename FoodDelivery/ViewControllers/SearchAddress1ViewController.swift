//
//  SearchAddress1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class SearchAddress1ViewController: DSViewController {
    
    var searchText = ""
    
    var didSelectAddress: ((String) -> Void)?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Recipient Address"
        showTop(content: searchTextFieldSection())
        update()
    }
    
    func update() {
        show(content: userLocation(), countries())
    }
}

// MARK: - Search

extension SearchAddress1ViewController {
    
    func userLocation() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: "Use user location")
        var action = composer.actionViewModel()
        action.leftIcon(sfSymbolName: "smallcircle.fill.circle", tintColor: .custom(UIColor(0x00BAE9)))
        
        return action.list()
    }
    
    func searchTextFieldSection() -> DSSection {
        
        let textField = DSTextFieldVM.search(placeholder: "Search location")
        textField.handleValidation = { text in
            return true
        }
        
        textField.didUpdate = { tf in
            self.searchText = tf.text ?? ""
            self.update()
        }
        
        return textField.list()
    }
    
    func countries() -> DSSection {
        
        let faker = DSFaker()
        
        var addresses = faker.addresses
       
        if searchText != "" {
            addresses = addresses.filter({ (address) -> Bool in
                address.address.lowercased().contains(searchText.lowercased())
            })
        }
        
        let models = addresses.map { (address) -> DSViewModel in
            
            let composer = DSTextComposer()
            composer.add(type: .headlineWithSize(14), text: address.title)
            composer.add(type: .subheadline, text: address.address)
            
            var action = composer.actionViewModel()
            action.height = .absolute(45)
            action.leftIcon(sfSymbolName: "mappin.circle", size: .init(width: 20, height: 20))
            
            action.style.displayStyle = .default
            
            action.didTap = { (_:DSViewModel) in
                self.didSelectAddress?(address.address)
            }
            
            return action
        }
        
        if models.isEmpty {
            
           return getPlaceholderSection(image: UIImage(systemName: "magnifyingglass"), text: "Ups, there is not result for your search \(searchText)")
        }
        
        return models.list(separator: true)
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct SearchAddress1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SearchAddress1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
