//
//  AlbumPageViewController.swift
//  Melon
// kibam Kang
// kk33556 

import UIKit

class AlbumPageViewController: UIViewController {

    var albumPic: UIImage!
    var albumName: String!
    var artistName: String!
    var userRating: Int!
    var dateReleased: String! 
    var alreadyRated: Bool!
    var curAlbum: Albums!

    @IBOutlet weak var buttonField: UIButton!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var albumNameField: UILabel!
    @IBOutlet weak var artistNameField: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Album"
        // Do any additional setup after loading the view.
        albumImage.image = albumPic
        albumNameField.text = "Album: " + albumName
        artistNameField.text = "Artist: " + artistName
        dateField.text = "Year: " + dateReleased
        buttonField.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        buttonField.layer.cornerRadius = 25.0
        buttonField.tintColor = UIColor.green
        self.albumNameField.layer.borderWidth = 3
        self.albumNameField.layer.borderColor = UIColor.green.cgColor
        self.artistNameField.layer.borderWidth = 3
        self.artistNameField.layer.borderColor = UIColor.green.cgColor
        self.dateField.layer.borderWidth = 3
        self.dateField.layer.borderColor = UIColor.green.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (dMode) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    
    @IBAction func buttonPressedRating(_ sender: Any) {
        self.userRating = 0
        let rController = UIAlertController(
            title: "Rate this Album",
            message: "1 to 10:",
            preferredStyle: .actionSheet)
        rController.addAction(UIAlertAction(title: "1", style: .default, handler: {
            (action) in self.userRating = 1
        }))
        rController.addAction(UIAlertAction(title: "2", style: .default, handler: {
            (action) in self.userRating = 2
        }))
        rController.addAction(UIAlertAction(title: "3", style: .default, handler: {
            (action) in self.userRating = 3
        }))
        rController.addAction(UIAlertAction(title: "4", style: .default, handler: {
            (action) in self.userRating = 4
        }))
        rController.addAction(UIAlertAction(title: "5", style: .default, handler: {
            (action) in self.userRating = 5
        }))
        rController.addAction(UIAlertAction(title: "6", style: .default, handler: {
            (action) in self.userRating = 6
        }))
        rController.addAction(UIAlertAction(title: "7", style: .default, handler: {
            (action) in self.userRating = 7
        }))
        rController.addAction(UIAlertAction(title: "8", style: .default, handler: {
            (action) in self.userRating = 8
        }))
        rController.addAction(UIAlertAction(title: "9", style: .default, handler: {
            (action) in self.userRating = 9
        }))
        rController.addAction(UIAlertAction(title: "10", style: .default, handler: {
            (action) in self.userRating = 10
        }))
        present(rController, animated: true)
    }
}
