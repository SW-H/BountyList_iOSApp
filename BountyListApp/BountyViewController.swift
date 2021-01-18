//
//  BountyViewController.swift
//  BountyList
//
//  Created by 한승원 on 2021/01/13.
//

import UIKit

//Custom Cell
class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let nameList =  ["brook", "chopper", "franky","luffy","nami","robin","sanji","zoro"]
    let bountyList = [152430000,8000000,3240000,1142300000,55000000,613600000,70000000000,888888888888]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //UITableViewDataSource 에 대한 대답
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //몇개니
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 어떻게 표현할거니
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        //withIdentifier: 각각의 셀에대한 구분자 -> table view cell 이름에서도 똑같이 직접 바꿔줘야함
        
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        return cell
    }
    
    //UITableViewDelegate : 클릭했을때 어떻게 응답할지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)") //indexPath : 클릭된 셀이 몇번째인지 정보를 가짐
    }

}

