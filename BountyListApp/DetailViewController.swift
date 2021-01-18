//
//  DetailViewController.swift
//  BountyListApp
//
//  Created by 한승원 on 2021/01/18.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  버튼을 눌렀을때 이 view controller는 닫히는 액션을 넣기
    @IBAction func close(_ sender: Any) {
        dismiss(animated:true, completion:nil)
        // dismiss =  뷰컨트롤러 닫는다
        // completion = 뷰컨트롤러가 닫힌 후에 수행할 일
    }
}
