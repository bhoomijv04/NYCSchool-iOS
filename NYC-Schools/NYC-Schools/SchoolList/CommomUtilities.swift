//
//  CommomUtilities.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 26/11/23.
//

import Foundation
import UIKit
import MapKit
import MessageUI
import SwiftUI

// MARK: Service class for School API
public protocol CommanUtilitiesProtocol {
    func openURL(urlString: String)
    func callPhone(phone: String)
    func openMap(school: NYCSchool)
    func sendEmail(root: UINavigationController?)
}

public final class CommanUtilities: NSObject, MFMailComposeViewControllerDelegate {

    static let shared = CommanUtilities()

}

extension CommanUtilities: CommanUtilitiesProtocol {
    
    public func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }

    public func callPhone(phone: String) {
        let phoneNumber = "telprompt://".appending(phone)
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

    public  func sendEmail(root: UINavigationController?) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            root?.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
}




extension CommanUtilities: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}

