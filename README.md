# ESContacts


## Overview

Implement a simple Contacts app based on iOS contacts UI, allow for create, update, retrieve and delete of items.  UI is based on existing contacts app by Apple and utilizes CoreData for the data store.


## Installation

The project is a Single Page Application with no additional Frameworks or Cocoa Pods.  To run, clone or download and open the ESContacts.xcodeproj file.  When the program runs for the first time it will load a bundled JSON file of 10 contacts and add them to the CoreData store

## Architecture


### Data Model

The data model consists four entities, the main one being ContactData containing three 1-to-many relationships of PhoneData, EmailData and AddressData.

    ContactData
     - firstName
     - lastName
     - company
     - id
     - sectionKey
     - sortName
     - sortIndex
     - PhoneData
        - type
        - value
    - EmailData
        - type
        - value
    - AddressData
        - type
        - street1
        - street2
        - city
        - state
        - zipcode
        - country


### View Controllers

The architecture utilizes a set of View Controllers for listing, displaying and editing contact data.

#### Contacts View Controller

The main view consists of a sorted list of contacts displayed as "First Name Last Name" or "Company Name" (if first name and last name are empty) sorted by Last Name, First Name or Company.   From this view you can either view the details of an existing contact or create a new contact

#### Details View Controller

The details view displays all contacts details, the basic data is displayed in a fixed view and the details of the related data entities are displayed in a scrollable list From this view you can either edit the contact or go back to the list of contacts

#### Edit Details View Controller

The edit details view displays the contacts details in an editable format.  From this view you can either change a label for a data section, delete a contact, edit and save any updates or cancel the edit

#### Types Label View Controller

This is a basic table view that lists the available "type" labels for the data section.  From this views once a label is selected the view closes or you can cancel and exit without selecting


## Design Classes

The



## Test Instructions

You can test the application using the following instructions.  Any changes made should be persisted in the data store, so the test should include examine changes when running the app and also when closing and re-opening the app


### Import

Test that the import only runs once by running the app on a clean device, when it runs the first time a list of 10 contacts should display.  Close and re-open the app, the list of 10 contacts should still be present.  Delete or add a contact, then reopen the app, the list should contain the result of the add or delete

### Add Contact


### Delete Contact


### Edit Contact

#### Info fields

#### Email, Phone, Address Fields

### List of Contacts

The list of contacts is sorted based on Last Name, First Name or Company.   To test sorting create contacts with all three fields, with first and last name only, just first name, just last name, just company name.









