//
//  HomeView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import SwiftUI
import Combine

public struct SchoolDetailView: View {
    
    private var viewModel: SchoolDetailViewModel
    
    public init(viewModel: SchoolDetailViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationView {
                Text("High schools")
                    .font(.system(.title, design: .default, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.center)
            }
            .navigationTitle("home.title".localized)
            .listStyle(.grouped)
        } else {
            // Fallback on earlier versions
        }
    }
}

 struct SchoolDetailView_Previews: PreviewProvider {
     static var previews: some View {
         SchoolDetailView(viewModel: SchoolDetailViewModel(coordinator: SchoolDetailViewCoordinator()))
     }
 }
