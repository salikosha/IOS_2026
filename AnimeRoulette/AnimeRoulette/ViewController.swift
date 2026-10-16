import UIKit

struct Favorite {
    let title: String
    let description: String
    let imageName: String
}

class ViewController: UIViewController {

    let favorites: [Favorite] = [
        Favorite(title: "Atack of Titans", description: "Я люблю «Atack of Titans» за историю о людях, которым пришлось бороться за выживание человечества, но в итоге они сами развязали войну друг против друга, без всяких смягчений и прикрас", imageName: "atackOfTitans"),
        Favorite(title: "Code Geass", description: "я люблю «Code Geass» за историю о человеке, который ради изменения мира готов пожертвовать всем, но постепенно сам становится тем, с кем когда-то боролся.", imageName: "codeGeass"),
        Favorite(title: "Fire Force", description: "Я люблю «Пламенную бригаду пожарных» за невероятную визуальную составляющую, динамичные бои, красивую анимацию и просто шикарное звуковое сопровождение боев.", imageName: "fireForce"),
        Favorite(title: "Fruit Basket", description: "Единственная полноценная романтика в подборке. Нет слов, насколько хорошо прописаны персонажи.История о травмах, одиночестве и принятии себя, где даже самые сломленные люди постепенно учатся доверять другим и находить своё место в жизни.", imageName: "fruitBasket"),
        Favorite(title: "HunterXHunter", description: "Самое лучшее аниме на свете. История, которая начинается как обычное приключение, но постепенно раскрывает довольно жестокую и тёмную сторону человеческой натуры. В начале весело, потом вообще не весело ", imageName: "hunterXhunter"),
        Favorite(title: "Monster", description: "Я люблю «Monster» за психологически напряжённую историю, сложных персонажей и атмосферу, которая заставляет задуматься о том, насколько тонкая грань отделяет человека от настоящего чудовища.Очень сильное психологическое давление", imageName: "monsTer"),
        Favorite(title: "Moriarty the patriot", description: "Я люблю «Moriarty the patriot» за необычный взгляд на Шерлока Холмса, харизматичных персонажей и историю о том, как ради борьбы с несправедливостью можно самому стать преступником.", imageName: "moriartyThepatriot"),
        Favorite(title: "Seven deadly sins", description: "Самое комфортное аниме. Я люблю «Seven deadly sins» за фэнтезийный мир, харизматичных персонажей, зрелищные сражения и историю о дружбе, предательстве и искуплении. Так же это аниме по Библии", imageName: "sevenDeadlySins"),
        Favorite(title: "Summertime render", description: "Я люблю «Summertime render» за атмосферу загадки и напряжения, неожиданные сюжетные повороты и историю, в которой с каждой серией становится всё сложнее отличить реальность от кошмара.", imageName: "summertimeRender"),
        Favorite(title: "TenSura", description: "Любимый исэкай. Я люблю «TenSura» за интересный фэнтезийный мир, развитие персонажей и то, как из истории о перерождении в монстра постепенно вырастает масштабная история о создании собственного государства.", imageName: "tenSura")
    ]

    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var lastFavoriteIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        showInitialFavorite()
    }

    func showRandomFavorite() {
        guard !favorites.isEmpty else { return }

        var randomIndex = Int.random(in: 0..<favorites.count)

        if favorites.count > 1 {
            while randomIndex == lastFavoriteIndex {
                randomIndex = Int.random(in: 0..<favorites.count)
            }
        }

        lastFavoriteIndex = randomIndex
        let favorite = favorites[randomIndex]

        titleLabel.text = favorite.title
        descriptionLabel.text = favorite.description
        animeImageView.image = UIImage(named: favorite.imageName)
    }

    func showInitialFavorite() {
        guard !favorites.isEmpty else { return }

        let favorite = favorites[0]
        lastFavoriteIndex = 0

        titleLabel.text = favorite.title
        descriptionLabel.text = favorite.description
        animeImageView.image = UIImage(named: favorite.imageName)
    }

    @IBAction func surpriseMeTapped(_ sender: UIButton) {
        showRandomFavorite()
    }
    
}
