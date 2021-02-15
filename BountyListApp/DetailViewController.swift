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

    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    
    
    let viewModel = DetailViewModel()
    
    // 이 view controller 가 메모리에 올라온 시점에 호출 됨 ( 보이기 직전 )
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        // 애니메이션은 뷰가 보여진 이후에 보여져야함 -> 실제 보여진 시점
        super.viewDidAppear(animated)
        showAnimation()
        
    }
    
    private func prepareAnimation(){
//        nameLabelCenterX.constant = view.bounds.width  //오른쪽 끝에 위치
//        bountyLabelCenterX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x:3,y:3).rotated(by: 180)
        // 우측에 있고 3배 커지고 180도 돌아가있는 상태
        // 크기가 작아지면서, 회전하면서 위치 이동
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x:3,y:3).rotated(by: 180)
        
        
        // 투명도도 변함
        nameLabel.alpha=0
        bountyLabel.alpha=0
    }
    
    private func showAnimation(){
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
//
//        /*
//        UIView.animate(withDuration:0.3,
//                       delay:0.1,//delay: 몇초후에 실행
//                       options:.curveEaseIn,
//                       animations:{
//                        self.view.layoutIfNeeded()
//                       },
//                       completion:nil
//                       //completion:애니메이션 끝난 후에 실행할 것
//        )
//        */
//
//        // 튕기는 효과의 애니메이션
//        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: self.view.layoutIfNeeded, completion: nil)
//
//
//        // 사진 플립 효과
//        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        
        
// name label 이 먼저 오고 bounty label 이 뒤늦게 뜨도록 애니메이션을 분리
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {     // 변하기 전의 모습
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha=1
        }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {     // 변하기 전의 모습
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha=1
        }, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    
    }
    
    func updateUI(){
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
