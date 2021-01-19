//
//  LoginView.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-26.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
            VStack(alignment: .leading) {
                Text("Username").font(.headline)
                TextField("Enter username", text: $viewModel.usernameEntered)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Password").font(.headline)
                SecureField("Enter password", text: $viewModel.passwordEntered)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text(viewModel.validationMessage)
                    .foregroundColor(.red)

                HStack {
                    /// Use Spacer to push content to right
                    Spacer()
                    Button("Login") {
                        viewModel.loginButtonTapped = true
                    }
                    .font(.system(size: 18, weight: .medium))
                    .disabled(!viewModel.loginButtonEnabled)

                }.padding(.top, 8.0)
            }
            .padding(EdgeInsets(top: 0, leading: 36, bottom: 64, trailing: 36))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
