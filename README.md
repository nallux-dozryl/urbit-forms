# Urbit Forms
Create forms and surveys with multiple question types.

## Introduction
This document will be split into 2 parts. The agent, which is the hoon code and
 the view, the glob for displaying the app.

## Agent

### Types
On the top level:
- `surveys`: the survey store, all forms goes here.
- `responses`: the response store, all responses goes here.

#### $surveys
This is a map of `author=ship` and a mop of `survey-id` and `survey` sorted by
 `gth`.
```
+$  surveys  (map author ((mop survey-id survey) gth))
```  

#### $responses
This is a mop of `survey-id` and a map of `author` and mop of `response-id` and `response`
 sorted by `gth` sorted by `lth`. *sorry for this description*
```
+$  responses  ((mop survey-id (map author ((mop response-id response) gth))) lth)
```

#### $survey
A survey is a json containing:
- `title`: `@t -> %s`
- `description`: `@t -> %s`
- `visibility`: `?(%public %private %team) -> %s`
- `slug`: `@ta -> %s`
- `questions`: `((mop question-id question) gth) -> %o`

#### $response
A response is a json containing a mop of `question-id` and `answer` sorted by gth
```
((mop question-id answer) gth) -> %o
```

#### $question
lorem ipsum

#### $answer
lorem ipsum


### Actions
lorem ipsum

### Updates
lorem ipsum

## View
lorem ipsum

## Miscellaneous

### Contact, Issues, Requests, Feedback
`~donpub-datdux/gerhana-network`
