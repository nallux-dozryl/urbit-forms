/-  *forms
|%
++  header-orm   ((on survey-id metadata-1) gth)
++  stuffing-orm  ((on survey-id sections) gth)
++  submissions-orm  ((on survey-id responses-1) gth)
++  sections-orm  ((on section-id section) lth)
++  section-orm   ((on question-id segment) lth)
++  make-survey-id
  |=  [now=@da =author]
  ^-  survey-id
  =/  present=@ub  (mul 65.536 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (shaw author 16 author)
  (add present ship-hash)
++  create-metadata-1
  |=  [c=create a=author t=@da]
  ^-  metadata-1
  [a %live slug.c title.c description.c visibility.c t t rlimit.c [~[0] 1]]
++  add-subs
  |=  [subs=subscribers id=survey-id =ship]
  ^-  subscribers
  =+  ships=(~(got by subs) id)
  (~(put by subs) id (~(put in ships) ship))
++  check-response
  |=  [q=sections a=sections]
  ::  turn section keys into list
  ::  loop through each key and loop again for each question
  ::  all passed answers is put into a new mop
  ::  all failed answers put into another mop
  ::  if no failed answers, submit response
  ::  if failed answers, prompted front end regarding fucked up
  ::  questions.
  =+  secs=(sort `(list @ud)`~(tap in ~(key by q)) lth)
  |-
  =+  qs=(got:sections-orm q +2:secs)
  =+  as=(got:sections-orm a +2:secs)
  (compare-q-a qs as)
++  compare-q-a
  |=  [q=section a=section]
  =+  qs=(sort `(list @ud)`~(tap in ~(key by q)) lth)
  ~&  >>
  =+  cuq=(got:section-orm q +2:qs)
  =+  [failed=*(list) succeeded=*(list)]
  |-
  ?+  -.cuq  !!
      %question
    =+  qac=accept.cuq
    =+  req=required.cuq
    ?:  =((lent qs) 0)  
      [failed=(flop failed) succeeded=(flop succeeded)]
    =+  ucua=(get:section-orm a +2:qs)
    ?+  (check-answer qac req ucua)  !!
        %failed
      $(failed [+2:qs failed], qs +3:qs)
        %succeed
      $(succeeded [+2:qs succeeded], qs +3.qs)
    ==
  ==
  qs
++  check-answer
  |=  [qac=@tas req=? ucua=(unit segment)]
  ?~  ucua
    ?:  req
      `@tas`%failed
    `@tas`%succeed
  =+  cua=(need ucua)
  ?+  -.cua  !!
      %answer
    ?.  =(qac accept.cua)
      `@tas`%failed
    ?.  req
      `@tas`%succeed
    ?+  accept.cua  `@tas`%failed
        %text
      ?:  =('' (snag 0 a.cua))
        `@tas`%failed
      `@tas`%succeed
    ==
  ==

    



--
