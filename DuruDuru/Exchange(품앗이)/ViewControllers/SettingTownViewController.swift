//
//  SettingTownViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 2/4/25.
//

import UIKit
import MapKit
import CoreLocation

class SettingTownViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    private var settingTownView: SettingTownView!
    
    /// 초기위치(서울역) 위도, 경도 값
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.55545687279665, longitude: 126.97257243324101)
    let defaultSpanValue = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTownView = SettingTownView(frame: self.view.bounds)
        self.view = settingTownView
        
        settingTownView.map.setRegion(MKCoordinateRegion(center: defaultLocation, span: defaultSpanValue), animated: true) /// 지도의 초기 위치 설정
        
        locationManager.delegate = self /// CLLocationManager 설정
        locationManager.requestWhenInUseAuthorization() /// 위치 권한 요청
        locationManager.startUpdatingLocation() /// 위치 업데이트 시작
        
        settingTownView.map.showsUserLocation = true /// 유저의 현위치 보여주기
        settingTownView.map.setUserTrackingMode(.follow, animated: true) /// 유저의 현재 위치로 지도 이동
        
        setUpUIBar()
    }
    
    // MARK: - Functions
    
    func setUpUIBar() {
        
        /// 뒤로 가기 버튼
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = "동네 설정"
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 위치 업데이트 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // 역 지오코딩 수행
            geocoder.reverseGeocodeLocation(location) { placeMarks, error in
                guard let placeMarks = placeMarks, error == nil else {
                    print("주소를 찾을 수 없습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
                    return
                }
                
                var locationValue1: String = ""
                var locationValue2: String = ""
                
                for placeMark in placeMarks {
                    
                    // 시, 구, 동
                    if let locality = placeMark.locality, let subLocality = placeMark.subLocality, let administrativeArea = placeMark.administrativeArea {
                        // '시'로 끝나는 경우 제외
                        if !administrativeArea.hasSuffix("시") {
                            locationValue1 += "\(administrativeArea) \(locality) \(subLocality)" // 시
                        } else {
                            locationValue1 += "\(locality) \(subLocality)" // 시를 제외하고 추가
                        }
                    }
                    
                    // 도로명 및 상세 주소
                    if let thoroughfare = placeMark.thoroughfare, let subThoroughfare = placeMark.subThoroughfare {
                        locationValue2 = "\(thoroughfare) \(subThoroughfare)"
                    } else if let thoroughfare = placeMark.thoroughfare {
                        locationValue2 = "\(thoroughfare)"
                    }
                }
                
                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    self.settingTownView.locationValue1.text = locationValue1
                    self.settingTownView.locationValue2.text = locationValue2
                }
            }
        }
    }
    
    // 권한 요청 결과 처리
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("위치 권한이 거부되었습니다.")
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    // 위치 업데이트 실패 처리
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
    }
    
}
