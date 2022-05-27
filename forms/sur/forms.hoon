|%
::
::  Top Level
::
+$  surveys      ((mop survey-id survey) gth)
+$  defunct      ((mop survey-id survey) gth)
+$  slugs        (map slug survey-id)
+$  pending      (set [author slug])
+$  subscribers  (map survey-id ships)
+$  access       (map survey-id [restriction=?(%black %white) =ships])
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
                   =rlimit
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
+$  visibility   ?(%public %private %team %restricted)
+$  spawn-time   @da
+$  q-count      @ud
+$  rlimit       @ud
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
+$  action   $%  [%ask =author =slug]
                 create
::                 clone
::                 delete
::                 [%edit =survey-id edit]
                 ::submit
             ==
::
+$  create       $:  %create 
                     =title 
                     =description 
                     =visibility 
                     =slug
                     =rlimit
                 ==
+$  clone        $:  %clone
                     =status
                     =survey-id
                     =title
                     =description
                     =visibility
                     =slug
                     =rlimit
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
+$  request  $%  send-slug
                 send-id
             ==
::
+$  send-slug    [%slug =slug]
+$  send-id  $%  [%id =slug =survey-id]
                 [%fail =slug]
             ==
::
::  Updates
::
+$  update   $%  [%survey =survey]
                 [%live =surveys]
             ==
--
