//
//  SchoolDataModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 20/11/23.
//

import Foundation
import UIKit
import MapKit
import MessageUI

public final class HomeViewCellViewModel: ObservableObject {
    
    public var school: NYCSchool
    public var score: NYCSchoolScore?
    public var id: UUID
    
    public init(data: NYCSchool, score: NYCSchoolScore?, id: UUID = UUID()) {
        self.school = data
        self.id = id
        self.score = score
    }

    public func openURL(urlString: String?) {
        if let url = URL(string: urlString ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    public func callPhone(phone: String?) {
        let phoneNumber = "telprompt://".appending(phone ?? "")
        openURL(urlString: phoneNumber)
    }
    
    public func openMap(school: NYCSchool) {
        
        if let lat = school.latitude, let long = school.longitude {
            let latitude: CLLocationDegrees = lat
            let longitude: CLLocationDegrees = long
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = school.school_name.capitalized
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            // mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

           // present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
}

/*
extension HomeViewCellViewModel: MFMessageComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
 */

