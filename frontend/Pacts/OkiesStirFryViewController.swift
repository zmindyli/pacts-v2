//
//  OkiesStirFryViewController.swift
//  Pacts
//
//  Created by Angela Chen on 8/29/20.
//  Copyright © 2020 Angela Chen. All rights reserved.
//

import UIKit
import SnapKit

class OkiesStirFryViewController: UIViewController {
   

    // header view
    var collectionView : UICollectionView!
    
    let padding : CGFloat = 8
    let okiesCellReuseIdentifier = "okiesCellReuseIdentifier"
    
    // categories
    var categories : [String]!
    // selected filters
    var selectedFilters : [String] = []

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let e1 = Event(name: "", type: [], time: "")
        let e2 = Event(name: "", type: [], time: "")
        let e3 = Event(name: "", type: [], time: "")
        var events = [e1, e2, e3]
        
        categories = ["outdoor", "indoor", "virtual"]

        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.itemSize = CGSize(width: 20, height: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(red: 13/255, green: 12/255, blue: 23/255, alpha: 1.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OkiesStirFryViewController.self, forCellWithReuseIdentifier: okiesCellReuseIdentifier)
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        view.addSubview(collectionView)
        
//        tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.backgroundColor = UIColor(red: 13/255, green: 12/255, blue: 23/255, alpha: 1.0)
//        tableView.register(SpotsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        view.addSubview(tableView)
//
//        gradient = UIImageView(image: UIImage(named: "Gradient"))
//        gradient.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(gradient)
        
        categories = ["Open", "Closed", "Quiet", "Collaborative", "North", "West", "Central"]
        
        setupConstraints()
        //getSpots()
        
        collectionView.reloadData()
        
        
    }
//
//    func convertSpot() {
//        for x in readSpotsX {
//            let newSpot = Spot(readInfo: x)
//            spots.append(newSpot)
//        }
//    }
//
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        collectionView.reloadData()

    }
    
    
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding * 13)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(6 * padding)
            
        }
        

    
//    func getSpots() {
//        NetworkManager.getBackendSpots { readSpots in
//            self.readSpotsX = readSpots
//
//            for x in self.readSpotsX {
//                let newSpot = Spot(readInfo: x)
//                self.spots.append(newSpot)
//            }
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }
//
//    }
//
//
//
//}


//extension OkiesStirFryViewController : UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categories.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: okiesCellReuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
//
//        cell.configure(for: categories[indexPath.row])
//        return cell
//    }
//
//}
//
//extension OkiesStirFryViewController : UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let height : CGFloat = 22
//        let width : CGFloat = (collectionView.frame.width - padding * 4) / 4
//
//        return CGSize(width: width, height: height)
//    }
//
//}

//extension OkiesStirFryViewController : UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //origin = false
//        let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
//        cell.clickConfigure(for: categories[indexPath.row])
//
//        let search = categories[indexPath.row]
//
//        var none = false
//        if(cell.isSelect) {
//
//            for s in spots {
//
//                if(s.tags.contains(search)) {
//                    s.tagsSelected += 1
//                    var flag = true
//                    for ss in selectedSpots {
//
//                        if (ss.equals(spot: s)) {
//                            flag = false
//                        }
//                    }
//
//                    if (flag) {
//                        selectedSpots.append(s)
//                    }
//                }
//                else {
//                    none = true
//                }
//
//            }
//
//        }
//        else {
//
//            if (selectedSpots.count == 0) {
//
//                for s2 in spots {
//
//                    if s2.tags.contains(search) {
//                        s2.tagsSelected -= 1
//                    }
//
//                }
//            }
//
//            var index = 0
//            while (index < selectedSpots.count) {
//                if(selectedSpots[index].tags.contains(search)) {
//                    selectedSpots[index].tagsSelected -= 1
//                }
//
//                if(selectedSpots[index].tags.contains(search) && selectedSpots[index].tagsSelected <= 0) {
//                    selectedSpots.remove(at: index)
//                    index -= 1
//                }
//
//                index += 1
//            }
//
//        }
//
//        var checker = true
//        for ss in selectedSpots {
//            if(ss.tagsSelected > 0) {
//                checker = false
//            }
//        }
//        if(checker && !none) {
//            origin = true
//        }
//        none = false
//        tableView.reloadData()
//    }
//}

//extension StudySpotsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(origin) {
//            return spots.count
//        }
//        else {
//            return selectedSpots.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SpotsTableViewCell
//        if(origin) {
//            cell.configure(for: spots[indexPath.row])
//        }
//        else {
//            cell.configure(for: selectedSpots[indexPath.row])
//        }
//
//        cell.selectionStyle = .none
//        return cell
//    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if(origin) {
//            theSpot.sharedSpot = spots[indexPath.row]
//        }
//        else {
//            theSpot.sharedSpot = selectedSpots[indexPath.row]
//        }
//
//        tabBarController?.selectedIndex = 1
//        tableView.reloadData()
//    }
    
    
     
//}
//
//extension StudySpotsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
//}

}
}
