//
//  ViewController.swift
//  Roll City
//
//  Created by Ivan Melnikov on 15.11.15.
//  Copyright © 2015 Ivan Melnikov. All rights reserved.
//



import UIKit
import Parse



class ViewController: DLHamburguerViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        self.contentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") 
        self.menuViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
    }
}


class ViewController2: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //хранилище, бывший test array. по-хорошему вытащить в отдельную сущность, но и так сойдет
    var dataSource = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
   
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.didFetchData([])         //очистим список
        self.fetchData()         //для не захломляемости вынесем в отдельный метод вытяжку данных
        //sleep(1) <--- никогда, никогда так не делайте
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        let object = self.dataSource[indexPath.row]
        let title = object.objectForKey("name")
        if let title = title as? String{
            cell.lbTitle.text = title
        }else{
            cell.lbTitle.text = "Unknow" //какой-то кривой объект. лучше такие моменты проверять на этапе парсинга
        }
        

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailSegue"){
            // check for / catch all visible cell(s)
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = dataSource[indexPath.row]
                let destViewController = segue.destinationViewController as? DetailView
                destViewController?.currentObject = object
            }
        }
    }
}

//
// MARK- Data Provider
//
extension ViewController2 {

    
    func fetchData(){
        self.willFetchData()
        let query = PFQuery(className: "Hot_b")
        let runkey = query.orderByAscending("name")
        runkey.findObjectsInBackgroundWithBlock{
            (object: [PFObject]?, error: NSError?) -> Void in
            guard let objects = object else{
                //тут можно обработать ошибку, Сделал топорно пока
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.didFetchData(objects)
            })
        }
        
    }
    
    func willFetchData(){
        //обработчик начала загрузки. можно , к примеру, отобразить крутилку. ну или оповестить кого
    }
    
    func didFetchData(data: [PFObject]){
        //обработчик конца загрузки. 
        self.dataSource = data
        self.tableView.reloadData()
    }

}