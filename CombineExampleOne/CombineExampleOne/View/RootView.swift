//
//  RootView.swift
//  CombineExampleOne
//
//  Created by wuyach8 on 2020-11-26.
//

import SwiftUI

enum RootViewInput {
    case tappedAuthButton
    case tappedFeedbackListButton
    case tappedFeedbackFormButton
}

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel

    var body: some View {
        NavigationView {
            HStack {
                VStack() {
                    NavigationLink(
                        destination: FeedbackListView(),
                        isActive: $viewModel.shouldOpenFeedbackListView,
                        label: {
                            EmptyView()
                        })
                    NavigationLink(
                        destination: LoginView(viewModel: LoginViewModel()),
                        isActive: $viewModel.shouldOpenLoginView,
                        label: {
                            EmptyView()
                        })
                    NavigationLink(
                        destination: FeedbackFormView(),
                        isActive: $viewModel.shouldOpenFeedbackFormView,
                        label: {
                            EmptyView()
                        })

                    HStack {
                        Spacer()
                        Text($viewModel.authStatusText.wrappedValue)
                        Button($viewModel.authStatusButtonText.wrappedValue) {
                            viewModel.didTapAuthButton.send()
                            viewModel.authButtonBinding = ()
                            viewModel.input.send(.tappedAuthButton)
                        }
                    }

                    Spacer()

                    Button("Open Feedbacks") {
                        viewModel.didTapOpenFeedbackListButton.send()
                    }.font(.headline)
                    .padding(.top)

                    Button("Enter Feedback") {
                        viewModel.didTapEnterFeedbackFormButton.send()
                    }.font(.headline)
                    .padding(.top)

                    Spacer()
                }.padding()
                Spacer()
            }
            .navigationBarTitle("Feedback")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel(appState: AppState()))
    }
}


