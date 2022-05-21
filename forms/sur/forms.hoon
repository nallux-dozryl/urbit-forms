|%
::
::  Top Level
::
+$  surveys      ((mop survey-id survey) gth)
+$  defunct      ((mop survey-id survey) gth)
+$  slugs        (map slug survey-id)
+$  pending      (set [author slug])
+$  subscribers  (map survey-id ships)
::  
::  Splitting these 3 to their own categories actually makes it
::  easier to handle. Whenever a survey is being filled, the
::  state that gets updated would be in draft.
::
::  Once %submit is called, the agent will check if the response
::  matches the questions asked. If something is amiss, an error
::  is thrown and the state doesn't get updated.
::
::  If everything is correct, send the response as a poke to the
::  survey author and move the response to submitted.
::
::  The author will receive the response in received.
::
+$  draft        ((mop survey-id responses) gth)
+$  submitted    ((mop survey-id responses) gth)
+$  received     ((mop survey-id responses) gth)
::
::  Main Types
::
+$  survey     $:  =author
                   =slug
                   =title
                   =description
                   =visibility
                   =spawn-time
                   =q-count
                   =questions
               ==
+$  responses  ((mop response-id response) gth)
+$  response   $:  =author
                   =survey-id
                   =answers
               ==
::
::  Basic Types
::
+$  survey-id    @ud
+$  response-id  @ud
+$  ships        (set ship)
+$  author       ship
+$  slug         @ta
+$  title        @t
+$  description  @t
+$  visibility   ?(%public %private %team)
+$  spawn-time   @da
+$  q-count      @ud
+$  status       ?(%defunct %live)
::
::  Answers
::
+$  answers     ((mop question-id answer) lth)
+$  answer  $%  [%single choice=(list @t)]
                [%grid choice=(list (list @t))]
            ==
::
::  Questions
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
+$  front    $?  %statement
                 %short
                 %long
                 %one
                 %many
                 %grid-one
                 %grid-many
                 %linear-discrete
                 %linear-continuous
                 %calendar
             ==
+$  back     $?  %text
                 %noun
                 %grid
             ==
::
::  Actions
::
+$  action   $%  create
                 clone
                 delete
                 [%edit =survey-id edit]
                 ::submit
             ==
::
+$  create       [%create =title =description =visibility =slug]
+$  clone        $:  %clone
                     =status
                     =survey-id
                     =title
                     =description
                     =visibility
                     =slug
                 ==
+$  delete       [%delete =status =survey-id]
+$  edit     $%  [%title =title]
                 [%description =description]
                 [%visibility =visibility]
                 [%slug =slug]
                 [%add-q =q-title =front =back =required =options]
                 [%del-q =question-id]
                 [%move-q old=question-id new=question-id]
                 $:  %edit-q 
                     =question-id 
                     =q-title 
                     =front 
                     =back 
                     =required 
                     =options
                 ==
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
             ==
--
