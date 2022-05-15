|%
::
::  Top Level
::
+$  surveys   ((mop survey-id survey) gth)
+$  slugs     (map slug survey-id)
+$  pending   (set [author slug])
::
::  Main Types
::
+$  survey
  $:  =author
      =slug
      =title
      =description
      =visibility
      =questions
  ==
::
::  Basic Types
::
+$  survey-id    @ud
+$  author       ship
+$  slug         @ta
+$  title        @t
+$  description  @t
+$  visibility   ?(%public %private %team)
+$  spawn-time   @da
::
::  Questions
::
+$  question   @t 
+$  questions  (map question-id=@ud question)  
::
::  Actions
::
+$  action
  $%  create
       ::edit
       ::delete
       ::submit
      ask
      send-slug
      send-id
::      request
      unsub
  ==
+$  create       [%create title=@t description=@t =visibility =slug]
::+$  delete   [%delete =sv-author =sv-id]
+$  ask          [%ask =author =slug]
+$  send-slug    [%slug =slug]
+$  send-id  $%  [%id =slug =survey-id]
                 [%fail =slug]
             ==
+$  unsub    [%unsub =author =survey-id]

::  Updates
+$  update
  $%  [%survey =survey]
  ==
--
