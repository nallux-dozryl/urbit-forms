|%
::
::  Top Level
::
+$  metas        ((mop survey-id metadata) gth)
+$  content      ((mop survey-id questions) gth)
+$  pending      (set [author slug])
+$  slugs        (map slug survey-id)
+$  subscribers  (map survey-id ships)
::+$  access       (map survey-id [restriction=?(%black %white) =ships])
+$  received     ((mop survey-id responses) gth)
::
::  Main Types
::
+$  survey     [=metadata =questions]
+$  metadata  $:  
                =author
                =status
                =slug
                =title
                =description
                =visibility
                =spawn
                =updated
                =rlimit
                =q-count
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
+$  spawn        @da
+$  updated      @da
+$  q-count      @ud
+$  rlimit       @ud
+$  status       ?(%archived %live)
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
+$  question     [=qtitle =front =back =required x=(list @t) y=(list @t)]
+$  qtitle      @t
+$  required     ?
+$  front     $?
                %statement::
                %short::
                %long::
                %one::
                %many::
                %grid-one
                %grid-many
                %linear-discrete::
                %linear-continuous::
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
                 qnew
                 qedit
::                 clone
::                 delete
::                 [%edit =survey-id edit]
                 ::submit
             ==
+$  qnew    [%qnew =survey-id question]
+$  qedit   [%qedit =survey-id =question-id =question]
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
                 ::[%add-q =q-title =front =back =required =options]
                 [%del-q =question-id]
                 [%move-q old=question-id new=question-id]
                 $:  %edit-q 
                     =question-id 
                     =qtitle 
                     =front 
                     =back 
                     =required 
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
+$  update   $%  [%survey survey]
             ==
+$  frontend  $%
                [%metas =metas]
                [%survey [=survey-id survey]]
              ==
--
