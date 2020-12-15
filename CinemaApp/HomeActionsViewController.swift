import UIKit

/**
    Batch Actions View Controller, contains the replication and batch operation actions.
*/
class HomeActionsViewController: UIViewController {

    //@IBOutlet weak var dfdfgd: UIButton!
    fileprivate var eventAPI: EventAPI!
    //fileprivate var localReplicator: LocalReplicator!
    fileprivate var remoteReplicator: RemoteReplicator!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.eventAPI = EventAPI.sharedInstance
        //self.localReplicator = LocalReplicator.sharedInstance
        self.remoteReplicator = RemoteReplicator.sharedInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    @IBAction func debug_only_anonimizeListButtonTapped(_ sender: AnyObject) {
//        eventAPI.anonimizeAttendeesList()
//        self.navigationController?.popToRootViewController(animated: true)
//    }

    @IBAction func deleteAllEventsButtonTapped(_ sender: AnyObject) {
        eventAPI.deleteAllEvents()
        self.navigationController?.popToRootViewController(animated: true)
    }

//    @IBAction func restoreEventsButtonTapped(_ sender: AnyObject) {
//        //localReplicator.fetchData()
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    @IBAction func replicateRemoteDataButtonTapped(_ sender: AnyObject) {
        remoteReplicator.fetchData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)

    }
}
