//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Rachel Stevenson on 4/16/15.
//  Copyright (c) 2015 rachelrockaway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "https://api.instagram.com/v1/tags/ocean/media/recent?client_id=5457d1cfece84945afd3c93a3aa48bf6",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                if let dataArray = responseObject["data"] as? [AnyObject] {
                    var urlArray:[String] = []
                    for dataObject in dataArray {
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            urlArray.append(imageURLString)
                        }
                    }
                    self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
                    for var i = 0; i < urlArray.count; i++ {
                        let imageData = NSData(contentsOfURL: NSURL(string: urlArray[i])!)
                        if let imageDataUnwrapped = imageData {
                            let imageView = UIImageView(frame: CGRectMake(0, 320*CGFloat(i), 320, 320))     //1
                            imageView.setImageWithURL( NSURL(string: urlArray[i]))                          //2
                            self.scrollView.addSubview(imageView)
                    
                        }
                    }
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

