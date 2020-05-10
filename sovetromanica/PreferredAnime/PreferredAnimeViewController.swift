//
//  PreferredAnimeViewController.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 06.03.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit
import Ji
import AVKit
import CoreData

class PreferredAnimeViewController: UIViewController {

    
    var animeSub = [animeSeriesStruct]()
    var animeDub = [animeSeriesStruct]()
    var animeInfo: SearchAnime?
    var animeSeries = [animeSeriesStruct]()
    var sub = true
    var dubOrSub: String!
    
    @IBOutlet weak var animeName: UITextView!
    @IBOutlet weak var yearAnime: UITextView!
    @IBOutlet weak var imageAnime: UIImageView!
    @IBOutlet weak var descriptionAnime: UITextView!
    @IBOutlet weak var seriesAnimeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var iCan: UISegmentedControl!
    
    
    @IBOutlet weak var addLikeAnime: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        initInfo()
        downloadInfoSeries()
        preferAnimeBarButtonImage()
        print ("hello!")
        
        
        // Do any additional setup after loading the view.
        
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let context = appDelegate.persistentContainer.viewContext
//                let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
//                if let result = try? context.fetch(featch) {
//                    for object in result {
//
//                            context.delete(object)
//
//
//                            }
//                        }
//
//                do {
//                    try context.save()
//
//                } catch {
//                    print (error)
//                    }
//        //
        
        
        

    }
    
    func preferAnimeBarButtonImage() {

        guard let idAnime = animeInfo?.anime_id else {return}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
        if let result = try? context.fetch(featch) {
            for res in result {
                if res.anime_id == Int64(idAnime) {
                    print ("1")
                    addLikeAnime.setTitle("- УДАЛИТЬ", for: .normal)
//                    addLikeAnime.titleLabel!.text = "- УДАЛИТЬ"
                    return

                }
            }
            print ("2")
            addLikeAnime.setTitle("+ ДОБАВИТЬ", for: .normal)
//            addLikeAnime.titleLabel?.text = "+ ДОБАВИТЬ"

            return
//            navigationItem.rightBarButtonItems?.first?.image = #imageLiteral(resourceName: "star")


        }

    }
    
    func initInfo() {
        guard let anime = animeInfo else {return}
        animeName.text = "\(anime.anime_name_russian!) (\(anime.anime_name!))"
        
        if let year = anime.anime_year {
            yearAnime.text = "Год: \(year)"
        } else {
            yearAnime.text = "Год: неизвестно"
        }
        if anime.anime_description != "" {
            descriptionAnime.text = anime.anime_description
        } else {
            descriptionAnime.text = "Описание отсутствует"
        }
        
        guard let animeId = anime.anime_id else {return}
        guard let animeFolder = anime.anime_folder else {return}
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
                
        //        guard let entity = NSEntityDescription.entity(forEntityName: "LikeAnime", in: context) else {return}
                
        //        let object = LikeAnime(entity: entity, insertInto: context)
                
                
                
        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
        if let result = try? context.fetch(featch) {
            for object in result {
                if object.anime_id == Int64(anime.anime_id!) {
                    if let imageReady = object.image {
                        DispatchQueue.main.async {
                            self.imageAnime.image = UIImage(data: imageReady)
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                        }
                        return
                    }
                    
                            


                        }
                    }
                }
        
        
        
        
        DispatchQueue.main.async {
            guard let url = URL(string: "https://chitoge.sovetromantica.com/anime/\(animeId)_\(animeFolder)/images/\(animeId).jpg") else {return}
            guard let dataImage = try? Data(contentsOf: url) else {return}
            self.imageAnime.image = UIImage(data: dataImage)
            
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func downloadInfoSeries() {
        guard let anime = animeInfo else {return}
        
        let ID = anime.anime_id
        guard let url = URL(string: "https://service.sovetromantica.com/v1/anime/\(String(describing: ID!))/episodes") else {
//            DispatchQueue.main.async {
//                let AV = UIAlertController(title: "Ошибка", message: "Нет доступа к сети", preferredStyle: .alert)
//                let AOK = UIAlertAction(title: "OK", style: .default, handler: nil)
//                AV.addAction(AOK)
//                self.present(AV, animated: true, completion: nil)
//            }

            return}
//        print (url)
         
         let session = URLSession.shared
         
         session.dataTask(with: url) { [weak self] (data, response, error) in
             guard
                 let data = data
                 else {return}
             
//             print (data)
             
             
             do {
                 let infoAnime = try JSONDecoder().decode([animeSeriesStruct].self, from: data)
                 self?.animeSeries = infoAnime
                 DispatchQueue.main.async {
                     self?.seriesAnimeCollectionView.reloadData()
                 }
                 
             }catch {
//                 print ("error decode")

             }
         }.resume()
    }
    
        func sortInfo() {
            
            for serie in animeSeries {
                if serie.episode_type == 0 {
                    animeSub.append(serie)
                    
                }
                else {
                    animeDub.append(serie)
                }
            }
            
            
            
        }
        
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
//        guard let entity = NSEntityDescription.entity(forEntityName: "LikeAnime", in: context) else {return}
        
//        let object = LikeAnime(entity: entity, insertInto: context)
        
        
        
        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
        if let result = try? context.fetch(featch) {
            for object in result {
                if object.anime_id == (animeInfo?.anime_id)! {
                    
                    context.delete(object)
                    preferAnimeBarButtonImage()
                    return

                }
            }
        }
//        preferAnimeBarButtonImage()
//        print ("hello")
                
        
        guard let imager = imageAnime.image?.pngData() else {return}
                
        //        let animeFavoriter = favariteAnimeCoreDate(name: animeName.text, year: yearAnime.text, image: image, anime_description: descriptionAnime.text, id: id)
                
                
        let animeFavoriter = favariteAnimeCoreDate(
                                                anime_description: animeInfo?.anime_description,
                                                anime_episodes: animeInfo?.anime_episodes,
                                                anime_folder: animeInfo?.anime_folder,
                                                anime_id: animeInfo?.anime_id,
                                                anime_keywords: animeInfo?.anime_keywords,
                                                anime_name: animeInfo?.anime_name,
                                                anime_name_russian: animeInfo?.anime_name_russian,
                                                anime_studio: animeInfo?.anime_studio,
                                                anime_year: animeInfo?.anime_year,
                                                image: imager)
            


        saveInFavorite(info: animeFavoriter)
    }
    

    
       
    private func saveInFavorite(info: favariteAnimeCoreDate) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LikeAnime", in: context) else {return}
        
        let object = LikeAnime(entity: entity, insertInto: context)
        
        
        
        
//        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
        
        
//        if let result = try? context.fetch(featch) {
//            for object in result {
//                guard let id = animeInfo?.anime_id! else {return}
//                if object.anime_id == id {
//                    context.delete(object)
//                    
//                    do {
//                        try context.save()
//                        
//                    } catch {
//                        print (error)
//                    }
//                    
//                    return
//                }
//            }
//            
//        }
        
        object.anime_episodes = Int64(info.anime_episodes!)
        object.anime_folder = info.anime_folder
        object.anime_keywords = info.anime_keywords
        object.anime_description = info.anime_description
        object.anime_id = Int64(info.anime_id)
        object.image = info.image
        object.anime_name_russian = animeInfo?.anime_name_russian!
        object.anime_name = animeInfo?.anime_name!
        object.anime_year = Int64(info.anime_year ?? 0)
        object.anime_studio = "\(info.anime_studio ?? 0)"
        object.date = Date()
        
        
        do {
            try context.save()
            preferAnimeBarButtonImage()
            let favorite = FavoriteTableViewController()
            favorite.tableView.reloadData()
        } catch {
            print (error)
        }
    }
        
        
    }

