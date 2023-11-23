//
//  HomeView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import SwiftUI
import Combine

public struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schools, id: \.school.id) { item in
                    NavigationLink(destination: {
                        viewModel.coordinator.enqueueRoute(with: .goToDetailsView(viewModel: item.school), animated: true, completion: nil)
                    }){
                        HomeViewCell(viewModel: item)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("home.title".localized)
            .listStyle(.plain)
        }
        
    }
}

 struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView(viewModel: HomeViewModel(coordinator: HomeViewCoordinator()))
     }
 }

struct HomeViewCell: View {
    
    @ObservedObject private var viewModel: HomeViewCellViewModel
    
    init(viewModel: HomeViewCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(viewModel.school.name.capitalized)
                .foregroundColor(.primary)
                .font(.subheadline)
            HStack(alignment: .center, spacing: 3) {
                Label(viewModel.school.dbn, systemImage: "phone")
            }
        }
    }
}
