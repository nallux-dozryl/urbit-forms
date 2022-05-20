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
++  move-q-up-after-delete
  |=  [qs=questions qid=question-id =q-count]
  ?:  (gth qid q-count)  qs
  =/  current=question  (need (get:q-orm qs qid))
  =/  undeleted=questions  (put:q-orm qs (dec qid) current)
  =/  new-questions=questions  +:(del:q-orm undeleted qid)
  $(qid +(qid), qs new-questions)
::
++  move-qs-down
  |=  [current=question qs=questions old=question-id new=question-id]
  ?:  (lte old new)  (put:q-orm qs new current)
  =/  unmoved=question  (need (get:q-orm qs (dec old)))
  =/  moved=questions  (put:q-orm qs old unmoved)
  $(qs moved, old (dec old))
::
++  move-qs-up
  |=  [current=question qs=questions old=question-id new=question-id]
  ?:  (gte old new)  (put:q-orm qs new current)
  =/  unmoved=question  (need (get:q-orm qs +(old)))
  =/  moved=questions  (put:q-orm qs old unmoved)
  $(qs moved, old +(old))


--
