/-  *forms
|%
++  make-survey-id
  |=  now=@da
  ^-  sv-id
  (unm:chrono:userlib now)
++  create-survey
  |=  act=create
  ^-  survey
  =|  surv=survey
  =.  surv  (~(put by surv) 'title' title.act)
  =.  surv  (~(put by surv) 'description' description.act)
  =.  surv  (~(put by surv) 'visibility' visibility.act)
  =.  surv  (~(put by surv) 'slug' slug.act)
  =.  surv  (~(put by surv) 'questions' *questions)
  surv
  
++  remove-json
  |=  data=json
  data
::(crip (en-json:html data))
::  ((op so):dejs:format data)
--
