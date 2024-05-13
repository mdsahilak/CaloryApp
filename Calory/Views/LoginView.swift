//
//  LoginView.swift
//  Calory
//
//  Created by Muhammad Ali on 13/05/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistered = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 30)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    // Perform login action here
                    // For demonstration, let's just navigate to home view
                    isRegistered = true
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top, 30)
                
                NavigationLink(destination: SignupView(), label: {
                    Text("Don't have an account? Register")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                })
                
                Spacer()
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isRegistered,
                    label: { EmptyView() }
                ).hidden()
            )
            .navigationViewStyle(StackNavigationViewStyle()) // Prevent stacking of "Back" buttons
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
