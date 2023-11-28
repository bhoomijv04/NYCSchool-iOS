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
            .padding([.leading, .trailing], 15)
        }
        .navigationTitle("home.title".localized)
    }
    
    private var SATscoreView: some View {
        HStack(alignment: .center,spacing: 5) {
            if let writing = viewModel.schoolModel.score?.sat_writing_avg_score {
                makeScoreView(title: "score.writing".localized, value: writing)
            }
            if let reading = viewModel.schoolModel.score?.sat_critical_reading_avg_score {
                makeScoreView(title: "score.reading".localized, value: reading)
            }
            if let maths = viewModel.schoolModel.score?.sat_math_avg_score {
                makeScoreView(title: "score.maths".localized, value: maths)
            }
            if let total = viewModel.getTotalScore() {
                makeScoreView(title: "score.total".localized, value: "\(total)")
            }
            
        }.padding([.top], 5)
    }
    
    @ViewBuilder func makeScoreView(title: String, value: String) -> some View {
        VStack(alignment: .center, spacing: Sizes.scoreVSpacing) {
            Text(value)
                .frame(width: Sizes.scoreSize, height: Sizes.scoreSize, alignment: .center)
                .padding()
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: Sizes.scorelineWidth)
                        .padding(6)
                )
            Text (title)
                .font(.footnote)
        }
    }
    
    private var opportunityView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\("school.acedemic.opportunities".localized):")
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
                Text("generic.noData.available".localized)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top], 5)
            }
        }
    }
    
    private var extraActitivyView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\("school.extra.activities".localized):")
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
            Text("\("school.eligibility.criteria".localized):")
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
                Text("generic.noData.available".localized)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top], 5)
            }
        }
    }
    
    private var satScoreContainerView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\("score.sat.score".localized):")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding([.top], 5)
            if (viewModel.schoolModel.score == nil) {
                Text("generic.noData.available".localized)
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
            Text("\("school.contactus".localized):")
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
                Label(number, systemImage: "phone")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let Fax = viewModel.schoolModel.school.fax_number {
                Label(Fax, systemImage: "faxmachine")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let email = viewModel.schoolModel.school.school_email {
                Label(email, systemImage: "envelope")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let website = viewModel.schoolModel.school.website {
                Label(website, systemImage: "globe")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct Sizes {
    static let scoreVSpacing: Double = 1.0
    static let scoreSize: Double = 40
    static let scorelineWidth: Double = 4
}
