//
//  HistoryViewController.swift
//  RunApp
//
//  Created by Evgen Patlay on 03.12.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import UIKit
import Realm
import RealmSwift


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var runs  = [RealmRun]()

    private func getDateAndReload(){
        do{
            let realm = try Realm()
            let results = realm.objects(RealmRun.self)
            runs = Array(results)
            print("TEST \(runs.count)")
            runsHistoryTableView.reloadSections([0], with: .fade)

        }catch{
            print(error.localizedDescription)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCellIdentifier", for: indexPath) as! RunTableViewCell
        cell.configure(whith: runs[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    


    @IBOutlet weak var runsHistoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        runsHistoryTableView.delegate = self
        runsHistoryTableView.dataSource = self

        runsHistoryTableView.register(UINib(nibName: "RunTableViewCell", bundle: nil), forCellReuseIdentifier: "RunCellIdentifier")
        getDateAndReload()

    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runsHistoryTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
