/-  *forms
|%
++  s-orm   ((on survey-id survey) gth)
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
      :-  %create 
      (ot ~[title+so description+so visibility+so slug+so rlimit+ni])
      :-  %ask
      (ot ~[author+so slug+so])
    ==
    ?-  -.data
      %create
      ?>  ?=(action data)  `action`data
      ::
      %ask
      =/  =author  `@p`(slav %p +6.data)
      `action`[%ask author +7.data]
    ==
::
++  enjs-update
  |=  upd=update
  |^  ^-  json
  ?-  -.upd
      %survey  
    *json
      %live
    (make-json surveys.upd)
  ==
  ++  make-json
    |=  this-surveys=surveys
    ^-  json
    %-  pairs:enjs:format 
    %+  turn 
      `(list [survey-id survey])`(tap:s-orm this-surveys) 
    make-pairs
  ::
  ++  make-pairs
    |=  x=[survey-id survey]
    :-  (scot %ud -.x)  
    (mini-pairs +.x)
  ::
  ++  mini-pairs
    |=  mini=survey
    %-  pairs:enjs:format
    :~
      ['author' (ship:enjs:format author.mini)]
      ['slug' s+slug.mini]
      ['title' s+title.mini]
      ['description' s+description.mini]
      ['visibility' s+visibility.mini]
      ['spawn-time' (sect:enjs:format spawn-time.mini)]
      ['q-count' n+(scot %ud q-count.mini)]
      ['questions' (make-qs questions.mini)]
    ==
  ::
  ++  make-qs
    |=  qs=questions
    ?~  qs
      *json
    (pairs:enjs:format (turn (tap:q-orm qs) q-pairs))
  ::
  ++  q-pairs
    |=  q=[question-id question]
    :-  (scot %ud -.q)
    (mini-q +.q)
  ::
  ++  mini-q
    |=  mq=question
    %-  pairs:enjs:format
    :~
      ['q-title' s+q-title.mq]
      ['front' s+front.mq]
      ['back' s+back.mq]
      ['required' b+required.mq]
      ['options' (check-options options.mq)]
    ==
  ::
  ++  check-options
    |=  ops=options
    ?-  -.ops
        %single
      %-  frond:enjs:format 
      ['column' a+(turn column.ops |=(x=@t s+x))]
        %grid
      %-  pairs:enjs:format 
      :~
        ['row' a+(turn row.ops |=(x=@t s+x))]
        ['column' a+(turn column.ops |=(x=@t s+x))]
      ==
    ==
  --
::
++  make-survey-id
  |=  [now=@da =author]
  ^-  survey-id
  =/  present=@ub  (mul 4.294.967.296 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (shaw author 32 author)
  (add present ship-hash)
::
++  create-survey
  |=  [act=create =author =spawn-time]
  ^-  survey
  :*  author
      slug.act
      title.act
      description.act
      visibility.act
      spawn-time
      rlimit.act
      *q-count
      *questions
  ==
::
++  clone-survey
  |=  [act=clone jango=survey =author =spawn-time]
  ^-  survey

  :*  author
      slug.act
      title.act
      description.act
      visibility.act
      spawn-time
      rlimit.act
      q-count.jango
      questions.jango
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
