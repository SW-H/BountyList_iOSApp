//
//  BountyViewController.swift
//  BountyList
//
//  Created by 한승원 on 2021/01/13.
//

import UIKit



class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    //UITableViewDataSource 에 대한 대답
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //몇개니
//        return bountyList.count
//        return bountyInfoList.count
        return viewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 어떻게 표현할거니
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at:indexPath.row)
        cell.update(info:bountyInfo)
        return cell
    }
    
    //UITableViewDelegate : 클릭했을때 어떻게 응답할지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("--> \(indexPath.row)") //indexPath : 클릭된 셀이 몇번째인지 정보를 가짐
        
        //view cell이 클릭 되었을때 segue way를 수행해라
        performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
        // sender : segue way 수행시 특정 object를 끼워서 보낼 수도 있는데 이때 보낼 object
        // cell 에 대한 정보를 넘김
    }

}

//Custom Cell
class ListCell: UITableViewCell {
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
