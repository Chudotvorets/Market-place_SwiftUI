//
//  UserView.swift
//  MarketPlace
//
//  Created by dev on 26/03/2025.
//

import Foundation
import SwiftUI

struct LoginView: View {

    @EnvironmentObject var user: UserViewModel
    @State private var nameValid: Bool? = nil
    @State private var passwordValid: Bool? = nil
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            LoginLottieView()
        }
        
    }
}
struct LoginTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    var body: some View {
        HStack {
            TextField("Username",text: $name)
                .padding()
                .background(Color.background)
                .cornerRadius(16)
                .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }

}

struct PasswordTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    @Binding var showPassword: Bool
    var body: some View {
        Group{
            if !showPassword{
                HStack {
                    SecureField("Password",text: $name)
                        .padding()
                        .background(Color.background)
                        .cornerRadius(16)
                        .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action:{
                        withAnimation{
                            showPassword.toggle()
                        }
                    }){
                        Image(systemName: "eye")
                            .imageScale(.large)
                    }
                }
            } else {
                HStack {
                    LoginTextView(name: $name,isValid: $isValid)
                    Button(action:{showPassword.toggle()}){
                        Image(systemName: "eye.slash")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

extension Color {
    static let background: Color = Color("Background")
    static let secondaryBackground: Color = Color("SecondaryBackground")
    static let tertiary: Color = Color("tertiary")
    static let darkText: Color = Color("darkText")
    
    /// Change color of the border shadow depending on the user when he click sign in on LoginView
    /// - Parameter condition: an optional bool that will affect the color that is returned
    /// - Returns: a Color
    static func borderColor(condition: Bool?)-> Color{
        switch condition {
        case .some(true):
            return Color.green.opacity(0.8)
        case .some(false):
            return Color.red.opacity(0.8)
        case .none:
            return Color.darkText.opacity(0.2)
        }
    }
}
