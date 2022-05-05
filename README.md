# Urbit Forms
Create forms and surveys with multiple question types.

### Agent

#### State

###### $my-surveys
surveys you authored.  
```
+$  my-surveys  ((mop survey-id survey) gth)
```

###### $received-surveys
surveys you've requested.
```
+$  received-surveys(map ship ((mop survey-id survey) gth))
```

###### $my-responses
responses you authored
```
+$  my-responses  (map ship ((mop survey-id response) gth))
```

###### $received-responses
responses received for surveys you have authored
```
+$  received-respones  (map ship (map survey-id response))
```

#### Types

###### $survey-id
the unix timestamp of the time of creation
```
+$  survey-id  @
``` 

###### $survey
a survey can either be `%full`, with validation information
 or `%obscured`, without validation information.
```
+$  survey  
  $%  $:  %full 
          =validation
          metadata=(set meta)
          questions=((mop question-id question) gth)]
      ==
      $:  %obscured
          metadata=(set meta)
          questions=(list question)]
      ==
  ==
```

###### $validation
``` 
+$  validation
  $%  %none
      (list val-type)
  ==
```

###### $val-type
```
+$  val-type
  $%  [%noun @]
      [%grid (set @]
  ==
```
      
###### $meta
the types of metadata allowed
```
+$  meta
  $%  [%title tape]
      [%desc tape]
      [%pub ?]
      :: more will be added eventually
  ==
```

###### $question

```
+$  statement
  $%  [%text text=@t]
      [%url url=@t]
  ==
+$  option
  $%  [%noun @]
      [%grid (set @)]
      %none
  ==
+$  front-type
  $?  %short
      %long
      %one
      %many
      %linear
      %datetime

+$  question  [front-type =statement options=(set option)]
```

###### $response
```
+$  response  (list option) 
```

#### Pokes
To be added


### View
Nothing yet


### Old Stuff (ignore)

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
the address of the booklet. (eg. `~sampel-palnet/{id}/{title}`).
- This will result in the respondent subscribing to the path of the Booklet.

##### Responding to a Booklet
- After inputting the appropriate answers and clicking `submit`, the respondent
 will be send a `pamphlet` through the appropriate wire
- The pamphlet will be stored on the Author's ship with the appropriate id

##### View Received Pamphlets
- Pamphlets will be stored on the Author's ship as a `(map id (set pamphlet))`
- Individual pamphlets can be viewed in detail or exported as CSV

##### Deleting a Booklet
- A booklet is allowed to be deleted at anytime. This will also delete
 all submitted pamphlets under the same id stored on the same ship.
