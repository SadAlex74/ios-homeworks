//
//  ViewController.swift
//  location
//
//  Created by Александр Садыков on 08.12.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    @IBOutlet var userLocation: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        manager.delegate = self
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .realistic)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    @IBAction func changeUserLocationSwitch(_ sender: UISwitch) {
        if sender.isOn {
            manager.startUpdatingLocation()
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func actionOren(_ sender: Any) {
        addAnnotation(latitude: 51.7727, longitude: 55.0988, title: "Orenburg")
    }
    
    @objc private func longPress(_ gr: UIGestureRecognizer){
        let point = gr.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        addAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude, title: "Another point")
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        
        let direction = MKDirections(request: request)
        direction.calculate { [weak self] response, error in
            guard let unwrappedResponse = response else { return }
            if let route = unwrappedResponse.routes.first {
                self?.mapView.addOverlay(route.polyline)
                self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
        }
    }
        
    private func checkPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
        // MARK: ToDo Запрос доступа к локации
        }
    }
    
    private func addAnnotation(latitude: Double, longitude: Double, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude:  latitude, longitude: longitude)
        annotation.title = title
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.setCenter(coordinate, animated: true)
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .systemBlue
            render.lineWidth = 4
            return render
        }
        return MKOverlayRenderer()
    }
}
