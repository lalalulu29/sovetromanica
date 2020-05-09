//
//  FavoriteTableViewController.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 12.02.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController, UIApplicationDelegate {

    var anime: [LikeAnime] = []
    var readyGo = SearchAnime()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
//        if let result = try? context.fetch(featch) {
//            for object in result {
//
//                    context.delete(object)
//
//
//                    }
//                }
//
//        do {
//            try context.save()
//
//        } catch {
//            print (error)
//            }
//
        }
//
//
        
    
    @IBAction func reloadData(_ sender: UIRefreshControl) {
        tableView.reloadData()
        refreshControl?.endRefreshing()
//        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        featch.sortDescriptors = [sort]
        do {
            anime = try context.fetch(featch)
//            anime = anime.reversed()
        } catch {
            print (error)
        }
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return anime.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        

        let index = indexPath.row
        let fav = anime[index]
        
        
        var animeNameRu = fav.anime_name_russian!
        var animeName = fav.anime_name!
        
        DispatchQueue.main.async {
            
            
            if animeNameRu.count >= 55 {
                animeNameRu.removeSubrange((animeNameRu.index(animeNameRu.startIndex, offsetBy: 55))..<animeNameRu.endIndex)
                animeNameRu += "..."

            }
            if animeName.count >= 55 {
                animeName.removeSubrange(animeName.index(animeName.startIndex, offsetBy: 55)..<animeName.endIndex)
                animeName += "..."
            }
        }

        
        cell.RuNameAnimeTextLabel.text = animeNameRu
        cell.EnNameAnimeTextLabel.text = animeName
        cell.AgeAnimeTextLabel.text = "\(fav.anime_year)"
        
        cell.imageAnime.image = UIImage(data: fav.image!)
        
//        cell.nameAnime.text = animeName[index]
//        cell.imageAnime.image = UIImage(named: animeName[index])

        return cell
    }
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "delete") { [weak self]  (contextualAction, view, boolValue) in
            
            
            
            guard let notLikeAnime = self?.anime[indexPath.row] else {return}
            let notLikeAnimeName = notLikeAnime.anime_id
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()


            if let result = try? context.fetch(featch) {
                for object in result {
                    if object.anime_id == notLikeAnimeName {

                        context.delete(object)

                    }
                }
            }
            do {
                try context.save()
                self?.anime.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                

            } catch {
                print (error)
            }
            
            
            
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comeon" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else {return}

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let featch: NSFetchRequest<LikeAnime> = LikeAnime.fetchRequest()
            if let result = try? context.fetch(featch) {
            
                let an = result[indexPath.row]
                print (result[indexPath.row])
                readyGo.anime_description = an.anime_description

                readyGo.anime_episodes = Int(an.anime_episodes)
//                readyGo.anime_studio = Int(UInt(an.anime_studio!)!)
                readyGo.anime_folder = an.anime_folder
//                print (readyGo.anime_folder)
                readyGo.anime_id = Int(an.anime_id)
//                print (readyGo.anime_id)
                readyGo.anime_keywords = an.anime_keywords
                readyGo.anime_name = an.anime_name
                readyGo.anime_name_russian = an.anime_name_russian
                readyGo.anime_year = Int(an.anime_year)
                
                let DVC = segue.destination as! PreferredAnimeViewController
                DVC.animeInfo = self.readyGo
                
//                    DVC.viewDidLoad()
    


                }


        }

    }


}
