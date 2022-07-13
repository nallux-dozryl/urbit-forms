|%
::
::  Top Level
::
::::::+$  access  (map survey-id [restriction=?(%black %white) =ships])
+$  slug-store   (map ship slugs)
+$  pending      (set [author slug])
+$  slugs        (map slug survey-id)
+$  subscribers  (map survey-id ships)
::
::  header - previously metas
::
+$  header  ((mop survey-id metadata-1) gth)
+$  metadata-1
  $:  
    =author
    =status
    =slug
    =title
    =description
    =visibility
    =spawn
    =updated
    =rlimit
    =size
  ==
+$  size  [q=(list @ud) s=@ud]

::
::  stuffing - previously content
::
+$  stuffing  ((mop survey-id sections) gth)
+$  sections  ((mop section-id section) lth)
+$  section   ((mop question-id segment) lth)
+$  segment
  $%
    answer-1
    question-1
  ==
+$  section-id  @ud
+$  statement
  $:
    x=(list @t)
    y=(list @t)
    z=(list @t)
    display=@tas 
  ==
+$  question-1
  $:
    %question
    display=@tas
    accept=@tas
    required=?
    min=@ud
    max=@ud
    x=(list @t)
    y=(list @t)
    z=(list @t)
    statements=(list statement)
  ==
+$  submissions  ((mop survey-id responses-1) gth)
+$  responses-1  ((mop response-id response-1) gth)
+$  response-1   [=submitter =sections]
+$  submitter  ?(ship %anon)
+$  answer-1  [%answer accept=@tas datum]
+$  datum  [a=(list @t) b=(list [@t @t]) c=(list [@t @t @t])]
+$  survey  [=metadata-1 =sections]
::
::  Basic Types
::
+$  survey-id    @ud
+$  response-id  ?(@ud %draft)
+$  ships        (set ship)
+$  author       ship
+$  slug         @ta
+$  title        @t
+$  description  @t
+$  visibility   ?(%public %private %team %restricted)
+$  spawn        @da
+$  updated      @da
+$  rlimit       @ud
+$  status       ?(%archived %live)
+$  question-id  @ud
::
::  Edits
::
+$  edit
  $%
    [%title =survey-id =title]
    [%description =survey-id =description]
    [%slug =survey-id =slug]
    [%visibility =survey-id =visibility]
    [%rlimit =survey-id =rlimit]
    [%addsection =survey-id =section-id]
    [%delsection =survey-id =section-id]
    [%addquestion =survey-id =section-id =question-id =question-1]
    [%delquestion =survey-id =section-id =question-id]
  ==
::
::  Actions
::
+$  action
  $%  
    ask
    create
    delete
    [%editdraft =survey-id =section-id =question-id =answer-1]
    submit
    [%delsubmission =survey-id =response-id]
  ==
+$  ask     [%ask =author =slug]
+$  create  [%create =title =description =visibility =slug =rlimit]
+$  delete  [%delete =survey-id]
+$  submit  [%submit =survey-id]
::
::  Requests
::  
+$  request
  $%  
    [%slug =slug]
    [%id =slug =survey-id]
    [%fail =slug]
    [%response =survey-id =response-id =response-1]
  ==
::
::  Updates
::
+$  update   $% 
                [%init metadata=metadata-1 =sections]
                [%meta metadata=metadata-1]
                [%secs =sections]
::                [%questions =questions]
::                [%survey survey]
             ==
+$  frontend  
  $%
    [%header =header]
    [%responses =responses-1]
    [%active =survey-id metadata=metadata-1 =sections draft=sections]
  ==
::
+$  cmd  json
--
