//
//  UserViewModel.swift
//  MarketPlace
//
//  Created by dev on 07/03/2025.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var user: UserAPIResults?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var isLoggedin = false
    @Published var login = "admin@admin.com"
    @Published var password = "admin"
    @Published var isNameValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    
    private let apiService: APIServicesProtocol
    
    init (apiService: APIServicesProtocol) {
        self.apiService = apiService
    }
    
    func fetchUser() {
        apiService.fetchUser { (result) in
            switch result {
            case .success (let response):
                DispatchQueue.main.async {
                    self.user = response
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func validateName(name: String){
        guard name.count > 5 && name.count < 24 else {
            withAnimation{
                isNameValid = false
            }
            return
        }
        guard name.contains("@") else {
            withAnimation{
                isNameValid = false
            }
            return
        }
        withAnimation{
            isNameValid = true
        }
    }
    
    func validatePassword(name: String){
        guard name.count >= 5 && name.count < 24 else {
            withAnimation{
                isPasswordValid = false
            }
            return
        }
        withAnimation{
            isPasswordValid = true
        }
    }
}
