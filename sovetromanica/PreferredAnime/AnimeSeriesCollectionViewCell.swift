//
//  AnimeSeriesCollectionViewCell.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 06.03.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit
import CoreData
import Ji

class AnimeSeriesCollectionViewCell: UICollectionViewCell {
    
    var identificator = 0
    var dubOrSub = ""
    var dataImage: Data?
    var serieNomber = 0
    var urlSeries: String?
    @IBOutlet weak var imageSerie: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var seriesNimber: UILabel!
    @IBOutlet weak var downloadSeriesOutlet: UIButton!
    @IBOutlet weak var backgroundButtonDownloadSeries: UILabel!
    
    @IBAction func downloadSeries(_ sender: UIButton) {
        
//        print (identificator)
//        print (dubOrSub)
//        print (dataImage)
//        print (serieNomber)
        print (urlSeries!)
        
        
                    
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let featch: NSFetchRequest<DownloadAnime> = DownloadAnime.fetchRequest()
////
//        var flag = false
//        if let result = try? context.fetch(featch) {
//            for object in result {
//                if object.animeID == identificator {
//                    context.delete(object)
//                    flag = true
//                }
//            }
//
////
//        }
//        if flag {
//            do {
//                try context.save()
//            } catch {
//                print (error)
//            }
//        }
//        else {
//            guard let readyURL = URL(string: urlSeries!) else {return}
//
//            guard let jiDoc = Ji(htmlURL: readyURL) else {return}
//
//            guard  let urlAnimeSerie = jiDoc.xPath("///sourcex/@src")?.first else {return}
//            let ReadyUrlSeries = urlAnimeSerie.content!
//            print (ReadyUrlSeries)
//            let videoURL = URL(string: ReadyUrlSeries)
//
//
//
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//
//            guard let entity = NSEntityDescription.entity(forEntityName: "DownloadAnime", in: context) else {return}
//
//            let object = DownloadAnime(entity: entity, insertInto: context)
            
        
            
        }
    
    
    }
    


