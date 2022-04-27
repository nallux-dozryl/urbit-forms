# Urbit Forms
Create forms and surveys with multiple question types.

### Specifications

##### General
- "booklet" is a form it can have many sections
- "section" can have multiple questions in them
- "question" has two parts, statement and options
- "statement" is the question being asked
- "option" are for questions that has a preset list of answers
- "pamphlet" is a map of answers
- "Author" is the person who creates and publish booklets
- "Respondent" is the person submiting a pamphlet to the Author 

##### Question Types:
- short text 
- long text
- multiple choice (choose one)
- multiple choice (checkbox)
- multiple choice (grid)
- linear scale (eg. 1 - 10)
- Datetime

##### Creating a Booklet
- Click on the `new booklet` button
- A prompted will show requesting for a `Title`, an optional `Description`
 and a `create` button
- Clicking on `create` will open an empty booklet with a set of buttons with
 different question types
- Newly created booklets will be set to private by default.

##### Adding Questions
- Selecting a specific question type will create a `section` with the newly
 created `question` nested within it if no `section`s exists in the booklet

##### Adding Sections
- A button to add a section similar to add question if at least one section is
already present in the booklet

##### Saving a Booklet (Optional)
- The original idea is to have edits be saved instantly. If there are
 performance limitations to this, a save button will be implemented.
- A poke will be sent to the gall agent with the updated booklet.

##### Publishing a Booklet
- Clicking publish will change the permission of the booklet from private to
 public
- Respondents can access the booklet (without edit permissions) by putting in
the address of the booklet. (eg. `~sampel-palnet/{id}/{title})`.
- This will result in the respondent subscribing to the path of the Booklet.

##### Responding to a Booklet
- After inputting the appropriate answers and clicking `submit`, the respondent
 will be send a `pamphlet` through the appropriate wire
- The pamphlet will be stored on the Author's ship with the appropriate id

##### View Received Pamphlets
- Pamphlets will be stored on the Author's ship as a `(map id (set pamphlet))`
- Individual pamphlets can be viewed in detail or exported as CSV

##### Deleting a Booklet
- A booklet allowed to be deleted at anytime. This will also delete
 all submitted pamphlets stored on the same ship.
