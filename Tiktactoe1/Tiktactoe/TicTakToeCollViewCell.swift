//
//  TicTakToeCollViewCell.swift
//  Tiktactoe
//
//  Created by MacBook Pro on 29/06/21.
//

import UIKit

class TicTakToeCollViewCell: UICollectionViewCell {
    
    
    private let MyImageView: UIImageView = {
        
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.clipsToBounds = true
        myImageView.tintColor = .purple
        return myImageView
        
    }()
    
    func setupcell(with status:Int)
    {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(MyImageView)
        MyImageView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        if status == 0 {
            MyImageView.image = UIImage(systemName: "circle")
        }
        else if status == 1{
            MyImageView.image = UIImage(systemName: "multiply")
        }
        else{
            MyImageView.image = UIImage(systemName: "")
        }
    }
    
    
}
