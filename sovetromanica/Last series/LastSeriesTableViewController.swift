//
//  LastSeriesTableViewController.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 10.08.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit
import AVKit

class LastSeriesTableViewController: UITableViewController {
    
    let infoString = "https://service.sovetromantica.com/v1/last_episodes"
    
    var lastSeriesInfo = [lastSeries]()
    
    
    
    var allID = [Int: Int]()
    
    
    var ruNameAnime = [Int : String]()
    var animeFolder = [Int : String]()
    
    var flag = true
    var DubOrSub = [Int: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLastSeriesInfo()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lastSeriesInfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LastSeriesCell
        let cerie = lastSeriesInfo[indexPath.row]
        DispatchQueue.main.async {
            cell.imageSeries.isHidden = true
            cell.activity.startAnimating()
        }
        
        //        cell.animeName.text = String(cerie.episode_anime)
//        print("nomber folder = \(animeFolder.count)")
        if animeFolder.count == 30 {
            cell.animeName.text = ruNameAnime[cerie.episode_id]
            if DubOrSub[cerie.episode_id] == "dub" {
                cell.dubOrSub.text = "Озвучка"
            } else {
                cell.dubOrSub.text = "Субтитры"
            }
            let testURL =
                ["https://chitoge.sovetromantica.com/anime/\(cerie.episode_anime)_\(self.animeFolder[cerie.episode_id]!)/images/episode_\(cerie.episode_count)_\(self.DubOrSub[cerie.episode_id]!).jpg",
                    "https://scu3.sovetromantica.com/anime/\(cerie.episode_anime)_\(self.animeFolder[cerie.episode_id]!)/images/episode_\(cerie.episode_count)_\(self.DubOrSub[cerie.episode_id]!).jpg",
                    "https://scu2.sovetromantica.com/anime/\(cerie.episode_anime)_\(self.animeFolder[cerie.episode_id]!)/images/episode_\(cerie.episode_count)_\(self.DubOrSub[cerie.episode_id]!).jpg"]
            DispatchQueue.global().async {
                for ur in testURL {
                    if let url = URL(string: ur) {
                        guard let dataImage = try? Data(contentsOf: url) else {continue}
                        DispatchQueue.main.async {
                            cell.imageSeries.image = UIImage(data: dataImage)
                            cell.activity.stopAnimating()
                            cell.activity.isHidden = true
                            cell.imageSeries.isHidden = false
                            
                        }
                    } else {continue}
                }
                
                
            }
        }
        
        
        cell.animeNumber.text = "\(cerie.episode_count) серия"
        
        
        
        
        
        cell.imageSeries.layer.borderWidth = 0.5
        cell.imageSeries.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = lastSeriesInfo[indexPath.row].embed
        guard let url = URL(string: link) else { return }
        
        
        let urlSeries = crutch(url: url)
        if urlSeries == "error" {
            errorAlert()
            return
        }
        
        DispatchQueue.main.async {
            guard let videoURL = URL(string: urlSeries) else {return}
            let player = AVPlayer(url: videoURL)
            
            let playerViewController = AVPlayerViewController()
            
            playerViewController.player = player
            
            
            do {
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            }
            
            self.present(playerViewController, animated: true) {
                
                playerViewController.player!.play()
            }
        }
        
//        print (link)
    }
    
    // MARK: - Add func load info for network
    
    func getLastSeriesInfo() {


        guard let url = URL(string: infoString) else {return}
        
        let session = URLSession.shared
        
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                self.lastSeriesInfo = try JSONDecoder().decode([lastSeries].self, from: data)
                
                DispatchQueue.main.async {
                    self.loadAdditionalInfoForAnimeSeries()
                    self.tableView.reloadData()
                }
                
            } catch {
                print ("error")
            }
            
        }.resume()
        
    }
    // MARK: - Refresh info
    
    @IBAction func refreshLastTable(_ sender: UIRefreshControl) {

        self.flag = false
        self.refreshControl?.endRefreshing()
        getLastSeriesInfo()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Load additional info for anime series
    func loadAdditionalInfoForAnimeSeries() {
        if lastSeriesInfo.count == 30 {
//            print("number loading series = 30")
            
            for serie in lastSeriesInfo {
                
                allID[serie.episode_id] = serie.episode_anime
                if serie.episode_type == 0 {
                    
                    DubOrSub[serie.episode_id] = "sub"
                } else {
                    
                    DubOrSub[serie.episode_id] = "dub"
                    
                }
                
                
                
            }
            
        }
//        print(allID.count)
        if allID.count == 30 {

//            print("i'm here")
            let badUrl = "https://service.sovetromantica.com/v1/anime/"
            for id in allID {
                
                
                guard let url = URL(string: "\(badUrl)\(id.value)") else {return}
                let session = URLSession.shared
                session.dataTask(with: url) { (data, response, error) in

                    guard let data = data else {return}
                    do {
                        let json = try JSONDecoder().decode([additionalInfoForAnime].self, from: data).first
//                        print("nany!!")

                        

                        
                        
                        self.animeFolder[id.key] = json!.anime_folder
                        self.ruNameAnime[id.key] = json!.anime_name_russian
                        
                        
                    } catch {
                        print ("error json decode for additional info anime")
                    }
                    if self.flag == true {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    }
                    
                }.resume()
                
  
            }
            
            
        }
        
        
        
    }
    
    
    func errorAlert() {
        let alert = UIAlertController(title: "Ошибка воспроизведения", message: "Похоже в данный момент приложение не может найти ссылку на серию. Приносим свои извинения", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK =(", style: .default, handler: nil)
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
