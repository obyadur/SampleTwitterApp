//
//  TweetMapViewController.swift
//  TwitterApp
//
//  Created by Obyadur Rahman on 3/27/19.
//  Copyright © 2019 Sky Inc. All rights reserved.
//

import UIKit
import MapKit

class TweetMapViewController: UIViewController {

    @IBOutlet weak var tweetMapView: MKMapView!
    
    private var viewModel: TweetMapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localized.TweetMap.navigationTitle
        self.addSearchBarItem()
        
        viewModel = TweetMapViewModelImpl()
        tweetMapView.delegate = self

        LocationManager.shared.updatedLocation = { [weak self] (location) in
            self?.fetchTweets(location)
            LocationManager.shared.stopUpdating()
            self?.tweetMapView.region = MKCoordinateRegion(center: location,
                                                     latitudinalMeters: 6000.0,
                                                     longitudinalMeters: 6000.0)
        }
        LocationManager.shared.startUpdating()
    }
    
    
}

private extension TweetMapViewController {
    
    func fetchTweets(_ location: CLLocationCoordinate2D) {
        viewModel.fetchTweets(with: location) { [weak self] (success) in
            if success {
                self?.addAnnotations()
            } else {
                self?.presentAlert(withTitle: Localized.Network.errorTitle, message: Localized.Network.errorMessage.localized)
            }
        }
    }
    
    func addAnnotations() {
        for tweet in viewModel.tweets {
            let point = TweetAnnotation(tweet: tweet)
            self.tweetMapView.addAnnotation(point)
        }
    }
    
    func navigateToTweetDetails(_ tweet: LocationTweet) {
        if let detailsVC = TweetDetailsViewController.initController(tweet) {
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func addSearchBarItem() {
        let searchBarItem = UIBarButtonItem(title: Localized.TweetMap.navigationBarItemTitle, style: .plain, target: self, action: #selector(tapSearchTagBarItem))
        self.navigationItem.rightBarButtonItem  = searchBarItem
    }
    
    @objc func tapSearchTagBarItem() {
        if let searchVC = TweetTagSearchViewController.initController() {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}

extension TweetMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = self.tweetMapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil {
            annotationView = TweetAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "marker")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            // Don't proceed with custom callout
            return
        }
        
        let annotation = view.annotation as! TweetAnnotation
        let views = Bundle.main.loadNibNamed("TweetMapLayoutView", owner: nil, options: nil)
        let calloutView = views?[0] as! TweetMapLayoutView
        calloutView.config(annotation)
        calloutView.tapCompletion = { [weak self] in
            self?.navigateToTweetDetails(annotation.tweet)
        }
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: TweetAnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}
