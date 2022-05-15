/-  *forms
/+  default-agent, dbug, fl=forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    =surveys
    =slugs
    =pending
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this
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
    %0  `this(state old)
  ==
::
++  on-poke   :: on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+    mark  (on-poke:def mark vase)
      %forms-action
    =^  cards  state
      (handle-action !<(action vase))
    [cards this]
  ==
  ++  handle-action
    |=  act=action
    ^-  (quip card _state)
    ?-  -.act
      %create
      ?>  =(src our):bowl
      ~|  'slug already exists'
      ?>  =(~ (~(get by slugs) slug.act))
      =+  id=(make-survey-id:fl now.bowl our.bowl)
      =+  survey=(create-survey:fl act our.bowl now.bowl)
      =/  new-slugs  ^+  slugs
        (~(put by slugs) slug.act id)
      =/  new-surveys  ^+  surveys
        (put:s-orm:fl surveys id survey)
      `state(surveys new-surveys, slugs new-slugs)
      ::
      %ask
      :_  state(pending (~(put in pending) [author.act slug.act]))
      :~  :*
        %pass   /slug
        %agent  [author.act %forms]
        %poke   %forms-action  !>  slug+slug.act
      ==  ==
      ::
      %slug
      =+  id=(~(get by slugs) slug.act)
      :_  state
      :~  :*
        %pass   /slug
        %agent  [src.bowl %forms]
        %poke   %forms-action  !>  
        ?~  id  fail+slug.act  id+[slug.act (need id)]
        ==  ==
      ::
      %fail
      `state(pending (~(del in pending) [src.bowl slug.act]))
      ::
      %id
      :_  state(pending (~(del in pending) [src.bowl slug.act]))
      :~  :*
      %pass   /updates/(scot %ud survey-id.act)
      %agent  [src.bowl %forms]
      %watch  /survey/(scot %ud survey-id.act)
      ==  ==
      ::
      %unsub
      :_  state
      :~  :*
      %pass   /updates/(scot %ud survey-id.act)
      %agent  [author.act %forms]  %leave  ~
      ==  ==
    ==
  --  
++  on-watch  ::on-watch:def
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%survey @ ~]
    =/  id=survey-id   (slav %ud i.t.path)
    =+  survey=+:(get:s-orm:fl surveys id)
    :_  this
    :~  :*
      %give  %fact  ~
      %forms-update  !>  `update`survey+survey
    ==  ==
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  ::on-agent:def
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
    [%slug ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      %-  (slog '%ask succeeded' ~)  `this
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    ::
    [%updates @ ~]
    ?+  -.sign  (on-agent:def wire sign)
      %watch-ack
      ?~  p.sign  (on-agent:def wire sign)
      %-  %-  slog  ^-  tang  (need p.sign)  `this
      ::
      %kick
      ~&  >>>  -.sign  `this
      ::
      %fact
      ?+  p.cage.sign  (on-agent:def wire sign)
        %forms-update
        =+  upd=!<(update q.cage.sign)
        ?-  -.upd  ::(on-agent:def wire sign)
          %survey
          =/  id=survey-id  (slav %ud i.t.wire)
          =/  new-surveys  ^+  surveys
            (put:s-orm:fl surveys id survey.upd)
          `this(surveys new-surveys)
        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--

