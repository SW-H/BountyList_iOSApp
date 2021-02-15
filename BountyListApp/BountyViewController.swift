//
//  BountyViewController.swift
//  BountyList
//
//  Created by 한승원 on 2021/01/13.
//

import UIKit



class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //(수정)UITableViewDataSource -> UICollectionViewDataSource
    //  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout 추가
    
    
    
    // < MVVM >
    
    // Model : BountyInfo
    
    // View : ListCell
    // ListCell 필요한 정보를 ViewModel 한테서 받아오기~
    // ViewModel로 부터 받은 정보로 View Update
    
    // ViewModel : BountyViewModel
    // View 레이어에서 필요한 method 만들기
    // Model (BountyInfo들) 가지고 있기
    

    let viewModel = BountyViewModel()
    
    //segue way를 수행하기 직전에 수행하기 위해 준비하는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController에게 데이터를 전달해 줌
        if segue.identifier == "ShowDetail"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {//Down casting
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // UICollectionViewDataSource :  몇개를 보여줄까, 셀은 어떻게 표현할까
    // 몇개를 보여줄까
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else { return UICollectionViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        return cell
            
    }
    
    // UICollectionViewDelegate : 셀이 클릭되었을 때 어쩔까
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: indexPath.item)
    }
    
    
    // UICollectionViewDelegateFlowLayout :layouting
    // 디바이스의 가로 사이즈에 맞추어 셀 가로 사이즈가 변경 되어야 함(일관적인 디자인을 보여주기 위해),  필수 구현요소는 아님
    
    // 한줄에 두개씩, 각 아이템 간의 간격은 10, 줄간 간격도 10
    // collection view의 너비 = (디바이스 가로길이 - 10)/2
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing : CGFloat = 10
        let textAreaHeight : CGFloat = 65
        
        // collectionView.bounds : collectionview의 크기
        let width : CGFloat = ( collectionView.bounds.width - itemSpacing)/2
        let height : CGFloat = width * 10/7 + textAreaHeight //가로 세로 비율이 7:10이기 때문
        
        return CGSize(width:width, height:height)
    }
    
    
}

class BountyViewModel{
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 152430000),
        BountyInfo(name: "chopper", bounty: 8000000),
        BountyInfo(name: "franky", bounty: 3240000),
        BountyInfo(name: "luffy", bounty: 1142300000),
        BountyInfo(name: "nami", bounty: 55000000),
        BountyInfo(name: "robin", bounty: 613600000),
        BountyInfo(name: "sanji", bounty: 70000000),
        BountyInfo(name: "zoro", bounty: 888888888888)
    
    ]
    
    // 현상금 순위 별로 정렬
    var sortedList: [BountyInfo]{
        let sortedList = bountyInfoList.sorted{ prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList: Int{
        return bountyInfoList.count
    }
    func bountyInfo(at index : Int)->BountyInfo{
        return sortedList[index]
    }
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    // view controller
    
    func update(info: BountyInfo){
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}
