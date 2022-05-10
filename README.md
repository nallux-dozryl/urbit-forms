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
A survey is a json object containing:
- `title`: `@t -> %s`
- `description`: `@t -> %s`
- `visibility`: `?(%public %private %team) -> %s`
- `slug`: `@ta -> %s`
- `questions`: `((mop question-id question) gth) -> %o`

#### $response
A response is a json object containing a mop of `question-id` and `answer` sorted by gth
```
((mop question-id answer) gth) -> %o
```

#### $question
A question is a json object containing:
- `title`: this is the question itself `@t -> %s`
- `options`: these are the choices provided `set -> %a of %s`
- `front`: the component type that gets rendered in the view `@tas -> %s`
- `back`: the type of value the agent accepts for this question `@tas -> %s`

#### $answer
An answer is a json object with the back type as the key and the written answer
 as the value.
```
eg. [%o p={[p='noun' q=[%s p='this is my answer']]}]
```

### Actions
lorem ipsum

### Updates
lorem ipsum

## View
lorem ipsum

## Miscellaneous

### Contact, Issues, Requests, Feedback
`~donpub-datdux/gerhana-network`
