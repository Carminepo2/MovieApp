//
//  SendMail2.swift
//  MoviesApp
//
//  Created by Luigi Pedata on 11/03/22.
//

import SwiftUI
import MessageUI

// Make your view controller conform to MFMailComposeViewControllerDelegate
class Foo: UIViewController, MFMailComposeViewControllerDelegate {

    func openEmail(_ emailAddress: String) {
        // If user has not setup any email account in the iOS Mail app
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            let url = URL(string: "mailto:" + emailAddress)
            UIApplication.shared.openURL(url!)
            return
        }

        // Use the iOS Mail app
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([emailAddress])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)

        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }

    // MARK: MailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}


struct SendMail2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SendMail2_Previews: PreviewProvider {
    static var previews: some View {
        SendMail2()
    }
}
