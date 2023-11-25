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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(viewModel.schoolModel.school.school_name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .accessibilityAddTraits(.isHeader)
                    .padding([.top], 5)
                
                Text(viewModel.schoolModel.school.overview_paragraph ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let student = viewModel.schoolModel.school.total_students {
                    Text("Total Students: \(student)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding([.top], 5)
                }
                
                Text("SAT Result:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding([.top], 5)
                SATscoreView
                
                Text("Eligibility Criteria:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding([.top], 5)
                
                Text("Academic Opportunities:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding([.top], 5)
                
                if let activities = viewModel.schoolModel.school.extracurricular_activities {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Extracurricular Activities:")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding([.top], 5)
                        Text(activities)
                            .multilineTextAlignment(.leading)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Contact us:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding([.top], 5)
                    Text(viewModel.schoolModel.school.location ?? "")
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.schoolModel.school.borough ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.schoolModel.school.phone_number ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.schoolModel.school.phone_number ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.schoolModel.school.school_email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.schoolModel.school.website ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("home.title".localized)
    }
    
    private var SATscoreView: some View {
        HStack(alignment: .center,spacing: 5) {
            VStack(alignment: .center, spacing: Sizes.scoreVSpacing) {
                Text("125")
                    .frame(width: Sizes.scoreSize, height: Sizes.scoreSize, alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: Sizes.scorelineWidth)
                            .padding(6)
                    )
                Text ("Writing")
                    .font(.footnote)
            }
            VStack(alignment: .center, spacing: Sizes.scoreVSpacing) {
                Text("125")
                    .frame(width: Sizes.scoreSize, height: Sizes.scoreSize, alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: Sizes.scorelineWidth)
                            .padding(6)
                    )
                Text ("Reading")
                    .font(.footnote)
            }
            VStack(alignment: .center, spacing: Sizes.scoreVSpacing) {
                Text("125")
                    .frame(width: Sizes.scoreSize, height:Sizes.scoreSize, alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: Sizes.scorelineWidth)
                            .padding(6)
                    )
                Text ("Math")
                    .font(.footnote)
            }
            VStack(alignment: .center, spacing: Sizes.scoreVSpacing) {
                Text("125")
                    .frame(width: Sizes.scoreSize, height: Sizes.scoreSize, alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: Sizes.scorelineWidth)
                            .padding(6)
                    )
                Text ("No of Students")
                    .font(.footnote)
            }
        }
    }
}

struct Sizes {
    static let scoreVSpacing: Double = 1.0
    static let scoreSize: Double = 50
    static let scorelineWidth: Double = 4
}
/*
 struct SchoolDetailView_Previews: PreviewProvider {
     static var previews: some View {
         SchoolDetailView(viewModel: SchoolDetailViewModel(coordinator: SchoolDetailViewCoordinator(), schoolModel: <#HomeViewCellViewModel#>))
     }
 }*/
