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
                satScoreContainerView
                eligibilityView
                opportunityView
                extraActitivyView
                contactUSView
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
    
    private var opportunityView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Academic Opportunities:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding([.top], 5)
            if viewModel.schoolModel.school.acedemicOpportunities.count > 0 {
                ForEach(viewModel.schoolModel.school.acedemicOpportunities, id: \.self) { bulletPoint in
                    HStack(alignment: .top) {
                        Text(" •")
                        Text(bulletPoint)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Bullet Points")
                }
            } else {
                Text("No Data Available.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top], 5)
            }
        }
        .padding(.horizontal, 5)
    }
    
    private var extraActitivyView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Extracurricular Activities:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding([.top], 5)
            Text(viewModel.schoolModel.school.extracurricular_activities ?? "")
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var eligibilityView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Eligibility Criteria:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding([.top], 5)
            if viewModel.schoolModel.school.acedemicRequirnment.count > 0 {
                ForEach(viewModel.schoolModel.school.acedemicRequirnment, id: \.self) { bulletPoint in
                    HStack(alignment: .top) {
                        Text(" •")
                        Text(bulletPoint)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Bullet Points")
                }
            } else {
                Text("No Data Available.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top], 5)
            }
        }
        .padding(.horizontal, 5)
    }
    
    private var satScoreContainerView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("SAT Result:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding([.top], 5)
            if (viewModel.schoolModel.score == nil) {
                Text("No Data Available.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top], 5)
            } else {
                SATscoreView
            }
        }
    }
    
    private var contactUSView: some View {
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
            if let number = viewModel.schoolModel.school.phone_number {
                Text("Phone: \(number)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let Fax = viewModel.schoolModel.school.fax_number {
                Text("Fax: \(Fax)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let email = viewModel.schoolModel.school.school_email {
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let website = viewModel.schoolModel.school.website {
                Text(website)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
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
