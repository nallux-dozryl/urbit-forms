|%
::
::  Top Level
::
+$  surveys      ((mop survey-id survey) gth)
+$  slugs        (map slug survey-id)
+$  pending      (set [author slug])
::
::  Main Types
::
+$  survey   $:  =author
                 =slug
                 =title
                 =description
                 =visibility
                 =spawn-time
                 =q-count
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
+$  q-count      @ud
::
::  Questions
::
::  the first question will have an id of 1 with every new
::  question having an id of +(id). 
::
::  the count will increase with every new question added, the 
::  agent will always check if the number of questions is the
::  same as the count. The form is considered bricked if the 
::  number of questions does not match up with the count.
::
::  when the position of a question is moved to a higher
::  position (lower id), the selected question will be moved
::  to position 0 and everything in between the old and
::  new position will increment by 1. After that the selected
::  question will be placed in the correct position.
::
::  the same will happen if the inverse happens but instead of
::  increment, the id will be decremented.
::  
::  
::
+$  questions    ((mop question-id question) lth)
+$  question-id  @ud
+$  question     [=q-title =front =back =required =options]
+$  q-title      @t
+$  options  $%  %none
                 [%single column=(list @t)]
                 [%grid row=(list @t) column=(list @t)]
             ==
+$  required     ?
+$  front    $?  %short
                 %long
                 %one
                 %many
                 %grid-one
                 %grid-many
                 %linear-discrete
                 %linear-continuous
                 %calendar
             ==
+$  back     $%  %cord
                 %noun
                 %grid
             ==
::
::  Actions
::
+$  action   $%  create
                 delete
                 [%edit =survey-id edit]
::                 [%question =survey-id q-action]
                 ::submit
             ==
::
+$  create       [%create =title =description =visibility =slug]
+$  delete       [%delete =survey-id]
+$  edit     $%  [%title =title]
                 [%description =description]
                 [%visibility =visibility]
                 [%slug =slug]
             ==
+$  q-action  $%  [%add =q-title =front =back =required =options]
                  [%delete =question-id]
              ==

::
::  Requests
::  
+$  request  $%  ask
                 send-slug
                 send-id
             ==
::
+$  ask          [%ask =author =slug]
+$  send-slug    [%slug =slug]
+$  send-id  $%  [%id =slug =survey-id]
                 [%fail =slug]
             ==
::
::  Updates
::
+$  update   $%  [%survey =survey]
                 [%leave =survey-id]
                 [%edit edit]
::                 [%question =q-action]
             ==
--
