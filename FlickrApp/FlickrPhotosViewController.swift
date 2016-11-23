//
//  FlickrPhotosViewController.swift
//  FlickrApp
//
//  Created by sharon mcdermott on 11/23/16.
//  Copyright © 2016 sharon mcdermott. All rights reserved.
//

import UIKit

final class FlickrPhotosViewController: UICollectionViewController {
    // MARK: - Properties
    fileprivate let reuseidentifier = "FlickrCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    fileprivate var searches = [FlickrSearchResults]()
    fileprivate let flickr = Flickr()
    
}

// MARK: = Private
private extension FlickrPhotosViewController {
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
    }
}


extension FlickrPhotosViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text!) {
            results, error in
            
            activityIndicator.removeFromSuperview()
            
            if let error = error {
                // 2
                print("Error searching: \(error)")
                return
        }
            
            if let results = results {
                // 3
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.insert(results, at: 0)
                
                // 4
                self.collectionView?.reloadData()
                
                }
            }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
        
    }
}
