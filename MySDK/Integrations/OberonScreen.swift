//
//  OberonScreen.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import UIKit

public protocol OberonScreenDelegate: AnyObject {
    func didSelectEnvironment(_ environment: EnvironmentMode)
}

public class OberonScreen: UIViewController {
    
    public var launchBundle: AnyClass?
    public var projectId: String = ""
    public weak var delegate: OberonScreenDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LogScope", "Запуск системы")
        if #available(iOS 13.0, *) {
            LogScope.shared.start(context: self, projectId: projectId)
        } else {
            // Handle older iOS versions
        }
        
        // Set up the UI
        setupUI()
    }
    
    func setupUI() {
        let idLabel = UILabel()
        if #available(iOS 13.0, *) {
            idLabel.text = LogScope.shared.deviceId.uuidString
        } else {
            idLabel.text = "Unsupported iOS version"
        }
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(idLabel)
        
        let devButton = UIButton(type: .system)
        devButton.setTitle("Development", for: .normal)
        devButton.translatesAutoresizingMaskIntoConstraints = false
        devButton.addTarget(self, action: #selector(switchToDevelopment), for: .touchUpInside)
        view.addSubview(devButton)
        
        let prodButton = UIButton(type: .system)
        prodButton.setTitle("Production", for: .normal)
        prodButton.translatesAutoresizingMaskIntoConstraints = false
        prodButton.addTarget(self, action: #selector(switchToProduction), for: .touchUpInside)
        view.addSubview(prodButton)
        
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            devButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            devButton.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            
            prodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            prodButton.topAnchor.constraint(equalTo: devButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func switchToDevelopment() {
        if #available(iOS 13.0, *) {
            LogScope.shared.mode = EnvironmentMode.development
        }
        delegate?.didSelectEnvironment(.development)
    }
    
    @objc func switchToProduction() {
        if #available(iOS 13.0, *) {
            LogScope.shared.mode = EnvironmentMode.production
        }
        delegate?.didSelectEnvironment(.production)
    }
    
    func switchMode() {
        guard let launchBundle = launchBundle else { return }
        let viewController = launchBundle.init() as! UIViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//import UIKit
//
//class OberonActivity: OberonScreen {
//    override func viewDidLoad() {
////        self.launchBundle = MainActivity.self
//        self.projectId = "1ac96c34-18ff-477a-88c5-77af95b30e68"
//
//        super.viewDidLoad()
//    }
//}
