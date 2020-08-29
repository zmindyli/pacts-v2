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
    let categoriesCellReuseIdentifier = "categoriesCellReuseIdentifier"
    
    // categories
    var categories : [String]!
    // selected filters
    var selectedFilters : [String] = []
    
    // title
    var viewTitle : UILabel!
    
    // table view for study spots
    var tableView : UITableView!
    let reuseIdentifier = "spotsCellReuse"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spot1 = Spot(name: "Carrot1", isFav: false, tags: ["Open","North"], numberFavorited: 0, openClosed: false, resources: [], hours: [])
        let spot2 = Spot(name: "Carrot2", isFav: false, tags: ["Closed","West"], numberFavorited: 0, openClosed: false, resources: [], hours: [])
        let spot3 = Spot(name: "Carrot3", isFav: false)
        var spots = []
        
        view.backgroundColor = UIColor(red: 13/255, green: 12/255, blue: 23/255, alpha: 1.0)
        
        viewTitle = UILabel()
        viewTitle.textAlignment = .center
        viewTitle.textColor = UIColor(red: 209/255, green: 211/255, blue: 217/255, alpha: 1.0)
        viewTitle.text = "Study Spots"
        viewTitle.font = UIFont.boldSystemFont(ofSize: 32.0)
        view.addSubview(viewTitle)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.itemSize = CGSize(width: 20, height: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(red: 13/255, green: 12/255, blue: 23/255, alpha: 1.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: categoriesCellReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        view.addSubview(collectionView)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 13/255, green: 12/255, blue: 23/255, alpha: 1.0)
        tableView.register(SpotsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        gradient = UIImageView(image: UIImage(named: "Gradient"))
        gradient.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradient)
        
        categories = ["Open", "Closed", "Quiet", "Collaborative", "North", "West", "Central"]
        
        setupConstraints()
        getSpots()
        
        tableView.reloadData()
        
        
    }
    
    func convertSpot() {
        for x in readSpotsX {
            let newSpot = Spot(readInfo: x)
            spots.append(newSpot)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        tableView.reloadData()
        collectionView.reloadData()

    }
    
    
//    func addSpotToSharedFaves() {
//        FaveSpots.sharedFaveSpots.removeAll()
//        for s in spots {
//            if(s.isFavorite) {
//                print(FaveSpots.sharedFaveSpots)
//                FaveSpots.sharedFaveSpots.append(s)
//            }
//        }
//    }

    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding * 13)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(6 * padding)
            
        }
        
        viewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding * 7)
            make.centerX.equalTo(view.center.x)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView).offset(padding * 8)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalToSuperview().offset(padding * 3)
            make.trailing.equalToSuperview().offset(-padding * 3)
        }
        
        gradient.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
        
    }
    
    func getSpots() {
        NetworkManager.getBackendSpots { readSpots in
            self.readSpotsX = readSpots
            
            for x in self.readSpotsX {
                let newSpot = Spot(readInfo: x)
                self.spots.append(newSpot)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    

}


extension StudySpotsViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCellReuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        
        cell.configure(for: categories[indexPath.row])
        return cell
    }
    
}

extension StudySpotsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = 22
        let width : CGFloat = (collectionView.frame.width - padding * 4) / 4
        
        return CGSize(width: width, height: height)
    }
    
}

extension StudySpotsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        origin = false
        let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        cell.clickConfigure(for: categories[indexPath.row])
        
        let search = categories[indexPath.row]
        
        var none = false
        if(cell.isSelect) {
            
            for s in spots {
                
                if(s.tags.contains(search)) {
                    s.tagsSelected += 1
                    var flag = true
                    for ss in selectedSpots {
                        
                        if (ss.equals(spot: s)) {
                            flag = false
                        }
                    }
                    
                    if (flag) {
                        selectedSpots.append(s)
                    }
                }
                else {
                    none = true
                }
                
            }
            
        }
        else {
            
            if (selectedSpots.count == 0) {
                
                for s2 in spots {
                    
                    if s2.tags.contains(search) {
                        s2.tagsSelected -= 1
                    }
                    
                }
            }

            var index = 0
            while (index < selectedSpots.count) {
                if(selectedSpots[index].tags.contains(search)) {
                    selectedSpots[index].tagsSelected -= 1
                }
                
                if(selectedSpots[index].tags.contains(search) && selectedSpots[index].tagsSelected <= 0) {
                    selectedSpots.remove(at: index)
                    index -= 1
                }

                index += 1
            }
             
        }
        
        var checker = true
        for ss in selectedSpots {
            if(ss.tagsSelected > 0) {
                checker = false
            }
        }
        if(checker && !none) {
            origin = true
        }
        none = false
        tableView.reloadData()
    }
}

extension StudySpotsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(origin) {
            return spots.count
        }
        else {
            return selectedSpots.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SpotsTableViewCell
        if(origin) {
            cell.configure(for: spots[indexPath.row])
        }
        else {
            cell.configure(for: selectedSpots[indexPath.row])
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(origin) {
            theSpot.sharedSpot = spots[indexPath.row]
        }
        else {
            theSpot.sharedSpot = selectedSpots[indexPath.row]
        }
        
        tabBarController?.selectedIndex = 1
        tableView.reloadData()
    }
    
    
     
}

extension StudySpotsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

