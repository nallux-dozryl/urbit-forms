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
+$  questions  (map question-id question)  
+$  question-id  @ud
+$  question     @t
::
::  Actions
::
+$  action
  $%  create
      delete
      [%edit =survey-id edit]
      ::submit
  ==
+$  create  [%create =title =description =visibility =slug]
+$  delete  [%delete =survey-id]
+$  edit
  $%  [%title =title]
      [%description =description]
      [%visibility =visibility]
      [%slug =slug]
  ==
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
      [%edit edit]
  ==
--
