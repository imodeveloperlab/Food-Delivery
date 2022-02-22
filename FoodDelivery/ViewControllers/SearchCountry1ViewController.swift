//
//  SearchCountry1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class SearchCountry1ViewController: DSViewController {
    
    var searchText = ""
    
    var didSelectCountry: ((String) -> Void)?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Search Country"
        showTop(content: searchTextFieldSection())
        update()
    }
    
    func update() {
        show(content: countries())
    }
}

// MARK: - Search

extension SearchCountry1ViewController {
    
    func searchTextFieldSection() -> DSSection {
        
        let textField = DSTextFieldVM.search(placeholder: "Search")
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
        
        var countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        
        if searchText != "" {
            countryList = countryList.filter({ (country) -> Bool in
                country.lowercased().contains(searchText.lowercased())
            })
        }
        
        let models = countryList.map { (name) -> DSViewModel in
            
            var label = DSLabelVM(.headlineWithSize(15), text: name, alignment: .left)
            label.height = .absolute(30)
            
            // Handle did select country
            label.didTap { [unowned self] (_: DSLabelVM) in
                self.didSelectCountry?(name)
            }
            
            return label
        }
        
        if models.isEmpty {
            
           return getPlaceholderSection(image: UIImage(systemName: "magnifyingglass"), text: "Ups, there is not result for your search \(searchText)")
        }
        
        return models.list(separator: true)
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct SearchCountry1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SearchCountry1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
