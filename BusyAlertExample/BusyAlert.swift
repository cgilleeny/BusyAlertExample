//
//  BusyAlert.swift
//  AssetProSwift
//
//  Created by Caroline Gilleeny on 10/10/15.
//  Copyright © 2015 aValanche eVantage. All rights reserved.
//

import Foundation
import UIKit

protocol BusyAlertDelegate {
    
    func didCancelBusyAlert()
    
}


class BusyAlert {
    
    var busyAlertController: UIAlertController?
    var presentingViewController: UIViewController?
    var activityIndicator: UIActivityIndicatorView?
    var delegate:BusyAlertDelegate?
    
    init (title:String, message:String, presentingViewController: UIViewController) {
        busyAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        busyAlertController!.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Button"), style: UIAlertActionStyle.Cancel, handler:{(alert: UIAlertAction!) in
            delegate?.didCancelBusyAlert()
        }))
        self.presentingViewController = presentingViewController
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        busyAlertController!.view.addSubview(activityIndicator!)
    }
    
    func display() {
        dispatch_async(dispatch_get_main_queue(), {
            self.presentingViewController!.presentViewController(self.busyAlertController!, animated: true, completion: {
                self.activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
                self.activityIndicator!.startAnimating()
                
            })
        })

    }
    
    func dismiss() {
        dispatch_async(dispatch_get_main_queue(), {
            self.busyAlertController?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
}