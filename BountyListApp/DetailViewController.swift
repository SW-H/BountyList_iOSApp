//
//  DetailViewController.swift
//  BountyListApp
//
//  Created by 한승원 on 2021/01/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    // < MVVM >
    
    // Model : BountyInfo
    
    // View : imgView, nameLabel, bountyLabel
    // view들은 ViewModel로 부터 받은 정보로 View Update
    
    // ViewModel : DetailViewModel
    // View 레이어에서 필요한 method 만들기
    // Model (BountyInfo들) 가지고 있기
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
//    var name:String?
//    var bounty:Int?
//    var bountyInfo : BountyInfo?
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() { // 이 view controller 가 메모리에 올라온 시점에 호출 됨 ( 보이기 직전 )
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){

        
//        if let name = self.name, let bounty = self.bounty {
//            let img = UIImage(named: "\(name).jpg")
//            imgView.image =  img
//            nameLabel.text = name
//            bountyLabel.text = "\(bounty)"
//        }
//

        //        if let bountyInfo = self.bountyInfo{
//                    imgView.image =  bountyInfo.image
//                    nameLabel.text = bountyInfo.name
//                    bountyLabel.text = "\(bountyInfo.bounty)"
        //        }
        
        
        if let bountyInfo = viewModel.bountyInfo{
            imgView.image =  bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }

    }
    
    //  버튼을 눌렀을때 이 view controller는 닫히는 액션을 넣기
    @IBAction func close(_ sender: Any) {
        dismiss(animated:true, completion:nil)
        // dismiss =  뷰컨트롤러 닫는다
        // completion = 뷰컨트롤러가 닫힌 후에 수행할 일
    }
}

class DetailViewModel{
    var bountyInfo : BountyInfo?
    
    func update(model : BountyInfo? ){
        bountyInfo=model
    }
}
