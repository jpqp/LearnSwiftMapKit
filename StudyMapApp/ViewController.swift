import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // ここでの挙動は、inputText.delegateに自分自身を設定する
        inputText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchKeyword = textField.text {
            print(searchKeyword)
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(
                searchKeyword,
                completionHandler: {
                    (placemarks: [CLPlacemark]?, error:Error?) in
                    if let placemark = placemarks?[0] {
                        if let targetCordinate = placemark.location?.coordinate {
                            print(targetCordinate)
                            
                            let pin = MKPointAnnotation()
                            pin.coordinate = targetCordinate
                            pin.title = searchKeyword
                            
                            self.displayMap.addAnnotation(pin)
                            self.displayMap.region = MKCoordinateRegionMakeWithDistance(
                                targetCordinate,
                                500.0,
                                500.0
                            )
                        }
                    }
            })
        }
        return true
    }
    
}

