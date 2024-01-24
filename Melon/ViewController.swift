//
//  ViewController.swift
//  Melon
//
//  Created by kibam kang on 11/13/23.
//
// kibam Kang
// kk33556 

import UIKit
import FirebaseAuth

class AlbumCell: UITableViewCell {
    @IBOutlet weak var albumPic: UIImageView!
    @IBOutlet weak var albumName: UILabel!
}

public let artistNames = ["Animal Collective", "Neutral Milk Hotel", "Danny Brown", "David Bowie", "Lucinda Williams", "Joy Division", "The Cure", "Daft Punk", "Pixies", "Nine Inch Nails", "White Stripes", "Elliot Smith", "Kendrick Lamar", "Lauryn Hill", "Sufjan Stevens", "Nas", "The Strokes", "Kate Bush", "Radiohead", "Led Zeppelin", "Beyonce", "The Clash", "My Bloody Valentine", "MF Doom", "Funkadelic", "Kanye West", "Vampire Weeknd", "Death Grips", "Mos Def", "Nirvana", "Radiohead", "Gorillaz", "Bjork", "Prince", "The Smiths" ,"Radiohead", "PJ Harvey", "Queen", "Prince", "Silver Jews", "Outkast", "N.W.A", "Kanye West", "Michael Jackson", "Weyes Blood", "Kendrick Lamar", "Tribed Called Quest", "Janet Jackson", "Wu Tang", "David Bowie"]

public let pictureID = ["AC", "aeroplane", "Atrocity", "BlackStar", "carwheel", "closer", "CureDisintegration",
    "discovery", "doolitle", "downwardspiral", "elephant", "elliotsmith", "GKMC", "Hill",
    "illinois", "illmatic", "isthisIt", "katebush", "kida", "ledzep4", "Lemonade",
    "londoncalling", "loveless", "madvillainy", "maggotbrain", "MBDTF", "ModernVamp",
    "MoneyStore", "mosdef", "nevermind", "okcomp", "PlasticBeach", "post", "Princepurplerain" ,"queenisdead", "rainbow", "Rid_of_Me", "sheerheartattack", "signofthetimes", "silverjew", "Stankonia", "StraightOuttaComptonN.W.A.", "TCD","thriller", "TitanticRising", "TPAB", "tribe", "velvetrope", "wutang", "ZiggyStardust"]

public let albumTitle = ["Merriweather Post Pavilion", "In the Aeroplane Over the Sea", " Atrocity Exhibition", "Black Star", "Car Wheel on A Gravel Road", "Closer", "Disintegration", "Discovery", "Doolittle", "The Downward Spiral", "Elephant", "Elliot Smith Self Title", "Good Kid Maad City", "The Miseducation of Lauryn Hill", "Illinois", "Illmatic", "Is This It", "Hounds of Love", "Kid A", "Led Zeppelin 4", "Lemonade", "London Calling", "Loveless", "MadVillainy", "Maggot Brain", "My Beautiful Dark Twisted Fantasy", "Modern Vampire of the City", "Money Store", "Black on Both Sides", "Nevermind", "Ok Computer", "Plastic Beach", "Post", "Purple Rain", "The Queen is Dead", "In Rainbows", "Rid of Me", "Sheer Heart Attack", "Sign of the Times", "American Water", "Stankonia", "Straight Outta Compton", "The College Dropout", "Thriller", "Titanic Rising", "To Pimp a Butterfly", "Low End Theory", "The Velvet Rope", "Enter the Wutang (36 Chambers)", "The Rise and Fall of Ziggy Stardust"]

public let dateOfRelease = ["2009", "1998", "2016", "2016", "1998", "1980", "1989", "2001", "1989", "1994", "2003", "1995", "2012", "1998", "2005", "1994", "2001", "1985", "2000", "1971", "2016", "1979", "1991", "2004", "1971", "2010", "2013", "2012", "1999", "1991", "1997", "2010", "1995", "1984", "1986", "2007",
    "1993", "1974", "1987", "1998", "2000", "1988", "2004", "1982", "2019", "2015", "1991", "1997", "1993",
    "1972"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var textCellIdentifier = "TextCell"
    var albumList: [Albums] = []
    var current = Albums()
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tableViewTop50: UITableView!
    @IBOutlet weak var segCtrl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "The Top 50 Albums of All Time"
        title = "Home Page"
        tableViewTop50.delegate = self
        tableViewTop50.dataSource = self
        header.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        header.layer.cornerRadius = 25.0
        header.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (dMode) {
            overrideUserInterfaceStyle = .dark
            tableViewTop50.backgroundView?.backgroundColor = .darkGray
        } else {
            overrideUserInterfaceStyle = .light
            tableViewTop50.backgroundView?.backgroundColor = .white
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! AlbumCell
        let row = indexPath.row
        cell.albumName.text = albumTitle[row]
        cell.albumPic.image = UIImage(named: pictureID[row])
        current.Artist = artistNames[row]
        current.Artist = albumTitle[row]
        return cell
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            break
        case 1:
            performSegue(withIdentifier: "ProfileSegue", sender: self)
            segCtrl.selectedSegmentIndex = 0
        default:
            print("error in onSegmentedChanged Home Page")
            segCtrl.selectedSegmentIndex = 0
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumPageSegue",
           let destination = segue.destination as? AlbumPageViewController,
           let teamIndex = tableViewTop50.indexPathForSelectedRow?.row
        {
            destination.albumName = albumTitle[teamIndex]
            destination.albumPic = UIImage(named: pictureID[teamIndex])
            destination.artistName = artistNames[teamIndex]
            destination.dateReleased = dateOfRelease[teamIndex]
            destination.curAlbum = current
        }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign out error")
        }
    }
}

