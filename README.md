# ESContacts


## Overview

Implement a simple Contacts app based on iOS contacts UI, allow the ability to create, update, retrieve and delete contact items.  UI is based on existing contacts app by Apple and utilizes CoreData for the data store.


## Installation

The project is a Single View App designed for the iPhone with no additional frameworks or CocoaPods.  To run, clone or download, open the ESContacts.xcodeproj file and run the project.  When the app runs for the first time it will load a bundled JSON file of 10 contacts and add them to the CoreData store. 
## Architecture


### Data Model

The data model consists four entities in CoreData, the main one being ContactData containing three 1-to-many relationships of PhoneData, EmailData and AddressData.

    ContactData
    - firstName
    - lastName
    - company
    - id
    - sectionKey
    - sortName
    - sortIndex
    + PhoneData
        - type
        - value
    + EmailData
        - type
        - value
    + AddressData
        - type
        - street1
        - street2
        - city
        - state
        - zipcode
        - country


ContactData contains helper fields to assist in the sorting and displaying of contact names.

The sortName is the value used for sorting the contacts, it is usually lastName + firstName though in cases where there is no lastName it is firstName, and in cases where there is no firstName or lastName it is company

The sortIndex is used to determine where to begin highlighting the display name string to bold the sortName

The sectionKey is the corresponding letter specifying the "letter" section the contact belongs in.


### View Controllers

The architecture utilizes a set of View Controllers for listing, displaying and editing contact data.

#### Contacts View Controller

The main view consists of a sorted list of contacts displayed as "First Name Last Name" or "Company Name" (if first name and last name are empty).  From this view, you can either view the details of an existing contact or create a new contact.

#### Details View Controller

The details view displays contacts details. The basic data is displayed in a fixed area at the top and the details of the related entities are displayed in a scrollable list below it.  From this view, you can either edit the contact or go back to the list of contacts.

#### Edit Details View Controller

The edit details view displays the contacts details in an editable format.  From this view, aside from editing the values, you can either change a label for a data section, delete a contact, edit and save any updates or cancel the edit

#### Types Label View Controller

This is a basic table view that lists the available "type" labels for the data section.  From this view, once a label is selected the view closes or you can cancel and exit without selecting


### View and Utility Classes

The project includes a number of view class used for managing table view cells and also for creating views with common features such as borders, font face, and color.  The project also includes a couple of utility files for organizing constant values, class extensions, and logging.

## Testing

You can test the application using the following suggestions.  Any changes made should be persisted in the data store, so the test should include examining changes when running the app and also when re-opening the app.

### Import

Test that the import only runs once by running the app on a clean device, when it runs the first time a list of 10 contacts should display.  Close and re-open the app, the list of 10 contacts should still be present.  Delete or add a contact, then reopen the app, the list should contain the result of the add or delete.

### Add Contact

To add a contact click the plus sign.  The New Contact view will appear.  This view is divided into four sections, info, phone, email, address.

Note:  For this exercise, there is no data validation so you can enter any character in the fields.  There is also no limit to the number of characters per field, and finally, there is no limit to the number of phone, email and address items you can add.


#### Info

For First Name, Last Name, Company at least one of the three should have a value, if not the Done button will be disabled so the contact cannot be saved.

#### Email, Phone, Address


To add a phone, email or entry tapped the respective green plus sign on the left side of the view.  When the plus is tapped, a new row will be added above the plus sign containing the fields to be populated.

For the three relationship fields, phone, email, address, the left side of the row contains a label specifying the type of record (home, work, etc).  You can change the label by tapping on it.  If tapped, the "Types Label" view will appear giving you options for the value.  The set of options is different for phone, email, and address.

For phone and email entries you must have a value in the "value" on the right for it to stick when saving,  Any entry with a blank value will be removed during the save.  For an address to save, you need to enter a value in any field aside from country which is prepopulated with "United States".

Each new row added will have a red minus icon on the left side, tapping this icon will display the red "delete" button for the row on the right, which when tapped will delete the row.


### Delete Contact

You can delete a contact from the Edit Contact view, there is an option at the bottom to delete.  When delete is tapped a confirmation alert will appear.  When the contacted is deleted the view closes and returns to the main list.  The deleted contact should not be present in the list.  It should also not appear when the app re-opens


### Edit Contact

To edit a contact you need to click on the contact from the main screen, then click on the Edit button on the detail screen.  You should see the same view as adding a contact but with the data values filled in.  Also, there is an option to delete the contact at the button of the view. You may need to scroll the view to get to the delete option.


If Done is tapped, any changes made during the edit should appear after the edit view closes.  If Cancel is tapped any changes should be discarded and the details should remain unchanged.


The behavior of the data entry fields in this view is the same as described in the Add Contact section above


### List of Contacts

The list of contacts is sorted based on Last Name, First Name or Company.   To test sorting create contacts with all three fields, with first and last name only, just first name, just last name, just company name. The term that is used for the sort order is in bold, it should be the last name, you can verify by using a name like John John or Johnny John, the second John should be bold.  Also, any contact whose last name (or respective sort name if no last name) does not begin with a letter will be placed in the "#" section at the bottom.








