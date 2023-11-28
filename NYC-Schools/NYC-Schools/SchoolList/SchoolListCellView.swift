//
//  SchoolListCellView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 28/11/23.
//

import Foundation
import SwiftUI

public struct SchoolListViewCell: View {
    
    @ObservedObject private var viewModel: SchoolListCellViewModel
    
    init(viewModel: SchoolListCellViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
