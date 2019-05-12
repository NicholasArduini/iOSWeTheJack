//
//  ViewController.swift
//  JackArmstrong
//
//  Created by Nicholas Arduini on 4/14/19.
//  Copyright © 2019 Nicholas Arduini. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate {
    
    @IBOutlet weak var soundButtonCollectionView: UICollectionView!
    @IBOutlet weak var jackImage: UIImageView!
    
    var audioPlayer : AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true{
            timer?.invalidate()
            jackImage.image = UIImage(named: "jack.png")
            jackImageIsOpen = true
        }
    }
    
    let audioItems = [
        AudioItem(fileName: "GetThatGarbageOutOfHere", title: "GET THAT GARBAGE OUTTA HERE 🗑"),
        AudioItem(fileName: "NoNoNoGTGOH", title: "NO NO NO NO 🙅‍♂️"),
        AudioItem(fileName: "Hello", title: "HELLO! 👋"),
        AudioItem(fileName: "HelloOo", title: "HelloOoO 👋👋"),
        AudioItem(fileName: "Bonjour", title: "Bonjouuur 🇫🇷"),
        AudioItem(fileName: "MaFuzzy", title: "MaFuzzy Chef 👨‍🍳"),
        AudioItem(fileName: "DialItUpDannyG", title: "DIAL IT UP DANNY G 📞"),
        AudioItem(fileName: "DannyGShowItAgain", title: "Danny G show it again 🎥"),
        AudioItem(fileName: "WhosYourDaddyMattyD", title: "Who's your daddy MATTY D 👨‍👦"),
        AudioItem(fileName: "DripToHard", title: "Drip too hard 💧"),
        AudioItem(fileName: "Snickers", title: "Snickaas 🍫"),
        AudioItem(fileName: "Kajiji", title: "KAJIJI! 🛍"),
        AudioItem(fileName: "SpinARama", title: "Lil spin o-rama 🌪"),
        AudioItem(fileName: "LilBlowBy", title: "Lil blow by 💨"),
        AudioItem(fileName: "PurpleRain", title: "Purple rainnn 🎤"),
        AudioItem(fileName: "NowYouSeeMeNowYouDont", title: "Now you see me now you don't 🙈"),
        AudioItem(fileName: "ThatsWhatImTalkingAbout", title: "Thats what I'm talking about 🗣"),
        AudioItem(fileName: "Bang", title: "BANG! 💥")
    ]
    
    
    let reuseIdentifier = "soundCell" // also enter this string as the cell identifier in the storyboard
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.audioItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SoundCollectionViewCell
        cell.soundLabel.text = self.audioItems[indexPath.item].title
        cell.layer.cornerRadius = 5
        cell.alpha = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playAudio(audioFile: audioItems[indexPath.item].fileName)
        startTimer()
        
        if let cell = collectionView.cellForItem(at: indexPath) as? SoundCollectionViewCell {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                cell.contentView.backgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            }, completion: { _ in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                    cell.contentView.backgroundColor = UIColor.clear
                }, completion: { _ in })
            })
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (soundButtonCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size*(2/3))
    }
    
    func playAudio(audioFile: String) {
        do {
            if let bundle = Bundle.main.path(forResource: "Recordings/\(audioFile)", ofType: "m4a") {
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
                try AVAudioSession.sharedInstance().setActive(true)
                try audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
                audioPlayer.prepareToPlay()
                audioPlayer.numberOfLoops = 0
                audioPlayer.delegate = self
                audioPlayer.play()
            }
        } catch {
            print(error)
        }
    }
    
    var timer: Timer?
    var jackImageIsOpen = true;
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.24,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }
    
    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!) {
        if(jackImageIsOpen){
            jackImage.image = UIImage(named: "jack-closed.png")
            jackImageIsOpen = false
        } else {
            jackImage.image = UIImage(named: "jack-open.png")
            jackImageIsOpen = true
        }
        
        
    }
}

