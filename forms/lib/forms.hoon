/-  *forms
|%
++  header-orm   ((on survey-id metadata-1) gth)
++  stuffing-orm  ((on survey-id sections) gth)
++  submissions-orm  ((on survey-id responses-1) gth)
++  responses-1-orm  ((on response-id response-1) gth)
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
++  make-response-id
  |=  [now=@da =author =survey-id]
  ^-  response-id
  =/  present=@ub  (mul 4.294.967.296 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (mul 65.536 (shaw author 16 author))
  =/  survey-hash=@ub  (shaw survey-id 16 survey-id)
  :(add present ship-hash survey-hash)
++  check-response
  |=  [q=sections a=sections]
  =+  res=*(list [sec=@ud [failed=(list @ud) succeeded=(list @ud)]])
  =+  secs=(sort `(list @ud)`~(tap in ~(key by q)) lth)
  |-
  ?:  =(0 (lent secs))
    ^-  (list [sec=@ud [failed=(list @ud) succeeded=(list @ud)]])
    (flop res)
  =+  qs=(got:sections-orm q +2:secs)
  =+  uas=(get:sections-orm a +2:secs)
  =+  as=?~(uas *section (need uas))
  $(res [[sec=i:+2:secs (compare-q-a qs as)] res], secs +3:secs)
++  compare-q-a
  |=  [q=section a=section]
  =+  qs=(sort `(list @ud)`~(tap in ~(key by q)) lth)
  =+  [failed=*(list @ud) succeeded=*(list @ud)]
  |-
  ?:  =((lent qs) 0)  
    [failed=(flop failed) succeeded=(flop succeeded)]
  =+  cuq=(got:section-orm q +2:qs)
  ?+  -.cuq  !!
      %question
    =+  qac=accept.cuq
    =+  req=required.cuq
    =+  ucua=(get:section-orm a +2:qs)
    ?+  (check-answer qac req ucua)  !!
        %failed
      $(failed [+2:qs failed], qs +3:qs)
        %succeed
      $(succeeded [+2:qs succeeded], qs +3:qs)
    ==
  ==
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
      ?~  a.cua
        `@tas`%failed
      ?:  =('' (snag 0 `(list @t)`a.cua))
        `@tas`%failed
      `@tas`%succeed
        %list
      ?:  (lte (lent a.cua) 0)
        `@tas`%failed
      `@tas`%succeed
        %grid
      ?:  (lte (lent b.cua) 0)
        `@tas`%failed
      `@tas`%succeed
    ==
  ==

    



--
