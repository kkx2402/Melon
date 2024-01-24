//
//  ProfileViewController.swift
//  Melon
// kibam Kang
// kk33556 

import UIKit
import AVFoundation

var dMode = false

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var saveProfileButton: UIButton!
    let picker = UIImagePickerController()
    var isDarkMode = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.green.cgColor
        self.profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        self.profileImage.clipsToBounds = true 
        // Do any additional setup after loading the view.
        picker.delegate = self
        profileButton.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        profileButton.layer.cornerRadius = 25.0
        profileButton.tintColor = UIColor.black
        saveProfileButton.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        saveProfileButton.layer.cornerRadius = 25.0
        saveProfileButton.tintColor = UIColor.black
        editProfileButton.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        editProfileButton.layer.cornerRadius = 25.0
        editProfileButton.tintColor = UIColor.black
        checkDarkMode()
        checkSaveProfile()
    }
    
    struct Keys {
        static let prefersDarkMode = "prefersDarkMode"
        static let userName = "userName"
        static let userAge = "userAge"
        static let userImage = "data"
    }
    
    @IBAction func segementedCtrlButtonChanged(_ sender: Any) {
        isDarkMode = segCtrl.selectedSegmentIndex == 1
        dMode = isDarkMode
        defaults.set(isDarkMode, forKey: Keys.prefersDarkMode)
        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = self.isDarkMode ? UIColor.darkGray : .white
        }
    }
    
    func checkDarkMode() {
        let prefersDarkMode = defaults.bool(forKey: Keys.prefersDarkMode)
        if (prefersDarkMode) {
            isDarkMode = true
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = self.isDarkMode ? UIColor.darkGray : .white
            }
            segCtrl.selectedSegmentIndex = 1
        }
    }
   
    func checkSaveProfile() {
        let name = defaults.value(forKey: Keys.userName) as? String ?? ""
        let age = defaults.value(forKey: Keys.userAge) as? String ?? ""
        nameField.text = name
        ageField.text = age
    }
    
    @IBAction func photoLibButtonPressed(_ sender: Any) {
        picker.allowsEditing = false
        //photo library may be depreciated, warning.
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // chose photo from Sys Library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = chosenImage
        dismiss(animated: true)
    }

    
    // cancel inside Library
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User cancelled selection")
        dismiss(animated: true)
    }
    

    @IBAction func cameraPressed(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            // Assume we have rear camera
            // Check permission to use camera
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                // ask user for access to cammera
                AVCaptureDevice.requestAccess(for: .video) {
                    (accessGranted) in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access was denied")
                break
            }
            // we have camera access
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true)
        } else {
            // No rear camera
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "this device no camera",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            present(alertVC, animated: true)
        }
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        let alert = UIAlertController(
            title: "Edit Profile",
            message: "Name and Age",
            preferredStyle: .alert
            )
        alert.addTextField() {
            (tfName) in tfName.placeholder = "Enter your Name"
        }
        alert.addTextField() {
            (tfAge) in tfAge.placeholder = "Enter your Age"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            (action) in self.nameField.text = alert.textFields![0].text
            self.ageField.text = alert.textFields![1].text
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func saveProfileChanges(_ sender: Any) {
        defaults.set(nameField.text!, forKey: Keys.userName)
        defaults.set(ageField.text!, forKey: Keys.userAge)
    }
}
