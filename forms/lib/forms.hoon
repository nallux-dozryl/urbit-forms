/-  *forms
|%
++  s-orm   ((on survey-id survey) gth)
++  q-orm   ((on question-id question) lth)
++  make-survey-id
  |=  [now=@da =author]
  ^-  survey-id
  =/  present=@ub  (mul 4.294.967.296 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (shaw author 32 author)
  (add present ship-hash)

++  create-survey
  |=  [act=create =author =spawn-time]
  ^-  survey
  :*  author
      slug.act
      title.act
      description.act
      visibility.act
      spawn-time
      *q-count
      *questions
  ==
++  add-subs
  |=  [subs=subscribers id=survey-id =ship]
  ^-  subscribers
  =+  ships=(need (~(get by subs) id))
  (~(put by subs) id (~(put in ships) ship))
::
--
