//
//  SearchTableViewController.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 15.02.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    var animeSearchListWithAllInfo = [SearchAnime]()
    
    private func GenerationSearchController() {
        navigationItem.searchController = search
        search.searchBar.delegate = self
        search.searchBar.searchTextField.placeholder = "Поиск аниме"
    }
    
    private var timer: Timer?
    let search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        GenerationSearchController()
        
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animeSearchListWithAllInfo.count
//        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.ProgresLoadingImages.startAnimating()
        
        
        
        let searchAnime = animeSearchListWithAllInfo[indexPath.row]
        
        
        
        var animeNameRu = searchAnime.anime_name_russian!
        var animeName = searchAnime.anime_name!
        DispatchQueue.main.async {
            if animeNameRu.count >= 55 {
                animeNameRu.removeSubrange(animeNameRu.index(animeNameRu.startIndex, offsetBy: 55)..<animeNameRu.endIndex)
                animeNameRu += "..."
                        
            }
            if animeName.count >= 55 {
                animeName.removeSubrange(animeName.index(animeName.startIndex, offsetBy: 55)..<animeName.endIndex)
                animeName += "..."
            }
        }

        

        DispatchQueue.main.async {
            cell.RuNameAnimeTextLabel.text = animeNameRu
            cell.EnNameAnimeTextLabel.text = animeName
            cell.AgeAnimeTextLabel.text = "\(searchAnime.anime_year!)"
            
        }
        
        DispatchQueue.main.async {
            guard let url = URL(string: "https://chitoge.sovetromantica.com/anime/\(searchAnime.anime_id!)_\(searchAnime.anime_folder!)/images/\(searchAnime.anime_id!).jpg") else {return}
            guard let dataImage = try? Data(contentsOf: url) else {return}
            cell.imageAnime.image = UIImage(data: dataImage)
            
            
            cell.ProgresLoadingImages.stopAnimating()
            cell.ProgresLoadingImages.isHidden = true
        }
        
        return cell
    }



}


extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] (_) in
            
            guard let animeRequest = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            if animeRequest == "" {return}
            let url = "https://service.sovetromantica.com/v1/animesearch?anime_name=" + animeRequest
            

            
            guard let urlRequestAnime = URL(string: url) else {
//                DispatchQueue.main.async {
//                    let AV = UIAlertController(title: "Ошибка",
//                                               message: "Нет доступа к сети",
//                                               preferredStyle: .alert)
//                    let AOK = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    AV.addAction(AOK)
//                    self?.present(AV, animated: true, completion: nil)
//                }

                return}
            
            let session = URLSession.shared
            
            
            session.dataTask(with: urlRequestAnime) { [weak self] (data, response, error) in
                guard
                    let data = data
                    else {return}
                
//                print (data)
                
                
                do {
                    let infoAnime = try JSONDecoder().decode([SearchAnime].self, from: data)
                    self?.animeSearchListWithAllInfo = infoAnime
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                }catch {
                    DispatchQueue.main.async {
                        let AV = UIAlertController(title: nil , message: "Аниме по запросу не найдено", preferredStyle: .alert)
                        let AOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                        AV.addAction(AOK)
                        self?.present(AV, animated: true, completion: nil)

                        
                    }
                    

                }
            }.resume()
            
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "icanseeitanimesearch" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let anime = animeSearchListWithAllInfo[indexPath.row]
            
            let DVC = segue.destination as! PreferredAnimeViewController
            DVC.animeInfo = anime
            
        }
        
    }
}
