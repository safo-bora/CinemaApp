import UIKit

/**
    Batch Actions View Controller, contains the replication and batch operation actions.
*/
class HomeActionsViewController: UIViewController {

    //@IBOutlet weak var dfdfgd: UIButton!
    fileprivate var eventAPI: EventAPI!
    fileprivate var remoteReplicator: RemoteReplicator!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.eventAPI = EventAPI.sharedInstance
        self.remoteReplicator = RemoteReplicator.sharedInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func deleteAllEventsButtonTapped(_ sender: AnyObject) {
        eventAPI.deleteAllEvents()
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func replicateRemoteDataButtonTapped(_ sender: AnyObject) {
        remoteReplicator.fetchData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)

    }
}
