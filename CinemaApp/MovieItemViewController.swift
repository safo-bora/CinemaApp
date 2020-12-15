import UIKit

/**
    EventItem View Controller, contains detailed view of a selected Event.
*/
class MovieItemViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {

    //placeholder for event endpoint
    fileprivate var eventAPI: EventAPI!

    //Reference to selected event to pass to details view
    var selectedEventItem: Event!

    @IBOutlet weak var eventTitleLabel: UITextField! { didSet { eventTitleLabel.delegate = self } }
    @IBOutlet weak var eventCountryLabel: UITextField! { didSet { eventCountryLabel.delegate = self } }
    @IBOutlet weak var eventProductionLabel: UITextField! { didSet { eventProductionLabel.delegate = self } }
    @IBOutlet weak var eventLongDescriptionLabel: UITextView! { didSet { eventLongDescriptionLabel.delegate = self } }
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var actorsTableView: UITableView!

    fileprivate let idNamespace  = MovieAttributes.eventId.rawValue
    fileprivate let titleNamespace  = MovieAttributes.title.rawValue
    fileprivate let dateNamespace  = MovieAttributes.date.rawValue
    fileprivate let countryNamespace  = MovieAttributes.country.rawValue
    fileprivate let actorsNamespace  = MovieAttributes.actors.rawValue
    fileprivate let productionNamespace  = MovieAttributes.production.rawValue
    fileprivate let longDescriptionNamespace  = MovieAttributes.longDescription.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func setup() {
        self.eventAPI = EventAPI.sharedInstance

        actorsTableView.delegate = self
        actorsTableView.dataSource = self

        if(self.selectedEventItem != nil) {
            setFieldValues()
        }
    }

    // MARK Actions

    /**
        Call endpoint save event handler, pass this event together with
        populated dictionary from field values.
    */
    @IBAction func eventSaveButtonTapped(_ sender: UIBarButtonItem) {
        if(selectedEventItem != nil) { //existing event
            eventAPI.updateEvent(selectedEventItem, newEventItemDetails:getFieldValues())
        } else { //new event
            //Input details
            var newDetails = getFieldValues()

            //Generate UUID, add it to dictionary
            newDetails[idNamespace] =  UUID().uuidString as NSObject?

            //Set initial list to empty list
            newDetails[actorsNamespace] =  [AnyObject]() as NSObject?

            eventAPI.saveEvent(newDetails)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    /**
        Set all fields text to a predefined default value.
    */
    @IBAction func clearButtonTapped(_ sender: AnyObject) {
        let defaultValue = "Empty" // need to change to empty String ;p
        eventTitleLabel.text = defaultValue
        eventCountryLabel.text = defaultValue
        eventLongDescriptionLabel.text = defaultValue
        eventProductionLabel.text = defaultValue
        eventDatePicker.date = Date()
    }

    /**
        Delete event item from datastore.
    */
    @IBAction func deleteEventButtonTapped(_ sender: UIButton) {
        if(selectedEventItem != nil) {
            eventAPI.deleteEvent(selectedEventItem)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: Textfield delegates

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollViewContainer.setContentOffset(CGPoint.zero, animated: true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollViewContainer.setContentOffset(CGPoint(x: scrollViewContainer.frame.origin.x, y: textField.frame.origin.y - 8), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    // MARK Utility methods

    /**
        Set field values for passed on event item.
    */
    fileprivate func setFieldValues() {
        eventTitleLabel.text = selectedEventItem.title
        eventCountryLabel.text = selectedEventItem.country
        eventProductionLabel.text = selectedEventItem.production
        eventLongDescriptionLabel.text = selectedEventItem.longDescription
        eventDatePicker.date = selectedEventItem.date as Date
    }

    /**
        Populates all fields in to dictionary
    */
    fileprivate func getFieldValues() -> Dictionary<String, NSObject> {

        var fieldDetails = [String: NSObject]()
        fieldDetails[titleNamespace] = eventTitleLabel.text as NSObject?
        fieldDetails[dateNamespace] = Date() as NSObject?
        fieldDetails[countryNamespace] = eventCountryLabel.text as NSObject?
        fieldDetails[dateNamespace] = eventDatePicker.date as NSObject?
        fieldDetails[productionNamespace] = eventProductionLabel.text as NSObject?
        fieldDetails[longDescriptionNamespace] = eventLongDescriptionLabel.text as NSObject?

        return fieldDetails
    }

    @IBAction func switchSegmentTapped(_ sender: AnyObject) {

        if segmentController.selectedSegmentIndex == 0 {
            actorsTableView.isHidden = true
            scrollViewContainer.isHidden = false

            if selectedEventItem != nil {
                self.title = "Edit movie"
            } else {
                self.title = "Add movie"
            }
        }

        if segmentController.selectedSegmentIndex == 1 {
            scrollViewContainer.isHidden = true
            actorsTableView.isHidden = false

            if selectedEventItem != nil {
                self.title = String(format: "Actors (%i)", selectedEventItem.actors.count)
            } else {
                self.title = "Actors (0)"
            }
        }
    }

    // MARK: Attendees TableView Delegates

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int

        if selectedEventItem != nil {
            count = selectedEventItem.actors.count
        } else {
            count = 0
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attendeesTableCellIdentifier = "attendeesItemCell"
        let attendeeCell = tableView.dequeueReusableCell(withIdentifier: attendeesTableCellIdentifier, for: indexPath)
        let attendees = selectedEventItem.actors as! [String]
        attendeeCell.textLabel!.text = attendees[indexPath.row]

        return attendeeCell
    }

}
