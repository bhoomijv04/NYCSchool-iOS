//
//  HomeView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import SwiftUI

struct HomeView: View {
    
    private let viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text("home.title".localized)
    }
}

/*
 struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView()
     }
 }
 */
