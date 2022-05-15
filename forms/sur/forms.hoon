|%
::
::  Top Level
::
+$  surveys  ((mop survey-id survey) gth)
+$  slugs    (map slug survey-id)
+$  pending  (set [author slug])
::
::  Main Types
::
+$  survey
  $:  =author
      =slug
      =title
      =description
      =visibility
      =spawn-time
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
      delete
       ::submit
  ==
+$  create  [%create title=@t description=@t =visibility =slug]
+$  delete  [%delete =survey-id]
::
::  Requests
::  
+$  request
  $%  ask
      send-slug
      send-id
  ==
+$  ask        [%ask =author =slug]
+$  send-slug  [%slug =slug]
+$  send-id
  $%  [%id =slug =survey-id]
      [%fail =slug]
  ==
::
::  Updates
::
+$  update
  $%  [%survey =survey]
      [%leave =survey-id]
  ==
--
