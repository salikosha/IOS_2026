import UIKit
import AVFoundation
 
class ViewController: UIViewController, AVAudioPlayerDelegate {
 
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
 
    
    private let tracks = TrackLibrary.tracks
    private var currentIndex = 0
    private var isPlaying = false
 
    
    private var player: AVAudioPlayer?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Не удалось настроить аудиосессию: \(error)")
        }
 
        loadPlayer()
        refreshUI()
    }
 
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            if player?.play() == true {
                isPlaying = true
            } else {
                print("Не удалось начать воспроизведение")
            }
        }
        refreshUI()
    }
 
    @IBAction func nextTapped(_ sender: UIButton) {
        selectTrack(at: (currentIndex + 1) % tracks.count)
    }
 
    @IBAction func previousTapped(_ sender: UIButton) {
        selectTrack(at: (currentIndex - 1 + tracks.count) % tracks.count)
    }
 
   
    private func selectTrack(at index: Int) {
        currentIndex = index
        loadPlayer()
 
        
        if isPlaying {
            if player?.play() != true {
                isPlaying = false
            }
        }
        refreshUI()
    }
 
    
    private func loadPlayer() {
        player?.stop()
        player = nil
 
        let track = tracks[currentIndex]
 
        guard let url = audioURL(for: track.fileName) else {
            print("Файл не найден в бандле: \(track.fileName)")
            return
        }
 
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.delegate = self
            newPlayer.prepareToPlay()
            player = newPlayer
        } catch {
            print("Не удалось создать плеер для \(track.fileName): \(error)")
        }
    }
 
    private func audioURL(for fileName: String) -> URL? {
        for ext in ["mp3", "m4a"] {
            if let url = Bundle.main.url(forResource: fileName, withExtension: ext) {
                return url
            }
        }
        return nil
    }
 
    
    private func refreshUI() {
        let track = tracks[currentIndex]
        titleLabel.text = track.title
        artistLabel.text = track.artist
        coverImageView.image = UIImage(named: track.coverImageName)
 
        let iconName = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
 
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        selectTrack(at: (currentIndex + 1) % tracks.count)
    }
}
 
