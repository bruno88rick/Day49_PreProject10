//
//  ValidatingFormData.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 17/05/24.
//

import SwiftUI

struct ValidatingFormData: View {
    @State private var userName = ""
    @State private var email = ""
    
    @State private var phoneNumber = ""
    @State private var password = ""
    
    var disabledForm: Bool {
        phoneNumber.count < 5 || password.isEmpty || password.count < 5
    }
    
    /*SwiftUI’s Form view lets us store user input in a really fast and convenient way, but sometimes it’s important to go a step further – to check that input to make sure it’s valid before we proceed.
    
    Well, we have a modifier just for that purpose: disabled(). This takes a condition to check, and if the condition is true then whatever it’s attached to won’t respond to user input – buttons can’t be tapped, sliders can’t be dragged, and so on. You can use simple properties here, but any condition will do: reading a computed property, calling a method, and so on,*/
    
    var body: some View {
        VStack {
            Form {
                Section ("Create Account with direct Disable") {
                    TextField("Enter the User name", text: $userName)
                    TextField("Enter the E-mail", text: $email)
                }
                
                Section {
                    Button("Create Account") {
                        print("Creating Account...")
                    }
                }
                //In this example, we don’t want users to create an account unless both fields have been filled in, so we can disable the form section containing the Create Account button by adding the disabled() modifier like this:
                .disabled(userName.isEmpty || email.isEmpty)
            }
            .padding()
            
            //You might find that it’s worth spinning out your conditions into a separate computed property, such as this:
            
            Form {
                Section ("Create Account with separated computated property applying to Disable") {
                    TextField("Enter the Phone Number", text: $phoneNumber)
                    TextField("Enter the password", text: $password)
                }
                
                Section {
                    Button("Create Account") {
                        print("Creating the account...")
                    }
                }
                .disabled(disabledForm)
            }
            .padding()
        }
    }
}

#Preview {
    ValidatingFormData()
}
