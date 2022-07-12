/-  one=forms
|%
+$  metas  ((mop survey-id:one metadata) gth)
+$  content  ((mop survey-id:one questions) gth)
+$  results  ((mop survey-id:one responses) gth)
+$  responses  ((mop response-id:one response) gth)
+$  response   [=author:one =answers]
+$  metadata
  $:
    =author:one
    =status:one
    =slug:one
    =title:one
    =description:one
    =visibility:one
    =spawn:one
    =updated:one
    =rlimit:one
    =q-count
  ==
+$  q-count  @ud
+$  answers  ((mop question-id:one answer) lth)
+$  answer
  $%
    agrid
    atext
    alist
  ==
+$  agrid  [%grid (list [@t @t])]
+$  atext  [%text @t]
+$  alist  [%list (list @t)]
::
::  Questions
::
+$  questions  ((mop question-id:one question) lth)
+$  question-id  @ud
+$  question  [=qtitle =front =back =required x=(list @t) y=(list @t)]
+$  qtitle  @t
+$  required  ?
+$  front
  $?
    %statement
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
+$  back     
  $?
    %text
    %list
    %grid
  ==
--
