import UIKit
import CoreLocation
import MapKit
import MessageUI

class ViewController: UIViewController {
    var locationManager:CLLocationManager  = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func shareLocation(_ sender: Any) {
        let objectsToShare:URL = URL(string: "https://maps.apple.com?ll=\(String(describing: locationManager.location!.coordinate.latitude)),\(String(describing: locationManager.location!.coordinate.longitude))")!
            let sharedObjects:[AnyObject] = [objectsToShare  as AnyObject]
           let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum:CLLocation = locations[locations.count - 1]
        let konum  = CLLocationCoordinate2D(latitude: sonKonum.coordinate.latitude, longitude: sonKonum.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapView.setRegion(bolge, animated: true)
        mapView.showsUserLocation = true
    }
}
