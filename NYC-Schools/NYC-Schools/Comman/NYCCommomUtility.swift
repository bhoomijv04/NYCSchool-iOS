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
    func openMap(lat: Double, long: Double, name: String)
    func sendEmail(recipient: String, root: UIViewController?)
}

public final class NYCCommomUtility: NSObject, MFMailComposeViewControllerDelegate {

    static let shared = NYCCommomUtility()

}

extension NYCCommomUtility: CommanUtilitiesProtocol {
    
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
    
    public func openMap(lat: Double, long: Double, name: String){
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
        mapItem.name = name.capitalized
        mapItem.openInMaps(launchOptions: options)
    }

    public  func sendEmail(recipient: String, root: UIViewController?) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient])
            root?.present(mail, animated: true)
        } else {
            showOKAlert(title: "home.title".localized, description: "general.email.error".localized, root: root)
        }
    }
    
    func showOKAlert(title: String, description: String, root: UIViewController?) {
        let alert = UIAlertController(title: "home.title".localized, message: "general.email.error".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        root?.present(alert, animated: true, completion: nil)
    }
}


extension NYCCommomUtility: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}

