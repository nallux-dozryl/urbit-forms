/-  *forms
|%
++  m-orm   ((on survey-id metadata) gth)
++  c-orm   ((on survey-id questions) gth)
++  q-orm   ((on question-id question) lth)
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action
  =/  data
    %.  jon
    %-  of
      :~
        ::ask+(ot ~[author+so slug+so])
        :-  %create
        %-  ot 
        :~  
          title+so
          description+so 
          visibility+(cu |=(x=@tas ?>(?=(visibility x) `visibility`x)) so) 
          slug+so 
          rlimit+ni
        ==
        :-  %qnew
        %-  ot 
        :~
          surveyid+(cu |=(x=@ta (slav %ud x)) so) 
          qtitle+so 
          front+(cu |=(x=@tas ?>(?=(front x) `front`x)) so) 
          back+(cu |=(x=@tas ?>(?=(back x) `back`x)) so)
          required+bo 
          x+(ar so) 
          y+(ar so)
        ==
        :-  %qedit
        %-  ot
        :~
          surveyid+(cu |=(x=@ta (slav %ud x)) so)
          questionid+ni
          qtitle+so 
          front+(cu |=(x=@tas ?>(?=(front x) `front`x)) so) 
          back+(cu |=(x=@tas ?>(?=(back x) `back`x)) so)
          required+bo 
          x+(ar so) 
          y+(ar so)
        ==
      ==
  ?-  -.data
      %qnew
    `qnew`data
      %create
    `create`data
      %qedit
    `qedit`data
  ==
::      %delete
::      ?>  ?=(action data)  
::      `action`[%delete +6.data (slav %ud +7.data)]
::
++  enjs-update
  |=  upd=frontend
  |^  ^-  json
  ?-  -.upd
      %metas
    ?~  metas.upd  *json
    (make-metas metas.upd)
      %survey
    ^-  json
    :-  %a
    :~
      (make-json-meta [survey-id.upd metadata.upd])
      (make-qs questions.upd)
    ==
  ==
  ++  make-metas
    |=  this-metas=metas
    ^-  json
    :-  %a
    %+  turn
      ^-  (list [survey-id metadata])
      (tap:m-orm this-metas)
    make-json-meta
  ++  make-json-meta
    |=  x=[survey-id metadata]
    =+  d=+.x
    %-  pairs:enjs:format
    :~
      ['id' s+(scot %ud -.x)]
      ['status' s+status.d]
      ['author' (ship:enjs:format author.d)]
      ['slug' s+slug.d]
      ['title' s+title.d]
      ['description' s+description.d]
      ['visibility' s+visibility.d]
      ['spawn' (sect:enjs:format spawn.d)]
      ['updated' (sect:enjs:format updated.d)]
      ['qcount' (numb:enjs:format q-count.d)]
    ==
  ::
  ++  make-qs
    |=  qs=questions
    ?~  qs
      *json
    a+(turn (tap:q-orm qs) q-pairs)
  ::
  ++  q-pairs
    |=  q=[question-id question]
    =+  mq=`question`+.q
    %-  pairs:enjs:format
    :~
      ['qid' (numb:enjs:format -.q)]
      ['qtitle' s+qtitle.mq]
      ['front' s+front.mq]
      ['back' s+back.mq]
      ['required' b+required.mq]
      ['x' a+(turn x.mq |=(z=@t s+z))]
      ['y' a+(turn y.mq |=(z=@t s+z))]
    ==
  --
::
++  make-survey-id
  |=  [now=@da =author]
  ^-  survey-id
  =/  present=@ub  (mul 65.536 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (shaw author 16 author)
  (add present ship-hash)
::
++  create-metas
  |=  [act=create =author t=@da]
  ^-  metadata 
  :*  author
      %live
      slug.act
      title.act
      description.act
      visibility.act
      t
      t
      rlimit.act
      *q-count
  ==
::
::++  clone-survey
::  |=  [act=clone jango=survey =author =spawn]
::  ^-  survey
::
::  :*  author
::      %live
::      slug.act
::      title.act
::      description.act
::      visibility.act
::      spawn-time
::      rlimit.act
::      q-count.jango
::      questions.jango
::  ==
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
