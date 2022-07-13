/-  *forms
/+  *forms
|%
++  enjs-cmd
  |=  upd=cmd
  ^-  json
  upd
::
++  enjs-update
  |=  upd=frontend
  |^  ^-  json
  ?-  -.upd
      %header
    ?~  header.upd
      *json
    (make-header +.upd)
      %active
    :-  %a
    :~
      (make-metadata-1 survey-id.upd metadata.upd)
    (make-sections sections.upd)
    (make-sections draft.upd) 
    ==
      %responses
      =+  nd=+:(del:responses-1-orm responses-1.upd %draft) 
      a+(turn ~(tap by nd) make-responses-1)
      
  ==
  ::
  ++  make-responses-1
    =,  enjs:format
    |=  [k=response-id v=response-1]
    %-  pairs
    :~
      ['rid' s+(scot %ud k)]
      ['author' s+(crip +:(trip (scot %p submitter.v)))]
      ['data' (make-sections sections.v)]
    ==
  ::
  ++  make-sections
    |=  s=sections
    a+(turn (tap:sections-orm s) make-section)
  ::
  ++  make-section
    |=  [k=section-id v=section]
    %-  pairs:enjs:format 
    :~
      ['sid' (numb:enjs:format k)]
      ['sec' a+(turn (tap:section-orm v) make-question)]
    ==
  ::
  ++  make-question
    =,  enjs:format
    |=  [k=question-id v=segment]
    ?-  -.v
        %answer
      %-  pairs
      :~
        ['qid' (numb k)]
        ['head' s+'answer']
        ['accept' s+accept.v]
        ['a' a+(turn a.v |=(a=@t s+a))]
        ['b' a+(turn b.v |=(a=[@t @t] (pairs ~[['x' s+-.a] ['y' s++.a]])))]
        :-  'c' 
        :-  %a
        %+  turn 
          c.v
        |=  a=[@t @t @t]
        (pairs ~[['x' s+-.a] ['y' s++6:a] ['z' s++7:a]])
      ==

        %question
      %-  pairs
      :~
        ['qid' (numb k)]
        ['head' s+'question']
        ['display' s+display.v]
        ['accept' s+accept.v]
        ['required' b+required.v]
        ['min' (numb min.v)]
        ['max' (numb max.v)]
        ['x' a+(turn x.v |=(a=@t s+a))]
        ['y' a+(turn y.v |=(a=@t s+a))]
        ['z' a+(turn z.v |=(a=@t s+a))]
        ['statements' a+(turn statements.v make-statement)]
      ==
    ==
  ::
  ++  make-statement
    |=  a=statement
    %-  pairs:enjs:format
    :~
      ['x' a+(turn x.a |=(x=@t s+x))]
      ['y' a+(turn y.a |=(x=@t s+x))]
      ['z' a+(turn z.a |=(x=@t s+x))]
      ['display' s+display.a]
    ==
  ++  make-header
    |=  h=header
    =+  a=(tap:header-orm h)
    ^-  json
    a+(turn a make-metadata-1)
  ::
  ++  make-metadata-1
    |=  [k=survey-id m=metadata-1]
    %-  pairs:enjs:format
    :~
      ['id' s+(scot %ud k)]
      ['status' s+status.m]
      ['author' s+(crip +:(trip (scot %p author.m)))]
      ['visibility' s+visibility.m]
      ['rlimit' (numb:enjs:format rlimit.m)]
      ['slug' s+slug.m]
      ['title' s+title.m]
      ['description' s+description.m]
      ['updated' (sect:enjs:format updated.m)]
    ==
  --
--
