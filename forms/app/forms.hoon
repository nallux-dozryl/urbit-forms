/-  *forms-states, *forms
/+  default-agent, dbug, upgrade, fl=forms
|%
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-1
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this(slug-store (~(put by slug-store) our.bowl *slugs))
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %1  `this(state old)
    %0  `this(state (convert-0-to-1:upgrade old our.bowl))
  ==
::
++  on-watch 
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
      [%header %all ~]
    :_  this
    ~[give+fact+`forms-cmd+!>(`cmd`(frond:enjs:format ['flag' s+'refresh']))]
    ::
      [%survey @ ~]
    =/  id=survey-id   (slav %ud i.t.path)
    =+  m=(got:header-orm:fl header id)
    ?>  =(%public visibility.m)
    =+  s=(got:stuffing-orm:fl stuffing id)
    :_  this(subscribers (add-subs:fl subscribers id src.bowl))
    :~  :*
      %give  %fact   ~
      %forms-update  !>  `update`init+[m s]
    ==  ==
  ==
::
++  on-leave  on-leave:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %header ~]
    ``forms-json+!>(`frontend`header+header)
      [%x %active @ @ ~]
    =+  g=(~(got by slug-store) (slav %p i.t.t.path))
    =+  id=(~(got by g) i.t.t.t.path)
    =+  m=(got:header-orm:fl header id)
    =+  s=(got:stuffing-orm:fl stuffing id)
    =+  sb=(got:submissions-orm:fl submissions id)
    =+  d=sections:(~(got by sb) %draft)
    ``forms-json+!>(`frontend`active+[id m s d])

  ==
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+  mark  (on-poke:def mark vase)
      %forms-action
    =^  cards  state
      (handle-action !<(action vase))
    [cards this]
    ::
      %forms-request
    =^  cards  state
      (handle-request !<(request vase))
    [cards this]
    ::
      %forms-edit
    =^  cards  state
      (handle-edit !<(edit vase))
    [cards this]

  ==
  ++  handle-action
    |=  act=action
    ^-  (quip card _state)
    ?>  =(src our):bowl
    ?-  -.act
        %create
      =+  id=(make-survey-id:fl now.bowl our.bowl) 
      =,  enjs:format
      =+  sl=(~(got by slug-store) our.bowl)
      ?>  =(~ (~(get by sl) slug.act))
      =+  m=(create-metadata-1:fl act our.bowl now.bowl)
      =+  g=(~(put by sl) slug.act id)
      =+  gg=(~(put by slug-store) our.bowl g)
      =+  h=(put:header-orm:fl header id m)
      =+  sc=(put:section-orm:fl *section 1 *question-1)
      =+  ss=(put:sections-orm:fl *sections 1 *section)
      =+  st=(put:stuffing-orm:fl stuffing id ss)
      =+  sb=(~(put by subscribers) id *ships)
      =+  rc=(put:section-orm:fl *section 1 *answer-1)
      =+  rp=(put:sections-orm:fl *sections 1 *section)
      =+  rs=(~(put by *responses-1) %draft [our.bowl rp])
      =+  sm=(put:submissions-orm:fl submissions id rs)
      :-  
      :~  :*
        %give  %fact  ~[/header/all]
        %forms-cmd  !>
        `cmd`(pairs ~[['flag' s+'ask'] ['id' s+(scot %ud id)]])
      ==  ==
      state(header h, slug-store gg, stuffing st, subscribers sb, submissions sm)
        ::
        %ask
      :_  state(pending (~(put in pending) [author.act slug.act]))
      :~  :*
        %pass   /slug
        %agent  [author.act %forms]
        %poke   %forms-request  !>  slug+slug.act
      ==  ==
        ::
        %delete
      =+  m=(got:header-orm:fl header survey-id.act)
      =+  h=+:(del:header-orm:fl header survey-id.act)
      =+  s=+:(del:stuffing-orm:fl stuffing survey-id.act)
      =+  sb=+:(del:submissions-orm:fl submissions survey-id.act)
      =+  sl=(~(got by slug-store) our.bowl)
      =+  g=(~(del by sl) slug.m)
      =+  gg=(~(put by slug-store) our.bowl g)
      ?.  =(our.bowl author.m)
        :_  state(header h, stuffing s, submissions sb, slug-store gg)
        :~  :*
          %pass   /updates/(scot %ud survey-id.act)
          %agent  [author.m %forms]
          %leave  ~
        ==  ==
        =+  sr=(~(get by subscribers) survey-id.act)
        =+  sd=(~(del by subscribers) survey-id.act)
        ?~  sr
          `state(header h, stuffing s, submissions sb, slug-store gg)
        =+  sn=~(tap in (need sr))
        ?~  sn
          `state(header h, stuffing s, submissions sb, slug-store gg, subscribers sd)
        :_  state(header h, stuffing s, submissions sb, slug-store gg, subscribers sd)
        (turn sn |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.act)] `a]))
        ::
        %editdraft
      =+  sb=(got:submissions-orm:fl submissions survey-id.act)
      =+  sd=(~(got by sb) %draft)
      =+  sc=(get:sections-orm:fl sections.sd section-id.act)
      =+  x=?~(sc *section (need sc))
      =+  a=(put:section-orm:fl x question-id.act answer-1.act)
      =.  sections.sd
        (put:sections-orm:fl sections.sd section-id.act a)
      =+  se=(~(put by sb) %draft sd)
      =+  sn=(put:submissions-orm:fl submissions survey-id.act se)
      `state(submissions sn)
        %submit
      =+  st=(got:stuffing-orm:fl stuffing survey-id.act)
      =+  sb=(got:submissions-orm:fl submissions survey-id.act)
      =+  rs=(~(got by sb) %draft)
      ?:  =(~ (check-response:fl st +.rs))
        `state
      `state
    ==
    ++  handle-edit
    |=  ed=edit
    ^-  (quip card _state)
    ?>  =(src our):bowl
    =+  m=(got:header-orm:fl header survey-id.ed)
    =.  updated.m
      now.bowl
    ?-  -.ed
        %addsection
      =+  so=(got:stuffing-orm:fl stuffing survey-id.ed)
      =+  sc=(put:sections-orm:fl so section-id.ed *section)
      =+  sn=(put:stuffing-orm:fl stuffing survey-id.ed sc)
      =.  s.size.m
        +(s.size.m)
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h, stuffing sn)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`secs+sc
      ==  ==
        ::
        %delsection
      =+  so=(got:stuffing-orm:fl stuffing survey-id.ed)
      =+  sid=section-id.ed
      ?<  (gth sid s.size.m)  
      =.  q.size.m
        (oust [(dec sid) 1] q.size.m)
      ?:  =(sid s.size.m)
        =+  st=+:(del:sections-orm:fl so sid)
        =.  s.size.m
          (dec sid)
        =+  sn=(put:stuffing-orm:fl stuffing survey-id.ed st)
        =+  h=(put:header-orm:fl header survey-id.ed m)
        :_  state(stuffing sn, header h)
        :~  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`meta+m
        ==  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`secs+st
        ==  ==
      |-
      ?.  (gte sid s.size.m)
        =+  st=(got:sections-orm:fl so +(sid))
        =+  sn=(put:sections-orm:fl so sid st) 
        $(so sn, sid +(sid))
      =+  st=+:(del:sections-orm:fl so sid)
      =.  s.size.m
        (dec sid)
      =+  sn=(put:stuffing-orm:fl stuffing survey-id.ed st)
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(stuffing sn, header h)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`secs+st
      ==  ==
        ::
        %delquestion
      =+  so=(got:stuffing-orm:fl stuffing survey-id.ed)
      =+  sc=(got:sections-orm:fl so section-id.ed)
      =+  n=(lent (tap:section-orm:fl sc))
      =.  q.size.m
        (snap q.size.m (dec section-id.ed) (dec (snag (dec section-id.ed) q.size.m)))
      ?:  =(n question-id.ed)
        =+  sn=+:(del:section-orm:fl sc question-id.ed)
        =+  ss=(put:sections-orm:fl so section-id.ed sn)
        =+  st=(put:stuffing-orm:fl stuffing survey-id.ed ss)
        =+  h=(put:header-orm:fl header survey-id.ed m)
        :_  state(header h, stuffing st)
        :~  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`meta+m
        ==  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`secs+ss
        ==  ==
      =+  qid=question-id.ed
      |-
      ?.  =(qid n)
        =+  q=(got:section-orm:fl sc +(qid))
        =+  sn=(put:section-orm:fl sc qid q)
        $(sc sn, qid +(qid))
      =+  sn=+:(del:section-orm:fl sc qid)
      =+  ss=(put:sections-orm:fl so section-id.ed sn)
      =+  st=(put:stuffing-orm:fl stuffing survey-id.ed ss)
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h, stuffing st)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`secs+ss
      ==  ==
        ::
        %addquestion
      =+  s=(got:stuffing-orm:fl stuffing survey-id.ed)
      =+  sc=(got:sections-orm:fl s section-id.ed)
      =+  q=(get:section-orm:fl sc question-id.ed)
      =+  qn=(put:section-orm:fl sc question-id.ed question-1.ed)
      =+  sn=(put:sections-orm:fl s section-id.ed qn)
      =+  st=(put:stuffing-orm:fl stuffing survey-id.ed sn)
      ?~  q
        =.  q.size.m
          %^    snap 
              q.size.m
            (dec section-id.ed)
          +((lent (tap:section-orm:fl sc)))
        =+  h=(put:header-orm:fl header survey-id.ed m)
        :_  state(header h, stuffing st)
        :~  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`meta+m
        ==  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`secs+sn
        ==  ==
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h, stuffing st)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`secs+sn
      ==  ==
        ::
        %title
      =.  title.m
        title.ed
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  ==
        ::
        %description
      =.  description.m
        description.ed
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  ==
        ::
        %rlimit
      =.  rlimit.m
        rlimit.ed
      =+  h=(put:header-orm:fl header survey-id.ed m)
      :_  state(header h)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  ==
        ::
        %slug
      =+  sl=(~(got by slug-store) our.bowl)
      =+  e=(~(del by sl) slug.m)
      =.  slug.m
        slug.ed
      =+  h=(put:header-orm:fl header survey-id.ed m)
      =+  g=(~(put by e) slug.ed survey-id.ed)
      =+  gg=(~(put by slug-store) our.bowl g)
      :_  state(header h, slug-store gg)
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
        %forms-update  !>  `update`meta+m
      ==  ==
        ::
        %visibility
      =.  visibility.m
        visibility.ed
      =+  h=(put:header-orm:fl header survey-id.ed m)
      ?.  =(%private visibility.ed)
        :_  state(header h)
        :~  :*
          %give  %fact  [/survey/(scot %ud survey-id.ed) ~]
          %forms-update  !>  `update`meta+m
        ==  ==
      =+  s=~(tap in (~(got by subscribers) survey-id.ed))
      =+  ns=(~(put by subscribers) survey-id.ed *ships)
      :_  state(header h, subscribers ns)
      ?:  =(0 (lent s))  ~
      (turn s |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.ed)] `a]))
    ==
    ::
  ++  handle-request
    |=  req=request
    ^-  (quip card _state)
    ?-  -.req
        %slug
      =+  g=(~(got by slug-store) our.bowl)
      =+  id=(~(get by g) slug.req)
      :_  state
      :~  :*
        %pass   /slug
        %agent  [src.bowl %forms]
        %poke   %forms-request  !>
        ?~  id  
          fail+slug.req  
          ?:  =(%public visibility:(got:header-orm:fl header (need id)))
            id+[slug.req (need id)]
          fail+slug.req  
        ==  ==
      ::
        %fail
      %-  (slog leaf+"forms doesn't exist!" ~)
      :-
      :~  :*
        %give  %fact  ~[/header/all]
        %forms-cmd  !>
        `cmd`(pairs:enjs:format ~[['flag' s+'requested'] ['status' s+'fail']])
      ==  ==
      state(pending (~(del in pending) [src.bowl slug.req]))
      ::
        %id
      =+  p=(~(del in pending) [src.bowl slug.req])
      =+  g=(~(get by slug-store) src.bowl)
      =+  sl=?~(g *slugs (need g))
      =+  s=(~(put by sl) slug.req survey-id.req)
      =+  gg=(~(put by slug-store) src.bowl s)
      :_  state(pending p, slug-store gg)
      :~  :*
        %give  %fact  ~[/header/all]
        %forms-cmd  !>
        =,  enjs:format
        ^-  cmd
        (pairs ~[['flag' s+'requested'] ['status' s+(scot %ud survey-id.req)]])
      ==  :*
        %pass   /updates/(scot %ud survey-id.req)
        %agent  [src.bowl %forms]
        %watch  /survey/(scot %ud survey-id.req)
      ==  ==
    ==
  --
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
      [%slug ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      `this
    %-  %-  slog  ^-  tang  (need p.sign)  `this
      [%updates @ ~]
    ?+  -.sign  (on-agent:def wire sign)
      %watch-ack
      ?~  p.sign  (on-agent:def wire sign)
      %-  %-  slog  ^-  tang  (need p.sign)  `this
      ::
      %kick
      =+  id=(slav %ud i.t.wire)
      =+  m=(got:header-orm:fl header id)
      =.  status.m  %archived
      =+  h=(put:header-orm:fl header id m)
      `this(header h)
      ::
      %fact
      ?+  p.cage.sign  (on-agent:def wire sign)
        %forms-update
        =/  id=survey-id  (slav %ud i.t.wire)
        =+  upd=!<(update q.cage.sign)
        ?-  -.upd
            %meta
            =+  h=(put:header-orm:fl header id metadata.upd)
            `this(header h)
          ::
            %secs
            =+  s=(put:stuffing-orm:fl stuffing id sections.upd)
            `this(stuffing s)
          ::
            %init
          =,  enjs:format
          =+  h=(put:header-orm:fl header id metadata.upd)
          =+  s=(put:stuffing-orm:fl stuffing id sections.upd)
          =+  rc=(put:section-orm:fl *section 1 *answer-1)
          =+  rp=(put:sections-orm:fl *sections 1 *section)
          =+  rs=(~(put by *responses-1) %draft [our.bowl rp])
          =+  sm=(put:submissions-orm:fl submissions id rs)
          :_  this(header h, stuffing s, submissions sm)
          :~  :*
            %give  %fact  ~[/header/all]  %forms-cmd  
            !>
            ^-  cmd
            %-  pairs 
            :~
              ['flag' s+'requested']
              ['status' s+'summon']
              :-  'addr' 
              :-  %s
              %-  crip
              :(weld (trip (scot %p author.metadata.upd)) "/" (trip slug.metadata.upd))
            ==
          ==  ==
        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
