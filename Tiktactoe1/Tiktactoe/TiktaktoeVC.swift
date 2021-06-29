//
//  TiktaktoeVC.swift
//  Tiktactoe
//
//  Created by MacBook Pro on 29/06/21.
//

import UIKit

class TiktaktoeVC: UIViewController {

    private var state = [2,2,2,2, //0 1 2 3
                         2,2,2,2, //4 5 6 7
                         2,2,2,2, //8 9 10 11
                         2,2,2,2] //12 13 14 15
    public var player1 = 0,player2 = 0
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5 ,6 ,7], [8 ,9 ,10 ,11],[12 ,13 ,14 ,15], [0, 4, 8 ,12], [1, 5, 6, 7], [2, 6, 10, 14], [12, 13, 14, 15], [0, 5, 10, 15], [3, 6, 9, 12]]
    
    private var flag = false
    
    private let Bgpic: UIImageView = {
        
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.image = UIImage(named: "bg")
        
        return myImageView
        
    }()
    
    private let ply1:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 1"
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 22)
        
        return myLabel
    }()
    private let vs:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "VS"
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 18)
        return myLabel
    }()
    
    private let plyer2:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 2"
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 22)
        return myLabel
    }()

    private let p1score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.isEditable = false
        textView.font = .boldSystemFont(ofSize: 23)
        return textView
    }()
    
    private let p2score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.backgroundColor = .clear
        textView.font = .boldSystemFont(ofSize: 23)
        textView.textColor = .black
        textView.textAlignment = .center
        textView.isEditable = false
        
        return textView
    }()
    
    private let TicTakToe:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "PLAY! TIC-TAK-TOE"
        myLabel.textColor = .brown
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 35)
        return myLabel
    }()
    
    private let mycollectionview : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionview
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mycollectionview.backgroundView = Bgpic
        //self.view.backgroundColor = .white
        view.addSubview(Bgpic)
        view.addSubview(mycollectionview)
        view.addSubview(ply1)
        view.addSubview(vs)
        view.addSubview(plyer2)
        p1score.text = String(player1)
        p2score.text = String(player2)
        view.addSubview(p1score)
        view.addSubview(p2score)
        view.addSubview(TicTakToe)
        setupcollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //BG.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        ply1.frame = CGRect(x: 20, y: 10, width: 100, height: 50)
        vs.frame = CGRect(x: 180, y: 10, width: 30, height: 50)
        plyer2.frame = CGRect(x: 260, y: 10, width: 100, height: 50)
        p1score.frame = CGRect(x: 20, y: ply1.bottom + 5, width: 100, height: 50)
        p2score.frame = CGRect(x: 260, y: plyer2.bottom + 5, width: 100, height: 50)
        TicTakToe.frame = CGRect(x: 0, y: view.height - 80, width: view.width, height: 40)
        mycollectionview.frame = view.bounds
        
    }


}
extension TiktaktoeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    private func setupcollectionView()
    {
        mycollectionview.register(TicTakToeCollViewCell.self, forCellWithReuseIdentifier: "TicTakToeCollViewCell")
        mycollectionview.delegate = self
        mycollectionview.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTakToeCollViewCell", for: indexPath) as! TicTakToeCollViewCell
        cell.setupcell(with: state[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if flag{//inssertion of X and 0
                state.insert(0, at: indexPath.row)
                
            }
            else{
                state.insert(1, at: indexPath.row)
                
            }
            flag = !flag
            collectionView.reloadData()
            checkwinner()
        }
    }
    private func checkwinner()
    {
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game Over", message: "Draw", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations{
            if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2 {
                announcewinner(player: state[i[0]] == 0 ? "0" : "X")
                break
            }
        }
    }
    private func announcewinner(player:String){
        if player == "X"
        {
            player1+=1
            p1score.text = String(player1)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 1 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            player2+=1
            p2score.text = String(player2)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 2 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    private func resettiktactoe()
    {
       state = [2,2,2,2,
                2,2,2,2,
                2,2,2,2,
                2,2,2,2]
        
        flag = false
        mycollectionview.reloadData()
    }
    
}
