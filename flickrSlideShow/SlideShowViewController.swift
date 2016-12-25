//
//  SlideShowViewController.swift
//  flickrSlideShow
//
//  Created by JAY on 12/23/16.
//  Copyright © 2016 JAY. All rights reserved.
//

import UIKit
import Foundation

class SlideShowViewController: UIViewController {
    
    var aniDuration = Double()
    
    var uno = [String]()
    var dos = [String]()
    
    var currentPageIndex = Int()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("animation duration: \(aniDuration)")
        
        infiniteSlideShow()
        
//        Moa.logger = MoaConsoleLogger

    }
    
    
    func infiniteSlideShow(){
        //set as uno array
//        uno = readImageLinksFromFlickr()
        //uno is initialized in ViewController when app started
        for str in uno {
            scrollView.auk.show(url: str)
        }
        //start slideshow
        scrollView.auk.startAutoScroll(delaySeconds: aniDuration)
        
        //check current image and update slideshow
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SlideShowViewController.updateSlides), userInfo: nil, repeats: true)
    }
    
    func updateSlides(){
        print(makeUnderTwenty(num: scrollView.auk.currentPageIndex!))
        currentPageIndex =  makeUnderTwenty(num: scrollView.auk.currentPageIndex!)
        
        if currentPageIndex > 18 {
            //background downloading new image links array
            dos = readImageLinksFromFlickr()
            for str in dos {
                scrollView.auk.show(url: str)
            }
            
            print("update scrollView")
            //update scrollView
            for n in 0...19 {
                scrollView.auk.updatePage(atIndex: n, url: dos[n])
            }

        }
    }
    
    //make number unser 20
    func makeUnderTwenty(num:Int)->Int{
        if num < 20 {
            return num
        }else{
            return num % 20
        }
    }
    
    func readImageLinksFromFlickr()->[String]{
        let apiStr = "https://api.flickr.com/services/feeds/photos_public.gne"
        let strToURL: NSURL = NSURL(string: apiStr)!
        let flickrHander = FlickrAPIHandler.init(contentsOf: strToURL as URL)
        print("read ImageLinks From Flickr")
        return (flickrHander?.imageLinks)!
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
}