extension PreferredAnimeViewController: UICollectionViewDataSource,UICollectionViewDelegate {

    
    @objc func selected(target: UISegmentedControl) {
        
        if target == self.iCan {
            animeDub.removeAll()
            animeSub.removeAll()
            if target.selectedSegmentIndex == 0 {
                
                sub = true
                seriesAnimeCollectionView.reloadData()
                seriesAnimeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
            else if target.selectedSegmentIndex == 1 {
                
                sub = false
                seriesAnimeCollectionView.reloadData()
                seriesAnimeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sortInfo()
        iCan.addTarget(self, action: #selector(selected), for: .valueChanged)
//        print (animeSub.count)
//        print (animeDub.count)
        if sub {
            return animeSub.count
        } else {
            return animeDub.count
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let folder = animeInfo?.anime_folder!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AnimeSeriesCollectionViewCell
        cell.activityIndicator.startAnimating()
        var series: animeSeriesStruct?
        
        if sub {
            cell.imageSerie.isHidden = true
            series = animeSub[indexPath.row]
            dubOrSub = "sub"
            
        } else {
            cell.imageSerie.isHidden = true
            series = animeDub[indexPath.row]
            dubOrSub = "dub"
        }
        let testURl = [      "https://chitoge.sovetromantica.com/anime/\((series?.episode_anime)!)_\(folder!)/images/episode_\(indexPath.row + 1)_\(self.dubOrSub!).jpg",
            "https://scu3.sovetromantica.com/anime/\((series?.episode_anime)!)_\(folder!)/images/episode_\(indexPath.row + 1)_\(self.dubOrSub!).jpg",
            "https://scu2.sovetromantica.com/anime/\((series?.episode_anime)!)_\(folder!)/images/episode_\(indexPath.row + 1)_\(self.dubOrSub!).jpg",
            "https://scu1.sovetromantica.com/anime/\((series?.episode_anime)!)_\(folder!)/images/episode_\(indexPath.row + 1)_\(self.dubOrSub!).jpg",
            "https://scu.sovetromantica.com/anime/\((series?.episode_anime)!)_\(folder!)/images/episode_\(indexPath.row + 1)_\(self.dubOrSub!).jpg"
            ]
        
        
        DispatchQueue.global().async {
            for ur in testURl {
            if let url = URL(string: ur) {
                guard let dataImage = try? Data(contentsOf: url) else {continue}
                DispatchQueue.main.async {
                    cell.imageSerie.image = UIImage(data: dataImage)
                    cell.activityIndicator.stopAnimating()
                    cell.activityIndicator.isHidden = true
                    cell.imageSerie.isHidden = false
                }
            }
            }

                        
            //            print (url)

            
            

            
            
        }


        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anime: [animeSeriesStruct]
        print()
        if dubOrSub == "sub" {
            anime = animeSub
        } else {
            anime = animeDub
        }
        
        let serie = anime[indexPath.row]
        let link = serie.embed!
        
        guard let readyURL = URL(string: link) else {
//            DispatchQueue.main.async {
//                let AV = UIAlertController(title: "Ошибка", message: "Нет доступа к сети", preferredStyle: .alert)
//                let AOK = UIAlertAction(title: "OK", style: .default, handler: nil)
//                AV.addAction(AOK)
//                self.present(AV, animated: true, completion: nil)
//            }
            
            return}
        
        guard let jiDoc = Ji(htmlURL: readyURL) else {return}
        
        guard  let urlAnimeSerie = jiDoc.xPath("///sourcex/@src")?.first else {return}
        let urlSeries = urlAnimeSerie.content!
        print (urlSeries)
        
        DispatchQueue.main.async {
            let videoURL = URL(string: urlSeries)
            let player = AVPlayer(url: videoURL!)
                        
            let playerViewController = AVPlayerViewController()

            playerViewController.player = player
            
            do {
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            }

            self.present(playerViewController, animated: true) {
                
                playerViewController.player!.play()
            }
        }
        
        
        
    }
    
}
