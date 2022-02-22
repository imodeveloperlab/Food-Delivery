//
//  FoodDeliveryRootViewController.swift
//  Demo FoodDelivery
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import UIKit

open class FoodDeliveryRootViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        DSAppearance.shared.main = OrangeAppearance()
        
        super.viewDidLoad()
        title = "Home"
        
        let home1 = DSActionVM(title: "Home") { [unowned self] action in
            self.present(vc: Home1ViewController(), presentationStyle: .fullScreen)
        }
            
        let categories1 = DSActionVM(title: "Categories") { [unowned self] action in
            self.push(Categories1ViewController())
        }
        
        let nearby1 = DSActionVM(title: "Nearby Restaurants") { [unowned self] action in
            self.push(NearbyRestaurant1ViewController())
        }
        
        let walktrought1 = DSActionVM(title: "Walktrought") { [unowned self] action in
            self.present(vc: Walktrought1ViewController(), presentationStyle: .overFullScreen)
        }
        
        let restaurant1 = DSActionVM(title: "Restaurant Details") { [unowned self] action in
            self.push(Restaurant1ViewController())
        }
        
        let restaurant2 = DSActionVM(title: "Restaurant Info") { [unowned self] action in
            self.push(Restaurant2ViewController())
        }
        
        let foodDetails = DSActionVM(title: "Food Details") { [unowned self] action in
            self.push(FoodDetails1ViewController())
        }
        
        let checkout = DSActionVM(title: "Checkout") { [unowned self] action in
            self.push(Checkout1ViewController())
        }
        
        let payment = DSActionVM(title: "Payment") { [unowned self] action in
            self.push(Payment1ViewController())
        }
        
        let addNewCard = DSActionVM(title: "Add New Card") { [unowned self] action in
            self.push(AddNewCard1ViewController())
        }
        
        let searchCountry = DSActionVM(title: "Search Country") { [unowned self] action in
            self.push(SearchCountry1ViewController())
        }
        
        let pickUpLocation = DSActionVM(title: "Pick Up Location") { [unowned self] action in
            self.push(PickUpLocation1ViewController())
        }
        
        let selectAddress = DSActionVM(title: "Select Address") { [unowned self] action in
            self.push(SearchAddress1ViewController())
        }
        
        let selectDeliveryTime = DSActionVM(title: "Select Delivery Time") { [unowned self] action in
            self.push(SelectDeliveryTimeViewController())
        }
        
        let logIn1 = DSActionVM(title: "Login 1") { [unowned self] action in
            self.present(vc: LogIn1ViewController(), presentationStyle: .fullScreen)
        }
        
        let logIn2 = DSActionVM(title: "Login 2") { [unowned self] action in
            self.present(vc: LogIn2ViewController(), presentationStyle: .fullScreen)
        }
        
        let logIn3 = DSActionVM(title: "Login 3") { [unowned self] action in
            self.present(vc: LogIn3ViewController(), presentationStyle: .fullScreen)
        }
        
        let logIn4 = DSActionVM(title: "Login 4") { [unowned self] action in
            self.present(vc: LogIn4ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp1 = DSActionVM(title: "Sign Up 1") { [unowned self] action in
            self.present(vc: SignUp1ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp2 = DSActionVM(title: "Sign Up 2") { [unowned self] action in
            self.present(vc: SignUp2ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp3 = DSActionVM(title: "Sign Up 3") { [unowned self] action in
            self.present(vc: SignUp3ViewController(), presentationStyle: .fullScreen)
        }
        
        let signUp4 = DSActionVM(title: "Sign Up 3") { [unowned self] action in
            self.present(vc: SignUp4ViewController(), presentationStyle: .fullScreen)
        }
        
        let notifications = DSActionVM(title: "Notifications") { [unowned self] action in
            self.present(vc: Notifications1ViewController(), presentationStyle: .fullScreen)
        }
        
        let profile1 = DSActionVM(title: "Profile 1") { [unowned self] action in
            self.push(Profile1ViewController())
        }
        
        let profile2 = DSActionVM(title: "Profile 2") { [unowned self] action in
            self.push(Profile2ViewController())
        }
        
        let profile3 = DSActionVM(title: "Profile 3") { [unowned self] action in
            self.push(Profile3ViewController())
        }
        
        let aboutUs = DSActionVM(title: "About Us") { [unowned self] action in
            self.push(AboutUs2ViewController())
        }
        
        let search = DSActionVM(title: "Search") { [unowned self] action in
            self.push(Search1ViewController())
        }
        
        let tracking = DSActionVM(title: "Tracking") { [unowned self] action in
            self.push(TrackingDetails1ViewController())
        }
        
        show(content: [walktrought1,
                       home1,
                       categories1,
                       nearby1,
                       restaurant1,
                       restaurant2,
                       foodDetails,
                       checkout,
                       pickUpLocation,
                       payment,
                       addNewCard,
                       searchCountry,
                       selectAddress,
                       selectDeliveryTime,
                       logIn1,
                       logIn2,
                       logIn3,
                       logIn4,
                       signUp1,
                       signUp2,
                       signUp3,
                       signUp4,
                       notifications,
                       profile1,
                       profile2,
                       profile3,
                       aboutUs,
                       search,
                       tracking])
        
        // Close
        let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action:  #selector(closeDemo))
        navigationItem.rightBarButtonItems = [close]
    }
    
    @objc func closeDemo() {
        self.dismiss()
    }
}
