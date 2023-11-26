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
            switch viewModel.state {
            case .success:
                NYCSchoolList
            case .noContent:
                NYCLoadingView(isAnimating: true) {
                    $0.hidesWhenStopped = false
                }
            case .error:
                NYCErrorView(title:"generic.error.title".localized,
                             subTitle: "generic.error.description".localized,
                             retryBtnText: "generic.retry.title".localized) {
                    Task {
                        await viewModel.getNYCSchoolList()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("home.title".localized)
            }
        }
        .task {
            await viewModel.getNYCSchoolList()
        }
    }
    
    private var NYCSchoolList: some View {
        List {
            ForEach(viewModel.search(), id: \.id) { item in
                NavigationLink(destination: {
                    viewModel.coordinator.enqueueRoute(with: .goToDetailsView(viewModel: item), animated: true, completion: nil)
                }){
                    HomeViewCell(viewModel: item)
                }
            }
        }.searchable(text: $viewModel.searchString)
        .listStyle(.plain)
        .navigationTitle("home.title".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeViewCell: View {
    
    @ObservedObject private var viewModel: HomeViewCellViewModel
    
    init(viewModel: HomeViewCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(viewModel.school.school_name.capitalized)
                .foregroundColor(.primary)
                .font(.subheadline)
                .fontWeight(.semibold)
                .accessibilityAddTraits(.isHeader)
                .padding([.top], 5)
            Spacer(minLength: 0.1)
            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.school.location ?? " ")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .truncationMode(.tail)
                Text(viewModel.school.borough ?? " ")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                HStack(alignment: .center,spacing: 5) {
                    Button {
                        viewModel.openMap(school: viewModel.school)
                    } label: {
                        Image(systemName: "mappin").renderingMode(.template)
                    }
                    .frame(width: 50, height: 50)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    Button {
                        viewModel.callPhone(phone: viewModel.school.phone_number)
                    } label: {
                        Image(systemName: "phone").renderingMode(.template)
                    }
                    .frame(width: 50, height: 50)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    Button {
                        
                    } label: {
                        Image(systemName: "envelope").renderingMode(.template)
                    }
                    .frame(width: 50, height: 50)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    Button {
                        viewModel.openURL(urlString: viewModel.school.website)
                    } label: {
                        Image(systemName: "link").renderingMode(.template)
                    }
                    .frame(width: 50, height: 50)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
            }
            .background(.clear)
            Spacer()
        }
    }
}
