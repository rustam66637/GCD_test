//
//  SecondViewController.swift
//  GCD_test
//
//  Created by wozdabady on 13.08.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            indicator.startAnimating()
            indicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://static.wikia.nocookie.net/naruto/images/d/dd/Naruto_Uzumaki%21%21.png")
        //индикатор крутится - лавэха мутится
        indicator.isHidden = false
        indicator.startAnimating()
        //используем очередь с приоритетом utility
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            //интерфейс должен быть в соновном потоке
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
