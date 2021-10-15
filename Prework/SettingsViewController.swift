//
//  SettingsViewController.swift
//  Prework
//
//  Created by Nhan Nguyen on 10/14/21.
//  Copyright © 2021 Nhan Nguyen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        darkModeSwitch.setOn(defaults.bool(forKey: "darkMode"), animated: true)
        setDarkMode()
    }
    @IBAction func toggleDarkMode(_ sender: Any) {
        defaults.set(darkModeSwitch.isOn, forKey: "darkMode")
        defaults.synchronize()
        setDarkMode()
    }
    
    func setDarkMode() {
        navigationController!.overrideUserInterfaceStyle = defaults.bool(forKey: "darkMode") ? .dark : .light
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
