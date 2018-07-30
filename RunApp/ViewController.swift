//
//  ViewController.swift
//  RunApp
//
//  Created by Evgen Patlay on 22.11.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import RealmSwift


class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var temp = 0
    var firstPoint = true
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    let path = GMSMutablePath()
    var previousCoorddinate = CLLocation(latitude: 5.0, longitude: 5.0)
    var distance: Double = 0.0
    var isRun = false

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var disnanceLabel: UILabel!
    @IBOutlet weak var spedLabel: UILabel!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var totalSec: Float = 0
    var timer = Timer()
    var runHistory = [Run]()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 2
        locationManager.allowsBackgroundLocationUpdates = true
        // Do any additional setup after loading the view, typically from a nib.
    }

 


    @IBAction func clickStart(_ sender: UIButton) {
        print("test")
        isRun = true
        self.startButton.isEnabled = false
        self.pauseButton.isEnabled = true
        self.stopButton.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)


        
    }

    @IBAction func clickPause(_ sender: UIButton) {
        timer.invalidate()
        self.startButton.isEnabled = true
        self.pauseButton.isEnabled = false
        isRun = false
    }

    @IBAction func clickStop(_ sender: UIButton) {
        isRun = false
       timer.invalidate()
        self.stopButton.isEnabled = false
        self.startButton.isEnabled = true
        let timeText = totalSec.timeRepresentation()
        let speedMidle = distance / Double((totalSec*3600000))
        print(speedMidle)
        let runDate = NSDate()
        print(runDate)
        let newRun = Run(time:timeText, distance: distance, speed: speedMidle, date: runDate)
        print(newRun)
        let newRealmRun = RealmRun(distance: distance, time: timeText, speed: speedMidle, date: runDate)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newRealmRun)
            }

        }catch{
            print(error.localizedDescription)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "realm file doesn't exist")
        runHistory.append(newRun)
        RunData.shared.runs.append(newRun)
        print(RunData.shared.runs)
        totalSec = 0
        distance = 0
    }

    @objc func updateTimerLabel()  {

//            let minutes = Int(watch.elapsdTime / 60)
//            let seconds = Int(watch.elapsdTime) % 60
//            let tenOfSeconds = Int(watch.elapsdTime*10) % 10
//            timerLabel.text = "\(minutes):\(seconds):\(tenOfSeconds)"
       /* var backgoundTask = UIApplication.shared.beginBackgroundTask{
            self.totalSec += 0.11
        }
        if backgoundTask != UIBackgroundTaskInvalid {
            if UIApplication.shared.applicationState == .active {
                UIApplication.shared.endBackgroundTask(backgoundTask)
                backgoundTask = UIBackgroundTaskInvalid
            }
        }
*/

        totalSec += 0.1
        let string = totalSec.timeRepresentation()

        timerLabel.text = string

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("TEST TeSET")
        let location = locations[0]


        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16.0)
        print(camera)

        if (temp == 0){

            let frame = CGRect(x : 25, y: view.frame.height/2+20, width: view.frame.width - 50, height:view.frame.height-350 )
            mapView = GMSMapView.map(withFrame: frame, camera: camera)
            view.addSubview(mapView)
            mapView.isMyLocationEnabled = true

        }

      self.mapView.animate(to: camera)

        temp+=1
    

        if (isRun){
            print("loc1 \(location)")

            path.add(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            let polyline = GMSPolyline(path: path)
            polyline.geodesic = true
            polyline.strokeWidth = 4
            polyline.map = mapView

            let distanceInMeters = location.distance(from: previousCoorddinate)
            distance += distanceInMeters
            let speed = location.speed / 1000 * 3600
            self.spedLabel.text = String(format: "%.1f km/h", speed)
            self.disnanceLabel.text = String(format: "%.0f m", distance)
            //print("DISTANCE \(distance) meters")

        }
        previousCoorddinate = location
        // print("loc2 \(previousCoorddinate)")
        //  print("SPEED  \(location.speed)")
    }

}


